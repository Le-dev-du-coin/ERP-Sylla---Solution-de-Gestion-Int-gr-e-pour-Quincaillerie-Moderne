from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from simple_history.models import HistoricalRecords
from erp_sylla.apps.inventory.models import Product, Warehouse


class Sale(models.Model):
    """
    Représente une transaction de vente ou un devis.
    """
    class Types(models.TextChoices):
        VENTE = "SALE", _("Vente validée")
        DEVIS = "QUOTE", _("Devis / Proforma")

    class PaymentMethods(models.TextChoices):
        CASH = "CASH", _("Espèces")
        MOBILE_MONEY = "MOMO", _("Mobile Money")
        TRANSFER = "TRANSFER", _("Virement")
        CREDIT = "CREDIT", _("Crédit / Dette")

    class Status(models.TextChoices):
        PENDING = "PENDING", _("En attente")
        COMPLETED = "COMPLETED", _("Terminée")
        CANCELLED = "CANCELLED", _("Annulée")

    invoice_number = models.CharField(_("N° Facture/Devis"), max_length=50, unique=True)
    status = models.CharField(_("Statut"), max_length=20, choices=Status.choices, default=Status.COMPLETED)
    type = models.CharField(_("Type"), max_length=10, choices=Types.choices, default=Types.VENTE)
    
    seller = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.SET_NULL, 
        null=True, 
        related_name="sales"
    )
    
    # Montants financiers (Entiers F CFA)
    total_amount = models.PositiveIntegerField(_("Montant Total"), default=0)
    payment_method = models.CharField(
        _("Mode de paiement"), 
        max_length=20, 
        choices=PaymentMethods.choices, 
        default=PaymentMethods.CASH
    )
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Vente")
        verbose_name_plural = _("Ventes")
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.invoice_number} ({self.get_type_display()})"

    def save(self, *args, **kwargs):
        if not self.invoice_number:
            # Génération d'un numéro auto (ex: FAC-20260411-0001)
            import datetime
            prefix = "FAC" if self.type == self.Types.VENTE else "PRO"
            date_str = datetime.date.today().strftime("%Y%m%d")
            # On compte les ventes du jour pour le numéro séquentiel
            count = Sale.objects.filter(created_at__date=datetime.date.today()).count() + 1
            self.invoice_number = f"{prefix}-{date_str}-{count:04d}"
        super().save(*args, **kwargs)


class SaleItem(models.Model):
    """
    Ligne de détail d'une vente.
    """
    sale = models.ForeignKey(Sale, on_delete=models.CASCADE, related_name="items")
    product = models.ForeignKey(Product, on_delete=models.PROTECT, related_name="sale_items")
    
    quantity = models.PositiveIntegerField(_("Quantité"))
    unit = models.CharField(_("Unité"), max_length=10, choices=[("PIECE", "Pièce"), ("CARTON", "Carton")])
    
    unit_price = models.PositiveIntegerField(_("Prix unitaire appliqué"))
    total_line = models.PositiveIntegerField(_("Total ligne"))

    def __str__(self):
        return f"{self.quantity} {self.unit} x {self.product.name}"
