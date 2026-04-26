from django.core.management.base import BaseCommand
from erp_sylla.apps.core.models import ExpenseCategory

class Command(BaseCommand):
    help = "Pré-remplit les catégories de dépenses courantes."

    def handle(self, *args, **kwargs):
        categories = [
            {"name": "Loyer", "description": "Frais de location des boutiques ou dépôts"},
            {"name": "Salaires", "description": "Rémunération du personnel"},
            {"name": "Transport", "description": "Frais de déplacement et livraison"},
            {"name": "Électricité / Eau", "description": "Factures EDM / SOMAGEP"},
            {"name": "Communication", "description": "Crédit téléphonique et internet"},
            {"name": "Fournitures", "description": "Papeterie et petit matériel"},
            {"name": "Entretien", "description": "Maintenance des locaux et matériel"},
            {"name": "Divers", "description": "Autres dépenses non classées"},
        ]

        for cat in categories:
            obj, created = ExpenseCategory.objects.get_or_create(
                name=cat["name"],
                defaults={"description": cat["description"]}
            )
            if created:
                self.stdout.write(self.style.SUCCESS(f"Catégorie créée : {cat['name']}"))
            else:
                self.stdout.write(f"Catégorie existante : {cat['name']}")
