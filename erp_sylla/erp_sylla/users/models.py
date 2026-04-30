from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import CharField
from django.urls import reverse
from django.utils.translation import gettext_lazy as _


class User(AbstractUser):
    """
    Default custom user model for ERP Ets Sylla Madjou.
    If adding fields that need to be filled at user signup,
    check forms.SignupForm and forms.SocialSignupForms accordingly.
    """

    class Roles(models.TextChoices):
        GERANT = "GERANT", _("Gérant")
        VENDEUR = "VENDEUR", _("Vendeur")

    # First and last name cover name patterns around the globe
    name = CharField(_("Name of User"), blank=True, max_length=255)

    role = CharField(
        _("Rôle"),
        max_length=10,
        choices=Roles.choices,
        default=Roles.VENDEUR,
    )

    assigned_warehouse = models.ForeignKey(
        "inventory.Warehouse",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_("Magasin/Boutique d'affectation")
    )

    def save(self, *args, **kwargs):
        is_new = self._state.adding
        super().save(*args, **kwargs)
        
        # Synchronisation des groupes
        from django.contrib.auth.models import Group
        
        # On définit le nom du groupe cible
        group_name = "Gérants" if self.role == self.Roles.GERANT else "Vendeurs"
        
        try:
            group = Group.objects.get(name=group_name)
            # Nettoyage des anciens groupes de rôles (optionnel mais recommandé pour la cohérence)
            role_groups = ["Gérants", "Vendeurs"]
            for g_name in role_groups:
                if g_name != group_name:
                    g = Group.objects.get(name=g_name)
                    self.groups.remove(g)
            
            # Ajout au nouveau groupe
            self.groups.add(group)
        except Group.DoesNotExist:
            pass

    def get_absolute_url(self) -> str:
        """Get URL for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("users:detail", kwargs={"username": self.username})
