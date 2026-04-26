from django.contrib import admin
from .models import CommunicationConfig, WhatsAppNotification

@admin.register(CommunicationConfig)
class CommunicationConfigAdmin(admin.ModelAdmin):
    list_display = ("__str__", "erp_version", "manager_phone_1", "updated_at")
    
    def has_add_permission(self, request):
        # Empêche d'ajouter plus d'une config (Singleton)
        return not CommunicationConfig.objects.exists()

@admin.register(WhatsAppNotification)
class WhatsAppNotificationAdmin(admin.ModelAdmin):
    list_display = ("sale", "phone", "status", "retry_count", "created_at", "expires_at")
    list_filter = ("status", "created_at")
    search_fields = ("phone", "sale__invoice_number")
    readonly_fields = ("token", "created_at")
