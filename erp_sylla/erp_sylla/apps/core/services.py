import os
import subprocess
from django.conf import settings
from django.utils import timezone
from .models import DatabaseBackup, ReleaseCode
from django.core.files.base import ContentFile
from django.core.exceptions import ValidationError

import requests
from erp_sylla.apps.communications.models import CommunicationConfig

def send_whatsapp_message(phone, message, media_url=None, filename=None, instance_id=None, token=None):
    """
    Envoie un message WhatsApp via l'API Wachap.
    Si developer_test_phone est configuré, le message est redirigé vers ce numéro.
    """
    config = CommunicationConfig.get_solo()
    
    # Redirection vers le numéro de test si configuré
    target_phone = phone
    if config.developer_test_phone:
        target_phone = config.developer_test_phone
        message = f" [MODE TEST - Pour: {phone}] \n" + message

    url = "https://api.wachap.com/v1/whatsapp/messages/send"
    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": f"Bearer {token}"
    }

    # 1. Envoi du message texte (Toujours)
    payload_text = {
        "data": {
            "accountId": instance_id,
            "to": target_phone,
            "type": "text",
            "content": message
        }
    }
    
    try:
        response_text = requests.post(url, json=payload_text, headers=headers, timeout=20)
        result = response_text.json()
        
        # 2. Envoi du média si présent (en tant que second message)
        if media_url:
            payload_media = {
                "data": {
                    "accountId": instance_id,
                    "to": target_phone,
                }
            }
            if filename and filename.lower().endswith(".pdf"):
                payload_media["data"]["type"] = "document"
                payload_media["data"]["documentUrl"] = media_url
                payload_media["data"]["filename"] = filename
            else:
                payload_media["data"]["type"] = "image"
                payload_media["data"]["imageUrl"] = media_url
            
            # Optionnel: on peut ajouter une caption si l'API le supporte finalement
            payload_media["data"]["caption"] = filename or "Document"
            
            response_media = requests.post(url, json=payload_media, headers=headers, timeout=20)
            # On retourne le résultat du média car c'est souvent l'ID qu'on veut tracker
            result = response_media.json()
            
        return result
    except Exception as e:
        return {"error": str(e)}

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
        
        # Identification dynamique du chemin pg_dump (Mac local vs Serveur Linux)
        import shutil
        pg_dump_path = shutil.which('pg_dump') or '/usr/bin/pg_dump'
        
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
