from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from import_export.admin import ImportExportModelAdmin
from .models import LogisticsSupplier, Container, ContainerExpense
from .resources import ContainerResource

class ContainerExpenseInline(admin.TabularInline):
    model = ContainerExpense
    extra = 1

@admin.register(LogisticsSupplier)
class LogisticsSupplierAdmin(SimpleHistoryAdmin):
    list_display = ("name", "country", "phone", "email")
    search_fields = ("name", "country")

@admin.register(Container)
class ContainerAdmin(ImportExportModelAdmin, SimpleHistoryAdmin):
    resource_class = ContainerResource
    list_display = (
        "container_number", 
        "supplier", 
        "status", 
        "eta", 
        "actual_arrival_date",
        "merchandise_value",
        "total_expenses",
    )
    list_filter = ("status", "supplier", "eta")
    search_fields = ("container_number", "order_reference", "supplier__name")
    inlines = [ContainerExpenseInline]
    date_hierarchy = "eta"
    
    fieldsets = (
        (None, {"fields": ("container_number", "order_reference", "supplier", "status")}),
        ("Logistique", {"fields": ("origin_port", "destination_port", "main_product", "container_type", "quantity_packages")}),
        ("Dates", {"fields": ("order_date", "loading_date", "etd", "eta", "actual_arrival_date")}),
        ("Finances", {"fields": ("merchandise_value", "total_expenses")}),
        ("Notes", {"fields": ("observation",)}),
    )
    readonly_fields = ("total_expenses",)

@admin.register(ContainerExpense)
class ContainerExpenseAdmin(SimpleHistoryAdmin):
    list_display = ("label", "container", "amount", "date")
    list_filter = ("container", "date")
    search_fields = ("label", "container__container_number")
