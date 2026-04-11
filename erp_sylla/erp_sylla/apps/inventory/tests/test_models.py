import pytest
from erp_sylla.apps.inventory.models import Product

@pytest.mark.django_db
class TestProductModel:
    def test_product_creation_without_barcode(self):
        """Vérifie qu'un article peut être créé sans code barre."""
        product = Product.objects.create(
            name="Ciment 50kg",
            sku="CIM-001",
            purchase_price=4500,
            sale_price_piece=5000,
            sale_price_carton=48000,
            conversion_factor=10
        )
        assert product.pk is not None
        assert product.barcode is None
        assert product.name == "Ciment 50kg"

    def test_product_history_tracking(self):
        """Vérifie que les modifications sont tracées."""
        product = Product.objects.create(
            name="Fer 10",
            sku="FER-010",
            purchase_price=3000
        )
        assert product.history.count() == 1
        
        # Modification du prix
        product.purchase_price = 3200
        product.save()
        
        assert product.history.count() == 2
        latest_history = product.history.first()
        assert latest_history.purchase_price == 3200
