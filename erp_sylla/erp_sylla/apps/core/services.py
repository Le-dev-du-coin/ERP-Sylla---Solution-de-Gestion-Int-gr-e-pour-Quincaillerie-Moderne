import os
import subprocess
from django.conf import settings
from django.utils import timezone
from .models import DatabaseBackup, ReleaseCode
from django.core.files.base import ContentFile
from django.core.exceptions import ValidationError

def validate_release_code(code_str, user, operation_type):
    """
    Valide un code de déblocage pour une opération spécifique.
    Lève une ValidationError si le code est invalide ou expiré.
    """
    try:
        release_code = ReleaseCode.objects.get(
            code=code_str, 
            operation_type=operation_type,
            is_used=False,
            expires_at__gt=timezone.now()
        )
        # Marquer le code comme utilisé
        release_code.is_used = True
        release_code.used_by = user
        release_code.used_at = timezone.now()
        release_code.save()
        return True, release_code
    except ReleaseCode.DoesNotExist:
        raise ValidationError("Code de déblocage invalide, déjà utilisé ou expiré.")

class BackupService:
    @staticmethod
    def create_backup(backup_type=DatabaseBackup.BackupType.MANUAL):
        """Exécute un pg_dump et enregistre le résultat dans le modèle DatabaseBackup."""
        db_config = settings.DATABASES['default']
        db_name = db_config['NAME']
        db_user = db_config['USER']
        db_password = db_config['PASSWORD']
        db_host = db_config['HOST']
        db_port = db_config['PORT']

        timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
        filename = f"backup_{db_name}_{timestamp}.sql"
        
        env = os.environ.copy()
        env['PGPASSWORD'] = db_password
        
        # Utilisation du chemin absolu identifié
        pg_dump_path = '/usr/local/Cellar/libpq/18.3/bin/pg_dump'
        
        cmd = [
            pg_dump_path,
            '-h', db_host,
            '-p', str(db_port),
            '-U', db_user,
            '-d', db_name,
            '--clean',
            '--if-exists',
        ]

        try:
            result = subprocess.run(cmd, env=env, capture_output=True, text=False)
            if result.returncode == 0:
                backup = DatabaseBackup(backup_type=backup_type)
                backup.file.save(filename, ContentFile(result.stdout), save=False)
                backup.file_size = backup.file.size
                backup.save()
                return backup, None
            else:
                return None, result.stderr.decode('utf-8')
        except Exception as e:
            return None, str(e)
