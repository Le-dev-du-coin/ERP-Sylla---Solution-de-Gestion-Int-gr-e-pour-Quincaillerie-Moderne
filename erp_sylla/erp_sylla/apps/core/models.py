from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from simple_history.models import HistoricalRecords
import uuid
from django.conf import settings

class AuditTestModel(models.Model):
    """Un modèle simple pour tester la traçabilité des données."""
    name = models.CharField("Nom", max_length=255)
    history = HistoricalRecords()

class ReleaseCode(models.Model):
    """Codes de déblocage pour les opérations sensibles."""
    class OperationTypes(models.TextChoices):
        DISCOUNT = "DISCOUNT", _("Remise exceptionnelle")
        CANCELLATION = "CANCEL", _("Annulation de vente")
        STOCK_ADJ = "STOCK", _("Ajustement de stock")

    code = models.CharField(_("Code"), max_length=10, unique=True)
    operation_type = models.CharField(_("Opération"), max_length=20, choices=OperationTypes.choices)
    is_used = models.BooleanField(_("Utilisé"), default=False)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="created_codes", null=True, blank=True)
    used_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True, related_name="used_codes")
    
    created_at = models.DateTimeField(auto_now_add=True)
    expires_at = models.DateTimeField()
    used_at = models.DateTimeField(null=True, blank=True)

    history = HistoricalRecords()

    def save(self, *args, **kwargs):
        if not self.code:
            self.code = str(uuid.uuid4().hex[:6]).upper()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.code} ({self.get_operation_type_display()})"

# --- NOUVEAUX MODÈLES POUR LES DÉPENSES ---

class ExpenseCategory(models.Model):
    """Catégories de dépenses (Loyer, Salaire, Transport, etc.)."""
    name = models.CharField(_("Nom de la catégorie"), max_length=100, unique=True)
    description = models.TextField(_("Description"), blank=True)

    class Meta:
        verbose_name = _("Catégorie de dépense")
        verbose_name_plural = _("Catégories de dépenses")

    def __str__(self):
        return self.name

class Expense(models.Model):
    """Enregistre une sortie d'argent de la caisse."""
    title = models.CharField(_("Motif / Titre"), max_length=255)
    category = models.ForeignKey(ExpenseCategory, on_delete=models.PROTECT, related_name="expenses")
    amount = models.PositiveIntegerField(_("Montant (F CFA)"))
    date = models.DateField(_("Date de la dépense"), default=timezone.now)
    
    notes = models.TextField(_("Notes complémentaires"), blank=True)
    receipt = models.FileField(_("Justificatif (Image/PDF)"), upload_to="expenses/receipts/", null=True, blank=True)
    
    recorded_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Dépense")
        verbose_name_plural = _("Dépenses")
        ordering = ["-date", "-created_at"]

    def __str__(self):
        return f"{self.title} - {self.amount} F CFA"

class DatabaseBackup(models.Model):
    """Trace les sauvegardes de la base de données."""
    class BackupType(models.TextChoices):
        MANUAL = "MANUAL", _("Manuelle")
        AUTO = "AUTO", _("Automatique")

    file = models.FileField(_("Fichier SQL"), upload_to="backups/")
    created_at = models.DateTimeField(auto_now_add=True)
    backup_type = models.CharField(_("Type"), max_length=10, choices=BackupType.choices, default=BackupType.AUTO)
    file_size = models.PositiveIntegerField(_("Taille (octets)"), default=0)
    
    class Meta:
        verbose_name = _("Sauvegarde")
        verbose_name_plural = _("Sauvegardes")
        ordering = ["-created_at"]

    def __str__(self):
        return f"Backup {self.get_backup_type_display()} - {self.created_at.strftime('%d/%m/%Y %H:%M')}"
