from django.db import transaction, models
from erp_sylla.apps.inventory.models import StockTransaction, Warehouse

from .models import Customer, Payment, Sale, SaleItem


def cancel_sale(sale, cancelled_by):
    """
    Annule une vente, remet les articles en stock et déduit la dette client si nécessaire.
    """
    from django.utils import timezone

    if sale.status == Sale.Status.CANCELLED:
        raise ValueError("Cette vente est déjà annulée.")

    with transaction.atomic():
        # 1. Remise en stock (Annulation des mouvements de sortie)
        for item in sale.items.all():
            # On cherche la transaction de stock correspondante
            # On en crée une inverse (ENTREE pour compenser la SORTIE)
            # On récupère l'entrepôt depuis la transaction de sortie initiale
            orig_trans = StockTransaction.objects.filter(
                product=item.product,
                quantity=-item.quantity, # On cherche la sortie initiale
                notes__icontains=sale.invoice_number
            ).first()
            
            warehouse = orig_trans.warehouse if orig_trans else Warehouse.objects.filter(is_active=True).first()

            StockTransaction.objects.create(
                product=item.product,
                warehouse=warehouse,
                quantity=item.quantity, # Retour positif
                type=StockTransaction.Types.ENTREE,
                notes=f"Retour en stock suite annulation {sale.invoice_number}"
            )

        # 2. Correction de la dette client (si vente à crédit)
        if sale.payment_method == Sale.PaymentMethods.CREDIT and sale.customer:
            customer = Customer.objects.select_for_update().get(id=sale.customer.id)
            customer.balance -= sale.total_amount
            customer.save()

        # 3. Mise à jour du statut
        sale.status = Sale.Status.CANCELLED
        prev_notes = sale.notes or ""
        sale.notes = f"{prev_notes}\nAnnulée par {cancelled_by.username} le {timezone.now().strftime('%d/%m/%Y %H:%M')}"
        sale.save()

        return sale


def process_payment(customer, amount, method, received_by, notes=""):
    """
    Enregistre un versement client et met à jour son solde de manière atomique.
    """
    amount = int(amount)
    with transaction.atomic():
        # Verrouillage du client
        customer = Customer.objects.select_for_update().get(id=customer.id)
        
        # Validation : On ne peut pas verser plus que la dette (sauf si on accepte les avoirs, mais ici on bloque)
        if amount > customer.balance:
            raise ValueError(f"Le versement ({amount} F CFA) ne peut pas être supérieur à la dette actuelle ({customer.balance} F CFA).")
        
        # Déduction du solde
        customer.balance -= amount
        customer.save()
        
        # Création du record de paiement
        payment = Payment.objects.create(
            customer=customer,
            amount=amount,
            payment_method=method,
            received_by=received_by,
            balance_after=customer.balance,
            notes=notes
        )
        
        # Déclenchement de la notification WhatsApp (Asynchrone)
        if customer.phone:
            from .tasks import send_payment_notification_whatsapp_task
            transaction.on_commit(lambda: send_payment_notification_whatsapp_task.delay(payment.id))
            
        return payment


def complete_sale(basket, user, warehouse_id, sale_type, payment_method, customer_phone="", customer_id=None, customer_name="", notes=""):
    """
    Finalise une vente ou un devis.
    Déstocke automatiquement si c'est une VENTE.
    Gère la dette client si paiement CREDIT.
    """
    warehouse = Warehouse.objects.get(id=warehouse_id)
    
    with transaction.atomic():
        # 0. Récupération du client
        customer = None
        if customer_id and str(customer_id).strip():
            # On utilise select_for_update pour verrouiller le solde client
            customer = Customer.objects.select_for_update().get(id=customer_id)
            # Priorité au téléphone et nom de la fiche client si non fournis
            if not customer_phone:
                customer_phone = customer.phone
            if not customer_name:
                customer_name = customer.name

        # 1. Création de la vente
        sale = Sale.objects.create(
            type=sale_type,
            status=Sale.Status.COMPLETED if sale_type == Sale.Types.VENTE else Sale.Status.PENDING,
            seller=user,
            payment_method=payment_method,
            total_amount=basket.total_price,
            customer_phone=customer_phone,
            customer_name=customer_name or "Client de passage",
            customer=customer
        )

        # 1.b Gestion de la DETTE (Seulement pour les ventes validées à crédit)
        if sale_type == Sale.Types.VENTE and payment_method == Sale.PaymentMethods.CREDIT and customer:
            customer.balance += sale.total_amount
            customer.save()

        # 2. Création des lignes et déstockage
        for item in basket:
            # Création de la ligne de vente
            SaleItem.objects.create(
                sale=sale,
                product_id=item["product_id"],
                quantity=item["quantity"],
                unit=item["unit"],
                unit_price=item["price"],
                total_line=item["total_line"]
            )

            # 3. Déstockage (Uniquement pour les ventes réelles)
            if sale_type == Sale.Types.VENTE:
                from erp_sylla.apps.inventory.models import Product
                # VERROUILLAGE (select_for_update) pour éviter les race conditions
                product = Product.objects.select_for_update().get(id=item["product_id"])
                
                pieces_to_remove = item["quantity"]
                if item["unit"] == "CARTON":
                    pieces_to_remove = item["quantity"] * product.conversion_factor
                
                # VÉRIFICATION DU STOCK (Anti-Négatif)
                current_stock = product.stock_transactions.filter(warehouse=warehouse).aggregate(total=models.Sum("quantity"))["total"] or 0
                
                # On compare toujours en pièces
                if current_stock < pieces_to_remove:
                    raise ValueError(f"Stock insuffisant : vous demandez {item['quantity']} {item['unit'].lower()}(s) ({pieces_to_remove} pcs), mais il n'en reste que {current_stock} dans {warehouse.name}.")


                StockTransaction.objects.create(
                    product=product,
                    warehouse=warehouse,
                    quantity=-abs(pieces_to_remove),
                    type=StockTransaction.Types.SORTIE,
                    notes=f"Vente {sale.invoice_number}"
                )

        # 4. Vidage du panier
        basket.clear()
        
        # 5. Déclenchement de l'envoi WhatsApp (Asynchrone)
        if sale.customer_phone:
            from erp_sylla.apps.sales.tasks import send_sale_summary_whatsapp_task
            transaction.on_commit(lambda: send_sale_summary_whatsapp_task.delay(sale.id))
        
        return sale
