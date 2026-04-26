from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import Sale, SaleItem, Customer

class SaleItemInline(admin.TabularInline):
    model = SaleItem
    extra = 0
    readonly_fields = ("product", "quantity", "unit", "unit_price", "total_line")

@admin.register(Sale)
class SaleAdmin(SimpleHistoryAdmin):
    list_display = ("invoice_number", "customer", "type", "payment_method", "total_amount", "created_at")
    list_filter = ("type", "payment_method", "created_at")
    search_fields = ("invoice_number", "customer__name", "customer_phone")
    inlines = [SaleItemInline]

@admin.register(Customer)
class CustomerAdmin(SimpleHistoryAdmin):
    list_display = ("name", "phone", "balance", "created_at")
    search_fields = ("name", "phone")
    list_filter = ("created_at",)
