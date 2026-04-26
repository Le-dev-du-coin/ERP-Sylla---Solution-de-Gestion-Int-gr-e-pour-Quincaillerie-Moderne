from celery import shared_task
from django.apps import apps
from .services import send_whatsapp_text
import logging

logger = logging.getLogger(__name__)

@shared_task
def send_sale_summary_whatsapp_task(sale_id):
    """
    Envoie un résumé de la vente par texte via WhatsApp.
    """
    Sale = apps.get_model("sales", "Sale")
    try:
        sale = Sale.objects.get(id=sale_id)
        if not sale.customer_phone:
            return "Aucun numéro de téléphone."

        # Construction du message texte
        msg_type = "votre facture" if sale.type == "SALE" else "votre devis"
        
        message = (
            f"🌟 *ETS SYLLA MADJOU*\n\n"
            f"Bonjour, voici le résumé de {msg_type} N° *{sale.invoice_number}*.\n\n"
            f"💰 *Montant Total :* {sale.total_amount} F CFA\n"
            f"💳 *Paiement :* {sale.get_payment_method_display()}\n"
            f"📅 *Date :* {sale.created_at.strftime('%d/%m/%Y %H:%M')}\n\n"
            f"Merci pour votre confiance ! À bientôt."
        )

        result = send_whatsapp_text(sale.customer_phone, message)
        
        if result:
            logger.info(f"WhatsApp texte envoyé pour la vente {sale.invoice_number}")
            return f"Succès : {result}"
        else:
            return "Échec de l'envoi."

    except Exception as e:
        logger.error(f"Erreur task WhatsApp : {str(e)}")
        return str(e)
