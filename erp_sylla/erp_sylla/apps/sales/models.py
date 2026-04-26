from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from simple_history.models import HistoricalRecords
from erp_sylla.apps.inventory.models import Product, Warehouse


class Customer(models.Model):
    """
    Fiche client pour le suivi des dettes et l'historique d'achats.
    """
    name = models.CharField(_("Nom Complet"), max_length=255)
    phone = models.CharField(_("Téléphone WhatsApp"), max_length=20, blank=True, null=True)
    address = models.TextField(_("Adresse"), blank=True, null=True)
    
    # Solde : Positif = Dette du client, Négatif = Avoir
    balance = models.IntegerField(_("Solde (F CFA)"), default=0)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Client")
        verbose_name_plural = _("Clients")
        ordering = ["name"]

    def __str__(self):
        return f"{self.name} ({self.phone or 'Pas de tel'})"


class Payment(models.Model):
    """
    Enregistre un versement effectué par un client pour réduire sa dette.
    """
    class PaymentMethods(models.TextChoices):
        CASH = "CASH", _("Espèces")
        ORANGE_MONEY = "ORANGE", _("Orange Money")
        WAVE = "WAVE", _("Wave")
        MOOV_MONEY = "MOOV", _("Moov Money")
        CHEQUE = "CHEQUE", _("Chèque")

    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name="payments")
    amount = models.PositiveIntegerField(_("Montant versé"))
    payment_method = models.CharField(_("Mode de paiement"), max_length=20, choices=PaymentMethods.choices, default=PaymentMethods.CASH)
    reference = models.CharField(_("Référence / N° de reçu"), max_length=50, unique=True)
    notes = models.TextField(_("Notes"), blank=True)
    
    balance_after = models.IntegerField(_("Solde après versement"), null=True, blank=True)
    received_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Paiement Client")
        verbose_name_plural = _("Paiements Clients")
        ordering = ["-created_at"]

    def __str__(self):
        return f"Paiement {self.reference} - {self.customer.name}"

    def save(self, *args, **kwargs):
        if not self.reference:
            import datetime
            date_to_use = self.created_at.date() if self.created_at else datetime.date.today()
            date_str = date_to_use.strftime("%Y%m%d")
            last_payment = Payment.objects.filter(reference__startswith=f"PAY-{date_str}-").order_by('reference').last()
            if last_payment:
                try:
                    last_seq = int(last_payment.reference.split('-')[-1])
                    new_seq = last_seq + 1
                except (ValueError, IndexError):
                    new_seq = 1
            else:
                new_seq = 1
            self.reference = f"PAY-{date_str}-{new_seq:04d}"
        super().save(*args, **kwargs)


class Sale(models.Model):
    """
    Représente une transaction de vente ou un devis.
    """
    class Types(models.TextChoices):
        VENTE = "SALE", _("Vente validée")
        DEVIS = "QUOTE", _("Devis / Proforma")

    class PaymentMethods(models.TextChoices):
        CASH = "CASH", _("Espèces")
        ORANGE_MONEY = "ORANGE", _("Orange Money")
        WAVE = "WAVE", _("Wave")
        MOOV_MONEY = "MOOV", _("Moov Money")
        CHEQUE = "CHEQUE", _("Chèque")
        CREDIT = "CREDIT", _("Crédit / Dette")

    class Status(models.TextChoices):
        PENDING = "PENDING", _("En attente")
        COMPLETED = "COMPLETED", _("Terminée")
        CANCELLED = "CANCELLED", _("Annulée")

    invoice_number = models.CharField(_("N° Facture/Devis"), max_length=50, unique=True)
    status = models.CharField(_("Statut"), max_length=20, choices=Status.choices, default=Status.COMPLETED)
    type = models.CharField(_("Type"), max_length=10, choices=Types.choices, default=Types.VENTE)
    
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True, blank=True, related_name="sales")
    customer_phone = models.CharField(_("Téléphone Client (WhatsApp)"), max_length=20, blank=True, null=True)
    customer_name = models.CharField(_("Nom du client (Passage)"), max_length=255, blank=True, null=True)
    
    seller = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, related_name="sales")
    payment_method = models.CharField(_("Mode de paiement"), max_length=20, choices=PaymentMethods.choices, default=PaymentMethods.CASH)
    
    total_amount = models.IntegerField(_("Montant total"), default=0)
    notes = models.TextField(_("Notes"), blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Vente / Devis")
        verbose_name_plural = _("Ventes / Devis")
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.invoice_number} - {self.total_amount} F CFA"

    def save(self, *args, **kwargs):
        if not self.invoice_number:
            import datetime
            from django.db.models import Max
            prefix = "FAC" if self.type == self.Types.VENTE else "PRO"
            date_str = datetime.date.today().strftime("%Y%m%d")
            last_invoice = Sale.objects.filter(invoice_number__startswith=f"{prefix}-{date_str}-").aggregate(Max('invoice_number'))['invoice_number__max']
            if last_invoice:
                try:
                    last_seq = int(last_invoice.split('-')[-1])
                    new_seq = last_seq + 1
                except (ValueError, IndexError):
                    new_seq = 1
            else:
                new_seq = 1
            self.invoice_number = f"{prefix}-{date_str}-{new_seq:04d}"
        super().save(*args, **kwargs)


class SaleItem(models.Model):
    """
    Une ligne d'article dans une vente ou un devis.
    """
    sale = models.ForeignKey(Sale, on_delete=models.CASCADE, related_name="items")
    product = models.ForeignKey(Product, on_delete=models.PROTECT, related_name="sale_items")
    quantity = models.PositiveIntegerField(_("Quantité"))
    unit = models.CharField(_("Unité"), max_length=10, choices=[("PIECE", "Pièce"), ("CARTON", "Carton")])
    unit_price = models.PositiveIntegerField(_("Prix unitaire (au moment de la vente)"))
    total_line = models.PositiveIntegerField(_("Total ligne"), default=0)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Ligne de vente")
        verbose_name_plural = _("Lignes de vente")
        ordering = ["-id"]

    def __str__(self):
        return f"{self.quantity} {self.unit} x {self.product.name}"

    def save(self, *args, **kwargs):
        self.total_line = self.quantity * self.unit_price
        super().save(*args, **kwargs)
