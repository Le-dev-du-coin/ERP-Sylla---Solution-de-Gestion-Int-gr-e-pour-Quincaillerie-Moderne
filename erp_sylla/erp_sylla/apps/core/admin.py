from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import AuditTestModel


@admin.register(AuditTestModel)
class AuditTestModelAdmin(SimpleHistoryAdmin):
    list_display = ("name", "is_active")
    history_list_display = ("is_active",)
    search_fields = ("name", "description")
