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
from django.db import connection

def cleanup():
    print("\n⚠️  DÉBUT DU NETTOYAGE GLOBAL DE LA BASE DE DONNÉES...")
    
    try:
        # 1. Supprimer les notifications et rapports
        WhatsAppNotification.objects.all().delete()
        DailyReport.objects.all().delete()
        print("✅ Notifications et Rapports supprimés.")

        # 2. Supprimer les transactions de stock et l'inventaire
        StockTransaction.objects.all().delete()
        Product.objects.all().delete()
        Category.objects.all().delete()
        Warehouse.objects.all().delete()
        print("✅ Inventaire (Produits, Catégories, Entrepôts, Stocks) vidé.")

        # 3. Supprimer les ventes et lignes de vente
        SaleItem.objects.all().delete()
        Sale.objects.all().delete()
        print("✅ Toutes les ventes et devis supprimés.")

        # 4. Supprimer les paiements et les clients
        Payment.objects.all().delete()
        Customer.objects.all().delete()
        print("✅ Historique des paiements et base Clients supprimés.")

        # 5. Réinitialiser les compteurs d'ID (Séquences PostgreSQL) pour repartir de 1
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
                'communications_dailyreport'
            ]
            for table in tables:
                try:
                    cursor.execute(f"ALTER SEQUENCE {table}_id_seq RESTART WITH 1;")
                except Exception:
                    continue
        print("✅ Numérotation (IDs) réinitialisée pour toutes les tables.")

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
