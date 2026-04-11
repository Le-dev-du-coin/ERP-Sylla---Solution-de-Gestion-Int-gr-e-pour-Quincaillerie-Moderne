from django.db import models
from django.utils.translation import gettext_lazy as _
from simple_history.models import HistoricalRecords


class Product(models.Model):
    """
    Représente un article du catalogue de la quincaillerie.
    Gère les prix en F CFA (entiers) et la conversion Carton -> Pièce.
    """
    name = models.CharField(_("Désignation"), max_length=255)
    description = models.TextField(_("Description"), blank=True)
    sku = models.CharField(_("SKU / Réf interne"), max_length=50, unique=True, blank=True)
    barcode = models.CharField(_("Code Barre"), max_length=100, blank=True, null=True, unique=True)
    
    # Prix en F CFA (Entiers)
    purchase_price = models.PositiveIntegerField(_("Prix d'achat"), default=0)
    sale_price_piece = models.PositiveIntegerField(_("Prix de vente (Pièce)"), default=0)
    sale_price_carton = models.PositiveIntegerField(_("Prix de vente (Carton)"), default=0)
    
    # Logique de conversion
    conversion_factor = models.PositiveIntegerField(
        _("Facteur de conversion"), 
        help_text=_("Nombre de pièces contenues dans un carton."),
        default=1
    )
    
    is_active = models.BooleanField(_("Actif"), default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Article")
        verbose_name_plural = _("Articles")
        ordering = ["name"]

    def save(self, *args, **kwargs):
        if not self.sku:
            import uuid
            from django.utils.text import slugify
            suffix = str(uuid.uuid4())[:4].upper()
            self.sku = f"{slugify(self.name).upper()}-{suffix}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} ({self.sku})"
