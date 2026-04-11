import pytest
from erp_sylla.apps.inventory.models import Product, Warehouse, StockTransaction

@pytest.mark.django_db
class TestStockLedger:
    def setup_method(self):
        self.warehouse = Warehouse.objects.create(name="Dépôt Test")
        self.product = Product.objects.create(
            name="Ciment",
            sku="CIM-TEST",
            conversion_factor=10 # 1 carton = 10 sacs
        )

    def test_stock_calculation(self):
        """Vérifie que le stock est calculé correctement via les transactions."""
        # 1. Entrée de 50 sacs
        StockTransaction.objects.create(
            product=self.product,
            warehouse=self.warehouse,
            quantity=50,
            type=StockTransaction.Types.ENTREE
        )
        assert self.product.total_stock == 50
        
        # 2. Sortie de 5 sacs
        StockTransaction.objects.create(
            product=self.product,
            warehouse=self.warehouse,
            quantity=-5,
            type=StockTransaction.Types.SORTIE
        )
        assert self.product.total_stock == 45

    def test_formatted_stock(self):
        """Vérifie le formatage lisible (cartons & pièces)."""
        # 25 sacs = 2 cartons (de 10) & 5 sacs
        StockTransaction.objects.create(
            product=self.product,
            warehouse=self.warehouse,
            quantity=25,
            type=StockTransaction.Types.ENTREE
        )
        assert self.product.formatted_stock == "2 cartons & 5 pièces"
