from django.contrib.auth.mixins import UserPassesTestMixin
from django.core.exceptions import PermissionDenied

class GerantRequiredMixin(UserPassesTestMixin):
    """Vérifie que l'utilisateur a le rôle Gérant."""
    def test_func(self):
        if not self.request.user.is_authenticated:
            return False
        # Un superutilisateur est considéré comme gérant
        return self.request.user.role == "GERANT" or self.request.user.is_superuser

    def handle_no_permission(self):
        if self.request.user.is_authenticated:
            raise PermissionDenied("Accès réservé aux gérants.")
        return super().handle_no_permission()

class VendeurRequiredMixin(UserPassesTestMixin):
    """Vérifie que l'utilisateur a au moins le rôle Vendeur (ou Gérant)."""
    def test_func(self):
        if not self.request.user.is_authenticated:
            return False
        return self.request.user.role in ["VENDEUR", "GERANT"] or self.request.user.is_superuser
