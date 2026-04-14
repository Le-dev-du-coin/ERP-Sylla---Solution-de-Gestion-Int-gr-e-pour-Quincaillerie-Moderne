from django.test import TestCase
from django.contrib.auth import get_user_model
from erp_sylla.apps.inventory.models import Product, Warehouse, StockTransaction
from erp_sylla.apps.sales.models import Sale, SaleItem
from erp_sylla.apps.sales.services import complete_sale
from django.db.models import Sum

User = get_user_model()

class SalesServiceTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username="testuser", password="password", role="VENDEUR")
        self.warehouse = Warehouse.objects.create(name="Magasin Principal", is_active=True)
        self.product = Product.objects.create(
            name="Ciment",
            sku="CIM-001",
            sale_price_piece=5000,
            sale_price_carton=50000,
            conversion_factor=10,
            is_active=True
        )
        # On ajoute du stock initial (50 pièces)
        StockTransaction.objects.create(
            product=self.product,
            warehouse=self.warehouse,
            quantity=50,
            type=StockTransaction.Types.ENTREE,
            notes="Stock initial"
        )
        
        # Mock d'un panier (basket)
        class MockBasket:
            def __init__(self, items):
                self.items = items
                self.total_price = sum(i["total_line"] for i in items)
                self.total_items = len(items)
                self.cleared = False
            
            def __iter__(self):
                return iter(self.items)
            
            def clear(self):
                self.cleared = True

        self.basket_data = [
            {
                "product_id": self.product.id,
                "quantity": 2,
                "unit": "PIECE",
                "price": 5000,
                "total_line": 10000
            }
        ]
        self.basket = MockBasket(self.basket_data)

    def test_complete_sale_validates_and_reduces_stock(self):
        """Une VENTE doit déduire le stock physique."""
        # Calcul du stock initial via agrégation
        initial_stock = StockTransaction.objects.filter(
            product=self.product, 
            warehouse=self.warehouse
        ).aggregate(total=Sum("quantity"))["total"] or 0
        
        sale = complete_sale(
            basket=self.basket,
            user=self.user,
            warehouse_id=self.warehouse.id,
            sale_type=Sale.Types.VENTE,
            payment_method=Sale.PaymentMethods.CASH
        )
        
        self.assertEqual(sale.type, Sale.Types.VENTE)
        self.assertEqual(Sale.objects.count(), 1)
        self.assertEqual(SaleItem.objects.count(), 1)
        
        # Vérification du stock final (50 - 2 = 48)
        final_stock = StockTransaction.objects.filter(
            product=self.product, 
            warehouse=self.warehouse
        ).aggregate(total=Sum("quantity"))["total"] or 0
        
        self.assertEqual(final_stock, initial_stock - 2)
        self.assertTrue(self.basket.cleared)

    def test_complete_quote_does_not_reduce_stock(self):
        """Un DEVIS ne doit PAS déduire le stock physique."""
        initial_stock = StockTransaction.objects.filter(
            product=self.product, 
            warehouse=self.warehouse
        ).aggregate(total=Sum("quantity"))["total"] or 0
        
        sale = complete_sale(
            basket=self.basket,
            user=self.user,
            warehouse_id=self.warehouse.id,
            sale_type=Sale.Types.DEVIS,
            payment_method=Sale.PaymentMethods.CASH
        )
        
        self.assertEqual(sale.type, Sale.Types.DEVIS)
        # Le stock doit rester inchangé
        final_stock = StockTransaction.objects.filter(
            product=self.product, 
            warehouse=self.warehouse
        ).aggregate(total=Sum("quantity"))["total"] or 0
        self.assertEqual(final_stock, initial_stock)

    def test_insufficient_stock_raises_error(self):
        """Une erreur doit être levée si le stock est insuffisant."""
        # On demande 100 pièces alors qu'il n'en reste que 50
        self.basket.items[0]["quantity"] = 100
        
        with self.assertRaises(ValueError):
            complete_sale(
                basket=self.basket,
                user=self.user,
                warehouse_id=self.warehouse.id,
                sale_type=Sale.Types.VENTE,
                payment_method=Sale.PaymentMethods.CASH
            )
