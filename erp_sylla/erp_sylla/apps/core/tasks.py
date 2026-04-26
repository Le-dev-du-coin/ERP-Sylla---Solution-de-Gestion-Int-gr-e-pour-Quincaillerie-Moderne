from celery import shared_task
from .services import BackupService
from .models import DatabaseBackup
import logging

logger = logging.getLogger(__name__)

@shared_task
def run_auto_backup():
    """Tâche périodique pour la sauvegarde automatique."""
    logger.info("Démarrage de la sauvegarde automatique de la base de données...")
    backup, error = BackupService.create_backup(backup_type=DatabaseBackup.BackupType.AUTO)
    if backup:
        logger.info(f"Sauvegarde automatique réussie : {backup.file.name}")
    else:
        logger.error(f"Échec de la sauvegarde automatique : {error}")
