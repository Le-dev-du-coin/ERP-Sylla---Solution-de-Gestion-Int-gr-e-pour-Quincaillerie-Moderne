from django.test import TestCase
from django.contrib.auth import get_user_model
from erp_sylla.apps.inventory.models import Product, Warehouse, StockTransaction
from erp_sylla.apps.sales.models import Sale, SaleItem, Customer
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
            purchase_price=4500,
            sale_price_piece=5000,
            conversion_factor=1,
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
                self.update_totals()
                self.cleared = False
            
            def update_totals(self):
                self.total_price = sum(i["total_line"] for i in self.items)
                self.total_items = len(self.items)

            def __iter__(self):
                return iter(self.items)
            
            def clear(self):
                self.cleared = True

        self.basket_items = [
            {
                "product_id": self.product.id,
                "product": self.product,
                "quantity": 2,
                "unit": "PIECE",
                "price": 5000,
                "total_line": 10000
            }
        ]
        self.basket = MockBasket(self.basket_items)

    def test_complete_sale_reduces_stock(self):
        """Vérifie qu'une vente réduit le stock physique."""
        # On utilise une méthode plus directe pour obtenir le stock (Sum des transactions)
        initial_stock = StockTransaction.objects.filter(product=self.product, warehouse=self.warehouse).aggregate(total=Sum('quantity'))['total'] or 0
        
        complete_sale(
            basket=self.basket,
            user=self.user,
            warehouse_id=self.warehouse.id,
            sale_type=Sale.Types.VENTE,
            payment_method=Sale.PaymentMethods.CASH
        )
        
        final_stock = StockTransaction.objects.filter(product=self.product, warehouse=self.warehouse).aggregate(total=Sum('quantity'))['total'] or 0
        self.assertEqual(final_stock, initial_stock - 2)

    def test_insufficient_stock_raises_error(self):
        """Une erreur doit être levée si le stock est insuffisant."""
        # On demande 100 pièces alors qu'il n'en reste que 50
        self.basket.items[0]["quantity"] = 100
        self.basket.update_totals()
        
        with self.assertRaises(ValueError):
            complete_sale(
                basket=self.basket,
                user=self.user,
                warehouse_id=self.warehouse.id,
                sale_type=Sale.Types.VENTE,
                payment_method=Sale.PaymentMethods.CASH
            )

    def test_complete_sale_credit_updates_customer_balance(self):
        """Vérifie qu'une vente à crédit augmente le solde (dette) du client."""
        customer = Customer.objects.create(name="Client Test", phone="12345678")
        
        sale = complete_sale(
            basket=self.basket,
            user=self.user,
            warehouse_id=self.warehouse.id,
            sale_type=Sale.Types.VENTE,
            payment_method=Sale.PaymentMethods.CREDIT,
            customer_id=customer.id
        )
        
        # Le solde du client doit avoir augmenté du montant de la vente
        customer.refresh_from_db()
        self.assertEqual(customer.balance, 10000) # 2 * 5000
        self.assertEqual(sale.customer, customer)
        self.assertEqual(sale.payment_method, Sale.PaymentMethods.CREDIT)
