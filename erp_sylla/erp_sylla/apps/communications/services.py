import requests
from django.conf import settings
import logging

logger = logging.getLogger(__name__)

def clean_phone_number(phone):
    """Nettoie le numéro et ajoute le préfixe +223 si nécessaire."""
    if not phone:
        return None
    
    # On ne garde que les chiffres
    clean_phone = "".join(filter(str.isdigit, phone))
    
    # Gestion des préfixes
    if clean_phone.startswith("00"):
        clean_phone = clean_phone[2:]
    
    # Si numéro local Malien (8 chiffres)
    if len(clean_phone) == 8:
        clean_phone = "223" + clean_phone
        
    return clean_phone

def send_whatsapp_text(phone, message):
    """
    Envoie un message texte via l'API Wachap.
    """
    if not settings.WACHAP_SECRET_KEY:
        logger.error("WACHAP_SECRET_KEY non configurée.")
        return None

    clean_phone = clean_phone_number(phone)
    if not clean_phone:
        return None

    headers = {
        "Authorization": f"Bearer {settings.WACHAP_SECRET_KEY}",
        "Content-Type": "application/json"
    }
    
    payload = {
        "phone": clean_phone,
        "message": message
    }
    
    try:
        response = requests.post(
            settings.WACHAP_BASE_URL, 
            json=payload, 
            headers=headers,
            timeout=15
        )
        response.raise_for_status()
        return response.json()
    except Exception as e:
        logger.error(f"Erreur envoi texte Wachap : {str(e)}")
        return None
