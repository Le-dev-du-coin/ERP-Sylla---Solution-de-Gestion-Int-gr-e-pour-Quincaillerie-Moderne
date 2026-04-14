from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from simple_history.models import HistoricalRecords
import uuid


class AuditTestModel(models.Model):
    """Un modèle simple pour tester la traçabilité des données."""
    name = models.CharField("Nom", max_length=255)
    description = models.TextField("Description", blank=True)
    is_active = models.BooleanField("Actif", default=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = "Modèle d'Audit Test"
        verbose_name_plural = "Modèles d'Audit Test"

    def __str__(self):
        return self.name


class ReleaseCode(models.Model):
    """
    Code de déblocage temporaire généré par un gérant pour autoriser une opération sensible.
    """
    class OperationTypes(models.TextChoices):
        DISCOUNT = "DISCOUNT", _("Remise exceptionnelle")
        CANCELLATION = "CANCEL", _("Annulation de transaction")
        STOCK_ADJ = "STOCK_ADJ", _("Ajustement de stock manuel")
        OTHER = "OTHER", _("Autre opération sensible")

    code = models.CharField(_("Code"), max_length=10, unique=True)
    operation_type = models.CharField(
        _("Type d'opération"), 
        max_length=20, 
        choices=OperationTypes.choices, 
        default=OperationTypes.DISCOUNT
    )
    
    is_used = models.BooleanField(_("Utilisé"), default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    expires_at = models.DateTimeField(_("Expire le"))
    
    created_by = models.ForeignKey(
        "users.User", 
        on_delete=models.SET_NULL, 
        null=True, 
        related_name="generated_codes"
    )
    
    used_by = models.ForeignKey(
        "users.User", 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True,
        related_name="used_codes"
    )
    used_at = models.DateTimeField(null=True, blank=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Code de déblocage")
        verbose_name_plural = _("Codes de déblocage")
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.code} ({self.get_operation_type_display()})"

    def save(self, *args, **kwargs):
        if not self.code:
            # Génération d'un code court unique
            self.code = str(uuid.uuid4().hex[:6]).upper()
        if not self.expires_at:
            # Expire par défaut après 1 heure
            self.expires_at = timezone.now() + timezone.timedelta(hours=1)
        super().save(*args, **kwargs)

    @property
    def is_valid(self):
        """Vérifie si le code est encore utilisable."""
        return not self.is_used and self.expires_at > timezone.now()
