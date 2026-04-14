from django.test import TestCase
from django.contrib.auth import get_user_model
from django.utils import timezone
from erp_sylla.apps.core.models import ReleaseCode
from erp_sylla.apps.core.services import validate_release_code, generate_release_code
from django.core.exceptions import ValidationError

User = get_user_model()

class ReleaseCodeTest(TestCase):
    def setUp(self):
        self.gerant = User.objects.create_user(username="gerant", password="password", role="GERANT")
        self.vendeur = User.objects.create_user(username="vendeur", password="password", role="VENDEUR")
        self.code = generate_release_code(self.gerant, operation_type=ReleaseCode.OperationTypes.DISCOUNT)

    def test_code_generation(self):
        """Un code doit être généré avec 6 caractères."""
        self.assertEqual(len(self.code.code), 6)
        self.assertFalse(self.code.is_used)
        self.assertTrue(self.code.is_valid)

    def test_valid_code_validation(self):
        """Un code valide doit être accepté et marqué comme utilisé."""
        success, rc = validate_release_code(self.code.code, self.vendeur, ReleaseCode.OperationTypes.DISCOUNT)
        self.assertTrue(success)
        self.assertTrue(rc.is_used)
        self.assertEqual(rc.used_by, self.vendeur)

    def test_expired_code(self):
        """Un code expiré doit être rejeté."""
        self.code.expires_at = timezone.now() - timezone.timedelta(minutes=1)
        self.code.save()
        
        with self.assertRaises(ValidationError) as cm:
            validate_release_code(self.code.code, self.vendeur)
        self.assertIn("expiré", str(cm.exception))

    def test_already_used_code(self):
        """Un code déjà utilisé doit être rejeté."""
        validate_release_code(self.code.code, self.vendeur)
        
        with self.assertRaises(ValidationError) as cm:
            validate_release_code(self.code.code, self.vendeur)
        self.assertIn("déjà été utilisé", str(cm.exception))

    def test_wrong_operation_type(self):
        """Un code pour une remise ne doit pas fonctionner pour une annulation."""
        with self.assertRaises(ValidationError) as cm:
            validate_release_code(self.code.code, self.vendeur, operation_type=ReleaseCode.OperationTypes.CANCELLATION)
        self.assertIn("pas autorisé pour l'opération", str(cm.exception))

    def test_invalid_code_string(self):
        """Une chaîne de caractères invalide doit lever une erreur."""
        with self.assertRaises(ValidationError) as cm:
            validate_release_code("INVALID", self.vendeur)
        self.assertIn("invalide", str(cm.exception))
