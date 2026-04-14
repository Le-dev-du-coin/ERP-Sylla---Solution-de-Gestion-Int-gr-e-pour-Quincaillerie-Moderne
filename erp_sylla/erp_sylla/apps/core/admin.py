from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import AuditTestModel, ReleaseCode


@admin.register(AuditTestModel)
class AuditTestModelAdmin(SimpleHistoryAdmin):
    list_display = ("name", "is_active")
    history_list_display = ("is_active",)
    search_fields = ("name", "description")


@admin.register(ReleaseCode)
class ReleaseCodeAdmin(SimpleHistoryAdmin):
    list_display = ("code", "operation_type", "is_used", "created_at", "expires_at", "created_by", "is_valid")
    list_filter = ("operation_type", "is_used", "created_at")
    search_fields = ("code",)
    readonly_fields = ("is_used", "used_by", "used_at")
    
    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)

    def is_valid(self, obj):
        return obj.is_valid
    is_valid.boolean = True
    is_valid.short_description = "Encore utilisable ?"
