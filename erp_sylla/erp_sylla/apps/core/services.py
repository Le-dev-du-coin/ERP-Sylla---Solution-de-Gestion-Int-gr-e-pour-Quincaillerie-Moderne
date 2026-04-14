from django.utils import timezone
from .models import ReleaseCode
from django.core.exceptions import ValidationError


def validate_release_code(code_str, user, operation_type=None):
    """
    Vérifie si un code est valide pour l'utilisateur et l'opération donnés.
    Marque le code comme utilisé si valide.
    """
    try:
        release_code = ReleaseCode.objects.get(code=code_str.upper())
        
        if release_code.is_used:
            raise ValidationError("Ce code a déjà été utilisé.")
            
        if release_code.expires_at < timezone.now():
            raise ValidationError("Ce code a expiré.")
            
        if operation_type and release_code.operation_type != operation_type:
            raise ValidationError(f"Ce code n'est pas autorisé pour l'opération : {operation_type}")

        # Validation réussie
        release_code.is_used = True
        release_code.used_by = user
        release_code.used_at = timezone.now()
        release_code.save()
        
        return True, release_code
        
    except ReleaseCode.DoesNotExist:
        raise ValidationError("Code de déblocage invalide.")


def generate_release_code(created_by, operation_type=ReleaseCode.OperationTypes.DISCOUNT, hours_valid=1):
    """Génère un nouveau code de déblocage."""
    expires_at = timezone.now() + timezone.timedelta(hours=hours_valid)
    return ReleaseCode.objects.create(
        operation_type=operation_type,
        created_by=created_by,
        expires_at=expires_at
    )
