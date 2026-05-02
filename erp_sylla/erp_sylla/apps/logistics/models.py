from django.db import models
from django.utils.translation import gettext_lazy as _
from simple_history.models import HistoricalRecords

class LogisticsSupplier(models.Model):
    """Fournisseurs pour la logistique (importation)."""
    name = models.CharField(_("Nom du fournisseur"), max_length=255)
    country = models.CharField(_("Pays"), max_length=100, blank=True)
    contact_person = models.CharField(_("Contact"), max_length=255, blank=True)
    phone = models.CharField(_("Téléphone"), max_length=50, blank=True)
    email = models.EmailField(_("Email"), blank=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Fournisseur Logistique")
        verbose_name_plural = _("Fournisseurs Logistique")
        ordering = ["name"]

    def __str__(self):
        return self.name

class Container(models.Model):
    """Suivi des conteneurs d'importation."""
    class Status(models.TextChoices):
        ORDERED = "ORDERED", _("Commandé")
        LOADING = "LOADING", _("Chargement")
        IN_TRANSIT = "IN_TRANSIT", _("En mer (Transit)")
        ARRIVED_PORT = "ARRIVED_PORT", _("Arrivé au port")
        CUSTOMS = "CUSTOMS", _("Dédouanement")
        ARRIVED_WAREHOUSE = "ARRIVED", _("Arrivé à l'entrepôt")
        CANCELLED = "CANCELLED", _("Annulé")

    container_number = models.CharField(_("N° Conteneur"), max_length=100, unique=True)
    order_reference = models.CharField(_("Réf Commande"), max_length=100, blank=True)
    supplier = models.ForeignKey(LogisticsSupplier, on_delete=models.CASCADE, related_name="containers", verbose_name=_("Fournisseur"))
    
    # Logistique
    origin_port = models.CharField(_("Port de départ"), max_length=100, blank=True)
    destination_port = models.CharField(_("Port d'arrivée"), max_length=100, blank=True)
    main_product = models.CharField(_("Produit principal"), max_length=255, blank=True)
    container_type = models.CharField(_("Type conteneur"), max_length=50, blank=True) # ex: 20', 40'
    quantity_packages = models.PositiveIntegerField(_("Quantité / Colis"), default=0)
    
    # Dates
    order_date = models.DateField(_("Date commande"), null=True, blank=True)
    loading_date = models.DateField(_("Date chargement"), null=True, blank=True)
    etd = models.DateField(_("ETD (Départ prévu)"), null=True, blank=True)
    eta = models.DateField(_("ETA (Arrivée prévue)"), null=True, blank=True)
    actual_arrival_date = models.DateField(_("Date arrivée réelle"), null=True, blank=True)
    
    # Finances
    merchandise_value = models.PositiveBigIntegerField(_("Valeur marchandise (FCFA)"), default=0)
    total_expenses = models.PositiveBigIntegerField(_("Total frais (FCFA)"), default=0)
    
    status = models.CharField(_("Statut"), max_length=20, choices=Status.choices, default=Status.ORDERED)
    observation = models.TextField(_("Observation"), blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Conteneur")
        verbose_name_plural = _("Conteneurs")
        ordering = ["-eta", "-created_at"]

    def __str__(self):
        return f"{self.container_number} ({self.supplier.name})"

    @property
    def global_cost(self):
        """Coût global = Valeur marchandise + Frais."""
        return self.merchandise_value + self.total_expenses

    @property
    def delay_days(self):
        """Calcule le retard en jours par rapport à l'ETA."""
        from datetime import date
        if self.actual_arrival_date and self.eta:
            diff = (self.actual_arrival_date - self.eta).days
            return max(0, diff)
        elif self.eta and self.status not in [self.Status.ARRIVED_WAREHOUSE, self.Status.CANCELLED]:
            diff = (date.today() - self.eta).days
            return max(0, diff)
        return 0

class ContainerExpense(models.Model):
    """Détail des frais liés à un conteneur."""
    container = models.ForeignKey(Container, on_delete=models.CASCADE, related_name="expenses")
    label = models.CharField(_("Libellé du frais"), max_length=255)
    amount = models.PositiveBigIntegerField(_("Montant (FCFA)"))
    date = models.DateField(_("Date du frais"), auto_now_add=True)
    notes = models.TextField(_("Notes"), blank=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Frais Conteneur")
        verbose_name_plural = _("Frais Conteneurs")

    def __str__(self):
        return f"{self.label} - {self.container.container_number}"

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        # Recalculer le total des frais du conteneur
        from django.db.models import Sum
        total = self.container.expenses.aggregate(total=Sum('amount'))['total'] or 0
        self.container.total_expenses = total
        self.container.save()
