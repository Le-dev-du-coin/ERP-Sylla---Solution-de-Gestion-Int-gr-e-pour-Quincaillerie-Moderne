from django.apps import AppConfig
from django.db.models.signals import post_save


class CommunicationsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "erp_sylla.apps.communications"
    verbose_name = "Communications & Notifications"

    def ready(self):
        """Planifie automatiquement la tâche du rapport journalier."""
        try:
            from django_celery_beat.models import PeriodicTask, CrontabSchedule
            import json
            from .models import CommunicationConfig

            # On récupère la config (ou on la crée par défaut)
            config = CommunicationConfig.get_solo()
            
            # Création du planning Crontab
            schedule, _ = CrontabSchedule.objects.get_or_create(
                minute=config.report_time.minute,
                hour=config.report_time.hour,
                day_of_week="*",
                day_of_month="*",
                month_of_year="*",
            )

            # Création ou mise à jour de la tâche périodique
            PeriodicTask.objects.update_or_create(
                name="Envoi Rapport Journalier WhatsApp",
                defaults={
                    "crontab": schedule,
                    "task": "erp_sylla.apps.sales.tasks.send_daily_report_task",
                    "args": json.dumps([]),
                }
            )
        except Exception:
            # Éviter de bloquer le démarrage si les tables ne sont pas encore prêtes (ex: migrations)
            pass

