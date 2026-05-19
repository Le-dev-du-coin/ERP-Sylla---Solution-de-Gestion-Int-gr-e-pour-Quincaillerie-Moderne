import os
import requests
from django.conf import settings
from django.core.files.base import ContentFile
from django.template.loader import render_to_string
from django.utils import timezone
from django.urls import reverse
from celery import shared_task
from weasyprint import HTML
from datetime import timedelta

from erp_sylla.apps.sales.models import Sale, Payment
from erp_sylla.apps.communications.models import WhatsAppNotification, CommunicationConfig, DailyReport

@shared_task
def send_sale_summary_whatsapp_task(sale_id, is_retry=False):
    """
    Génère le PDF de la facture et l'envoie via l'API Wachap avec lien expirable.
    """
    try:
        sale = Sale.objects.get(id=sale_id)
        config = CommunicationConfig.get_solo()
        
        if not sale.customer_phone:
            return "Aucun numéro de téléphone fourni."

        # 1. Création ou récupération de la notification
        notification, created = WhatsAppNotification.objects.get_or_create(
            sale=sale,
            phone=sale.customer_phone,
            defaults={
                'expires_at': timezone.now() + timedelta(hours=config.link_validity_hours)
            }
        )
        
        if is_retry:
            notification.retry_count += 1
            notification.status = WhatsAppNotification.Status.PENDING
            notification.save()

        # 2. Génération du PDF
        filename = f"Facture-{sale.invoice_number}.pdf"
        directory = os.path.join(settings.MEDIA_ROOT, "invoices")
        if not os.path.exists(directory):
            os.makedirs(directory)
            
        file_path = os.path.join(directory, filename)
        html_string = render_to_string("sales/invoice_pdf.html", {"sale": sale})
        pdf_file = HTML(string=html_string, base_url=settings.APPS_DIR).write_pdf()
        with open(file_path, "wb") as f:
            f.write(pdf_file)
            
        # 3. Lien sécurisé
        download_path = reverse("communications:secure-pdf-download", kwargs={"token": notification.token})
        public_url = f"https://{settings.SITE_DOMAIN}{download_path}"
        
        # 4. Message
        msg_type = "facture" if sale.type == "SALE" else "devis"
        message = (
            f"Bonjour, merci pour votre confiance chez Ets Sylla Madjou.\n\n"
            f"Votre {msg_type} n° *{sale.invoice_number}* est disponible ici :\n{public_url}\n\n"
            f"⚠️ *Attention* : Ce lien expirera dans {config.link_validity_hours} heures. "
            f"Veuillez télécharger votre document avant le {notification.expires_at.strftime('%d/%m à %H:%M')}.\n\n"
            f"_Logiciel ERP Ets Sylla Madjou ({config.erp_version})_"
        )
        
        # 5. Envoi
        from erp_sylla.apps.core.services import send_whatsapp_message
        
        response = send_whatsapp_message(
            phone=sale.customer_phone,
            message=message,
            instance_id=config.wachap_instance_id,
            token=config.wachap_token
        )
        
        if "error" not in response:
            notification.status = WhatsAppNotification.Status.SENT
            notification.message_id = response.get("id")
            notification.sent_at = timezone.now()
            notification.error_log = None
        else:
            notification.status = WhatsAppNotification.Status.FAILED
            notification.error_log = response.get("error")
            
        notification.save()
        
        return f"Notification {notification.status} pour {sale.invoice_number}"
        
    except Sale.DoesNotExist:
        return f"Erreur : Vente {sale_id} introuvable."
    except Exception as e:
        return f"Erreur critique tâche WhatsApp : {str(e)}"

