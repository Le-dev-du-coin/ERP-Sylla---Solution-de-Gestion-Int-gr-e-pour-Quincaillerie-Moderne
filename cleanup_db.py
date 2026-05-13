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
from erp_sylla.apps.inventory.models import StockTransaction
from erp_sylla.apps.communications.models import WhatsAppNotification, DailyReport
from django.db import connection

def cleanup():
    print("\n⚠️  DÉBUT DU NETTOYAGE DE LA BASE DE DONNÉES...")
    
    try:
        # 1. Supprimer les notifications et rapports
        WhatsAppNotification.objects.all().delete()
        DailyReport.objects.all().delete()
        print("✅ Notifications et Rapports supprimés.")

        # 2. Supprimer les transactions de stock (remise à zéro des stocks réels)
        StockTransaction.objects.all().delete()
        print("✅ Historique des stocks vidé.")

        # 3. Supprimer les ventes et lignes de vente
        SaleItem.objects.all().delete()
        Sale.objects.all().delete()
        print("✅ Toutes les ventes et devis supprimés.")

        # 4. Supprimer les paiements clients
        Payment.objects.all().delete()
        print("✅ Historique des paiements vidé.")

        # 5. Remise à zéro des soldes clients (Dettes)
        Customer.objects.update(balance=0)
        print("✅ Soldes clients réinitialisés à 0.")

        # 6. Réinitialiser les compteurs d'ID (Séquences PostgreSQL) pour repartir de 1
        with connection.cursor() as cursor:
            # On liste les tables critiques pour réinitialiser leurs séquences
            tables = [
                'sales_sale', 
                'sales_saleitem', 
                'sales_payment', 
                'inventory_stocktransaction',
                'communications_whatsappnotification',
                'communications_dailyreport'
            ]
            for table in tables:
                try:
                    cursor.execute(f"ALTER SEQUENCE {table}_id_seq RESTART WITH 1;")
                except Exception:
                    # Si la séquence a un nom différent ou n'existe pas, on passe
                    continue
        print("✅ Numérotation (IDs) réinitialisée pour les nouvelles données.")

        print("\n✨ NETTOYAGE TERMINÉ. La base est propre et prête.")
        
    except Exception as e:
        print(f"\n❌ ERREUR LORS DU NETTOYAGE : {str(e)}")

if __name__ == "__main__":
    print(f"Configuration utilisée : {os.environ.get('DJANGO_SETTINGS_MODULE')}")
    confirm = input("\n🔥 ATTENTION : Vous allez supprimer TOUTES les données de ventes et stocks.\nLes Produits et Clients seront conservés.\nVoulez-vous continuer ? (oui/non) : ")
    
    if confirm.lower() == 'oui':
        cleanup()
    else:
        print("❌ Opération annulée.")
