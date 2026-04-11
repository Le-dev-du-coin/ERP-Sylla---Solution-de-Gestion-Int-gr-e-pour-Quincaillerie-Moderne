from django.db import models
from simple_history.models import HistoricalRecords


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