@shared_task
def send_payment_notification_whatsapp_task(payment_id):
    """
    Envoie un reçu de paiement via WhatsApp.
    """
    try:
        payment = Payment.objects.get(id=payment_id)
        customer = payment.customer
        config = CommunicationConfig.get_solo()
        
        if not customer.phone:
            return "Aucun numéro de téléphone pour ce client."

        # 1. Génération du reçu PDF
        html_string = render_to_string("sales/payment_receipt_pdf.html", {"payment": payment})
        pdf_file = HTML(string=html_string, base_url=settings.APPS_DIR).write_pdf()
        
        filename = f"Recu-{payment.reference}.pdf"
        directory = os.path.join(settings.MEDIA_ROOT, "receipts")
        if not os.path.exists(directory):
            os.makedirs(directory)
            
        file_path = os.path.join(directory, filename)
        with open(file_path, "wb") as f:
            f.write(pdf_file)
            
        # 2. Note: Ici on pourrait créer un WhatsAppNotification aussi pour le tracking
        # Pour faire simple on construit un lien direct (ou via token si on veut la sécurité d'expiration)
        # On va utiliser le même mécanisme de token sécurisé que pour les factures
        from erp_sylla.apps.communications.models import WhatsAppNotification
        notification = WhatsAppNotification.objects.create(
            sale=None, 
            payment=payment,
            phone=customer.phone,
            expires_at=timezone.now() + timedelta(hours=config.link_validity_hours),
            status=WhatsAppNotification.Status.PENDING
        )
        
        download_path = reverse("communications:secure-pdf-download", kwargs={"token": notification.token})
        public_url = f"https://{settings.SITE_DOMAIN}{download_path}"
        
        # 3. Message
        message = (
            f"✅ *Confirmation de Paiement*\n\n"
            f"Cher(e) {customer.name}, nous avons bien reçu votre versement de *{payment.amount} F CFA*.\n\n"
            f"📅 Date : {payment.created_at.strftime('%d/%m/%Y à %H:%M')}\n"
            f"💳 Mode : {payment.get_payment_method_display()}\n"
            f"📉 *Nouveau solde : {customer.balance} F CFA*\n\n"
            f"🔗 Votre reçu : {public_url}\n\n"
            f"⚠️ *Attention* : Ce lien expirera dans {config.link_validity_hours} heures. "
            f"Veuillez télécharger votre document avant le {notification.expires_at.strftime('%d/%m à %H:%M')}.\n\n"
            f"Merci pour votre confiance !\n"
            f"_Logiciel ERP Ets Sylla Madjou ({config.erp_version})_"
        )
        
        from erp_sylla.apps.core.services import send_whatsapp_message
        send_whatsapp_message(
            phone=customer.phone,
            message=message,
            instance_id=config.wachap_instance_id,
            token=config.wachap_token
        )
        
        return f"Reçu envoyé à {customer.name}"
        
    except Payment.DoesNotExist:
        return f"Erreur : Paiement {payment_id} introuvable."
    except Exception as e:
        return f"Erreur envoi reçu : {str(e)}"

@shared_task
def send_daily_report_task():
    """Génère et envoie le rapport de ventes journalier au gérant."""
    import logging
    logger = logging.getLogger(__name__)
    
    today = timezone.now().date()
    sales = Sale.objects.filter(created_at__date=today, type="SALE")
    total_day = sum(s.total_amount for s in sales)
    count = sales.count()
    
    config = CommunicationConfig.get_solo()
    if not config.manager_phone_1:
        logger.error("Aucun numéro de gérant configuré pour le rapport.")
        return "Aucun numéro de gérant configuré."

    try:
        # 1. Rapport PDF
        from django.db.models import Sum
        payments = sales.values('payment_method').annotate(total=Sum('total_amount'))
        report_obj, _ = DailyReport.objects.get_or_create(date=today, defaults={'total_sales': total_day})
        
        html_string = render_to_string("sales/daily_report_pdf.html", {
            "date": today,
            "sales": sales,
            "total_day": total_day,
            "payments": payments
        })
        pdf_file = HTML(string=html_string, base_url=settings.APPS_DIR).write_pdf()
        
        filename = f"Rapport-Journalier-{today.strftime('%Y%m%d')}.pdf"
        directory = os.path.join(settings.MEDIA_ROOT, "reports")
        if not os.path.exists(directory):
            os.makedirs(directory)
        
        with open(os.path.join(directory, filename), "wb") as f:
            f.write(pdf_file)

        # 2. Lien sécurisé
        download_path = reverse("communications:report-download", kwargs={"token": report_obj.token})
        public_url = f"https://{settings.SITE_DOMAIN}{download_path}"
            
        message = (
            f"📊 *RAPPORT JOURNALIER - {today.strftime('%d/%m/%Y')}*\n\n"
            f"✅ Ventes validées : {count}\n"
            f"💰 CA Total : *{total_day} F CFA*\n\n"
            f"🔗 *Détail complet (PDF) :*\n{public_url}\n\n"
            f"_Généré à {timezone.now().strftime('%H:%M')} par ERP Ets Sylla Madjou ({config.erp_version})_"
        )
        
        from erp_sylla.apps.core.services import send_whatsapp_message
        
        phones = [config.manager_phone_1]
        if config.manager_phone_2:
            phones.append(config.manager_phone_2)

        results = []
        for phone in phones:
            # Création d'une notification pour le suivi dans le dashboard
            notif = WhatsAppNotification.objects.create(
                phone=phone,
                expires_at=timezone.now() + timedelta(days=7), # Les rapports durent plus longtemps
                status=WhatsAppNotification.Status.PENDING
            )
            
            resp = send_whatsapp_message(
                phone=phone,
                message=message,
                instance_id=config.wachap_instance_id,
                token=config.wachap_token
            )
            
            if "error" not in resp:
                notif.status = WhatsAppNotification.Status.SENT
                notif.message_id = resp.get("id")
                notif.sent_at = timezone.now()
            else:
                notif.status = WhatsAppNotification.Status.FAILED
                notif.error_log = resp.get("error")
                logger.error(f"Échec envoi rapport à {phone}: {resp.get('error')}")
            
            notif.save()
            results.append(f"{phone}: {notif.status}")
            
        return f"Rapport {today}: " + ", ".join(results)

    except Exception as e:
        logger.exception("Erreur critique lors de la génération du rapport journalier")
        return f"Erreur critique : {str(e)}"
