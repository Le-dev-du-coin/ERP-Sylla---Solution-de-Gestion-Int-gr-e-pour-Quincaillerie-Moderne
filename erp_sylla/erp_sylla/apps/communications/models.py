from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
import uuid

class CommunicationConfig(models.Model):
    """Configuration unique pour les communications (Singleton)."""
    # Identifiants Wachap
    wachap_instance_id = models.CharField(_("ID de l'Instance Wachap"), max_length=100, default="")
    wachap_token = models.CharField(_("Token / Clé Secrète"), max_length=255, default="")
    
    # Version de l'ERP
    erp_version = models.CharField(_("Version de l'ERP"), max_length=20, default="v1.2.0")
    
    # Paramètres Gérant & Rapports
    manager_phone_1 = models.CharField(_("Numéro Gérant 1"), max_length=20, default="")
    manager_phone_2 = models.CharField(_("Numéro Gérant 2"), max_length=20, blank=True, null=True)
    
    report_time = models.TimeField(_("Heure du rapport journalier"), default="20:00")
    link_validity_hours = models.PositiveIntegerField(_("Validité lien (heures)"), default=48)
    
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = _("Configuration Communication")

    def __str__(self):
        return f"Configuration ERP {self.erp_version}"

    @classmethod
    def get_solo(cls):
        obj, created = cls.objects.get_or_create(id=1)
        return obj

class WhatsAppNotification(models.Model):
    """Suivi de chaque envoi WhatsApp."""
    class Status(models.TextChoices):
        PENDING = "PENDING", _("En attente")
        SENT = "SENT", _("Envoyé")
        FAILED = "FAILED", _("Échoué")
        EXPIRED = "EXPIRED", _("Expiré")

    sale = models.ForeignKey("sales.Sale", on_delete=models.CASCADE, related_name="notifications")
    phone = models.CharField(_("Téléphone"), max_length=20)
    status = models.CharField(_("Statut"), max_length=20, choices=Status.choices, default=Status.PENDING)
    
    token = models.UUIDField(default=uuid.uuid4, unique=True)
    expires_at = models.DateTimeField()
    
    message_id = models.CharField(_("ID Message Wachap"), max_length=100, blank=True, null=True)
    error_log = models.TextField(_("Log d'erreur"), blank=True, null=True)
    retry_count = models.PositiveIntegerField(default=0)
    
    created_at = models.DateTimeField(auto_now_add=True)
    sent_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        ordering = ["-created_at"]
        verbose_name = _("Notification WhatsApp")

    def is_expired(self):
        return timezone.now() > self.expires_at

    def __str__(self):
        return f"Notif {self.sale.invoice_number} -> {self.phone}"

class DailyReport(models.Model):
    """Stocke les rapports journaliers générés."""
    date = models.DateField(_("Date du rapport"), unique=True)
    token = models.UUIDField(default=uuid.uuid4, unique=True)
    total_sales = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = _("Rapport Journalier")
        verbose_name_plural = _("Rapports Journaliers")

    def __str__(self):
        return f"Rapport du {self.date}"
