import os
import django
import sys

# Ajout du chemin du projet au sys.path pour éviter les erreurs d'import
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(BASE_DIR, "erp_sylla"))

# Configuration de Django (détecte si on est en local ou prod via l'env ou par défaut)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.production")
django.setup()

from erp_sylla.apps.sales.models import Sale, Payment, SaleItem, Customer
from erp_sylla.apps.inventory.models import StockTransaction, Product, Category, Warehouse
from erp_sylla.apps.communications.models import WhatsAppNotification, DailyReport
from erp_sylla.apps.core.models import Expense, ExpenseCategory, ReleaseCode, DatabaseBackup, AuditTestModel
from erp_sylla.apps.logistics.models import Container, ContainerExpense, LogisticsSupplier
from django.db import connection

def cleanup():
    print("\n⚠️  DÉBUT DU NETTOYAGE GLOBAL DE LA BASE DE DONNÉES...")
    
    try:
        # 1. Supprimer les notifications et rapports
        WhatsAppNotification.objects.all().delete()
        DailyReport.objects.all().delete()
        print("✅ Notifications et Rapports supprimés.")

        # 2. Supprimer la logistique (Conteneurs et Fournisseurs logistiques)
        ContainerExpense.objects.all().delete()
        Container.objects.all().delete()
        LogisticsSupplier.objects.all().delete()
        print("✅ Logistique (Conteneurs et Fournisseurs) vidée.")

        # 3. Supprimer les dépenses et données d'audit (Core)
        Expense.objects.all().delete()
        ReleaseCode.objects.all().delete()
        DatabaseBackup.objects.all().delete()
        AuditTestModel.objects.all().delete()
        print("✅ Dépenses, Codes de déblocage, Backups et Audits vidés.")

        # 4. Supprimer d'abord les objets dépendants (SaleItem, StockTransaction)
        SaleItem.objects.all().delete()
        StockTransaction.objects.all().delete()
        print("✅ Lignes de ventes et Transactions de stock supprimées.")

        # 5. Supprimer les ventes et paiements
        Sale.objects.all().delete()
        Payment.objects.all().delete()
        print("✅ Ventes et Paiements supprimés.")

        # 6. Supprimer les données de base (Produits, Clients, etc.)
        Product.objects.all().delete()
        Category.objects.all().delete()
        Warehouse.objects.all().delete()
        Customer.objects.all().delete()
        print("✅ Produits, Catégories, Entrepôts et Clients supprimés.")

        # 7. Réinitialiser les compteurs d'ID (Séquences PostgreSQL)
        with connection.cursor() as cursor:
            tables = [
                'sales_sale', 
                'sales_saleitem', 
                'sales_payment', 
                'sales_customer',
                'inventory_stocktransaction',
                'inventory_product',
                'inventory_category',
                'inventory_warehouse',
                'communications_whatsappnotification',
                'communications_dailyreport',
                'core_expense',
                'logistics_container',
                'logistics_containerexpense',
                'logistics_logisticssupplier',
                'core_releasecode',
                'core_databasebackup',
                'core_audittestmodel'
            ]
            for table in tables:
                try:
                    cursor.execute(f"ALTER SEQUENCE {table}_id_seq RESTART WITH 1;")
                except Exception:
                    continue
        print("✅ Numérotation (IDs) réinitialisée pour toutes les tables.")

        # 6. Test d'envoi de rapport (Optionnel mais recommandé)
        print("\n✉️  ENVOI D'UN RAPPORT DE TEST AU GÉRANT...")
        from erp_sylla.apps.sales.tasks import send_daily_report_task
        # On appelle la fonction directement (synchrone) pour le test
        try:
            result = send_daily_report_task()
            print(f"✅ Résultat du test d'envoi : {result}")
        except Exception as tel_err:
            print(f"⚠️  Échec du test d'envoi (vérifiez la config API) : {str(tel_err)}")

        print("\n✨ NETTOYAGE COMPLET TERMINÉ. Seuls les Utilisateurs et Paramètres sont conservés.")
        
    except Exception as e:
        print(f"\n❌ ERREUR LORS DU NETTOYAGE : {str(e)}")

if __name__ == "__main__":
    print(f"Configuration utilisée : {os.environ.get('DJANGO_SETTINGS_MODULE')}")
    confirm = input("\n🔥 ATTENTION : Vous allez supprimer TOUTES les données (Ventes, Stocks, Clients, Produits).\nSeuls les Utilisateurs et les Paramètres de configuration seront conservés.\nVoulez-vous continuer ? (oui/non) : ")
    
    if confirm.lower() == 'oui':
        cleanup()
    else:
        print("❌ Opération annulée.")
