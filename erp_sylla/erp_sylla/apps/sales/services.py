from django.db import transaction, models
from erp_sylla.apps.inventory.models import StockTransaction, Warehouse
from .models import Sale, SaleItem

def complete_sale(basket, user, warehouse_id, sale_type, payment_method, notes=""):
    """
    Finalise une vente ou un devis.
    Déstocke automatiquement si c'est une VENTE.
    """
    warehouse = Warehouse.objects.get(id=warehouse_id)
    
    with transaction.atomic():
        # 1. Création de la vente
        sale = Sale.objects.create(
            type=sale_type,
            status=Sale.Status.COMPLETED if sale_type == Sale.Types.VENTE else Sale.Status.PENDING,
            seller=user,
            payment_method=payment_method,
            total_amount=basket.total_price
        )

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
        
        return sale
