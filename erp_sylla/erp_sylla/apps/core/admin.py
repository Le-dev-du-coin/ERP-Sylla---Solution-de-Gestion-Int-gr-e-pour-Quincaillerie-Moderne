from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import AuditTestModel, ReleaseCode, ExpenseCategory, Expense


@admin.register(AuditTestModel)
class AuditTestModelAdmin(SimpleHistoryAdmin):
    list_display = ("name",)
    search_fields = ("name",)


@admin.register(ReleaseCode)
class ReleaseCodeAdmin(SimpleHistoryAdmin):
    list_display = ("code", "operation_type", "is_used", "created_at", "expires_at", "created_by")
    list_filter = ("operation_type", "is_used", "created_at")
    search_fields = ("code",)
    readonly_fields = ("is_used", "used_by", "used_at")
    
    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)


@admin.register(ExpenseCategory)
class ExpenseCategoryAdmin(admin.ModelAdmin):
    list_display = ("name", "description")
    search_fields = ("name",)


@admin.register(Expense)
class ExpenseAdmin(SimpleHistoryAdmin):
    list_display = ("title", "category", "amount", "date", "recorded_by")
    list_filter = ("category", "date", "recorded_by")
    search_fields = ("title", "notes")
    date_hierarchy = "date"
