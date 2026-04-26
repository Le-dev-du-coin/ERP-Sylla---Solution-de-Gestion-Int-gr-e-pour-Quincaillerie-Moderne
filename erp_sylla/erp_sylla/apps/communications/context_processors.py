from erp_sylla.apps.communications.models import CommunicationConfig

def erp_settings(request):
    """Rend la configuration globale disponible dans tous les templates."""
    try:
        config = CommunicationConfig.get_solo()
        return {
            'ERP_VERSION': config.erp_version,
            'REPORT_TIME': config.report_time.strftime('%H:%M') if config.report_time else '20:00',
        }
    except:
        return {
            'ERP_VERSION': 'v1.2.0',
            'REPORT_TIME': '20:00',
        }
