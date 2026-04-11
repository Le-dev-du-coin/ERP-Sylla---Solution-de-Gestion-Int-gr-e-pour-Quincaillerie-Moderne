from django.core.management.base import BaseCommand
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from erp_sylla.apps.core.models import AuditTestModel

class Command(BaseCommand):
    help = "Initialise les groupes et permissions par défaut pour l'ERP."

    def handle(self, *args, **options):
        # 1. Création des groupes
        gerants_group, _ = Group.objects.get_or_create(name="Gérants")
        vendeurs_group, _ = Group.objects.get_or_create(name="Vendeurs")

        # 2. Permissions pour AuditTestModel (Exemple)
        content_type = ContentType.objects.get_for_model(AuditTestModel)
        
        # Le gérant peut tout faire
        permissions_gerant = Permission.objects.filter(content_type=content_type)
        for perm in permissions_gerant:
            gerants_group.permissions.add(perm)

        # Le vendeur peut uniquement voir (view)
        view_perm = Permission.objects.get(content_type=content_type, codename="view_audittestmodel")
        vendeurs_group.permissions.add(view_perm)

        self.stdout.write(self.style.SUCCESS("Groupes et permissions initialisés avec succès !"))
