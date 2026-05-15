from django.db import transaction, models
from erp_sylla.apps.inventory.models import StockTransaction, Warehouse

from .models import Customer, Payment, Sale, SaleItem, ProductReturn, ProductReturnItem


def process_product_return(sale, items_data, user, reason=""):
    """
    Traite un retour de produits partiel ou total.
    items_data : list de dict {'sale_item_id': int, 'quantity': int}
    """
    from erp_sylla.apps.inventory.models import Product
    from django.utils import timezone
    
    if sale.status == Sale.Status.CANCELLED:
        raise ValueError("Impossible de faire un retour sur une vente déjà annulée.")

    with transaction.atomic():
        total_refund = 0
        product_return = ProductReturn.objects.create(
            sale=sale,
            returned_by=user,
            reason=reason
        )

        for data in items_data:
            sale_item = SaleItem.objects.select_for_update().get(id=data['sale_item_id'], sale=sale)
            qty_to_return = int(data['quantity'])

            if qty_to_return <= 0:
                continue
            
            if qty_to_return > sale_item.remaining_quantity:
                raise ValueError(f"Quantité à retourner ({qty_to_return}) supérieure au reste ({sale_item.remaining_quantity}) pour {sale_item.product.name}.")

            # 1. Mise à jour de la ligne de vente
            sale_item.returned_quantity += qty_to_return
            sale_item.save()

            # 2. Création de la ligne de retour
            line_refund = qty_to_return * sale_item.unit_price
            total_refund += line_refund
            
            ProductReturnItem.objects.create(
                product_return=product_return,
                sale_item=sale_item,
                quantity=qty_to_return,
                unit_price=sale_item.unit_price
            )

            # 3. Remise en stock
            # On récupère le dernier entrepôt de sortie pour ce produit sur cette vente
            orig_trans = StockTransaction.objects.filter(
                product=sale_item.product,
                notes__icontains=sale.invoice_number,
                quantity__lt=0
            ).first()
            
            warehouse = orig_trans.warehouse if orig_trans else Warehouse.objects.filter(is_active=True).first()

            pieces_to_add = qty_to_return
            if sale_item.unit == "CARTON":
                pieces_to_add = qty_to_return * sale_item.product.conversion_factor

            StockTransaction.objects.create(
                product=sale_item.product,
                warehouse=warehouse,
                quantity=pieces_to_add,
                type=StockTransaction.Types.ENTREE,
                notes=f"Retour produit sur {sale.invoice_number}"
            )

        # 4. Finalisation du retour financier
        product_return.total_refund_amount = total_refund
        product_return.save()

        # 5. Ajustement solde client (si CREDIT)
        if sale.payment_method == Sale.PaymentMethods.CREDIT and sale.customer:
            customer = Customer.objects.select_for_update().get(id=sale.customer.id)
            customer.balance -= total_refund
            customer.save()
        
        # 6. Mise à jour statut vente si tout est retourné
        total_qty = sum(item.quantity for item in sale.items.all())
        total_returned = sum(item.returned_quantity for item in sale.items.all())
        
        if total_returned >= total_qty:
            sale.status = Sale.Status.CANCELLED
        else:
            sale.status = "PARTIAL_RETURN" # On peut ajouter ce statut ou laisser en COMPLETED avec flag
        
        sale.save()
        
        return product_return


def cancel_sale(sale, cancelled_by):
    """
    Annule une vente, remet les articles restants en stock et déduit le solde client restant.
    """
    from django.utils import timezone

    if sale.status == Sale.Status.CANCELLED:
        raise ValueError("Cette vente est déjà annulée.")

    with transaction.atomic():
        total_to_deduct = 0
        
        # 1. Remise en stock (Annulation des mouvements de sortie pour ce qui n'a pas été retourné)
        for item in sale.items.all():
            qty_remaining = item.remaining_quantity
            if qty_remaining <= 0:
                continue

            orig_trans = StockTransaction.objects.filter(
                product=item.product,
                notes__icontains=sale.invoice_number,
                quantity__lt=0
            ).first()
            
            warehouse = orig_trans.warehouse if orig_trans else Warehouse.objects.filter(is_active=True).first()

            pieces_to_add = qty_remaining
            if item.unit == "CARTON":
                pieces_to_add = qty_remaining * item.product.conversion_factor

            StockTransaction.objects.create(
                product=item.product,
                warehouse=warehouse,
                quantity=pieces_to_add,
                type=StockTransaction.Types.ENTREE,
                notes=f"Retour en stock suite annulation TOTALE {sale.invoice_number}"
            )
            
            total_to_deduct += (qty_remaining * item.unit_price)
            item.returned_quantity = item.quantity # Tout est considéré comme retourné
            item.save()

        # 2. Correction de la dette client (si vente à crédit)
        if sale.payment_method == Sale.PaymentMethods.CREDIT and sale.customer:
            customer = Customer.objects.select_for_update().get(id=sale.customer.id)
            customer.balance -= total_to_deduct
            customer.save()

        # 3. Mise à jour du statut
        sale.status = Sale.Status.CANCELLED
        prev_notes = sale.notes or ""
        sale.notes = f"{prev_notes}\nAnnulée TOTALEMENT par {cancelled_by.username} le {timezone.now().strftime('%d/%m/%Y %H:%M')}"
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
