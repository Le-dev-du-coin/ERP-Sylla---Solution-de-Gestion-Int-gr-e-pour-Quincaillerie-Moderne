from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from import_export.admin import ImportExportModelAdmin
from .models import Product, Warehouse, StockTransaction, Category
from .resources import ProductResource


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ("name", "description")
    search_fields = ("name",)


@admin.register(Warehouse)
class WarehouseAdmin(SimpleHistoryAdmin):
    list_display = ("name", "location", "is_active")
    search_fields = ("name",)


@admin.register(StockTransaction)
class StockTransactionAdmin(SimpleHistoryAdmin):
    list_display = ("created_at", "product", "warehouse", "quantity", "type")
    list_filter = ("type", "warehouse", "created_at")
    search_fields = ("product__name", "notes")
    date_hierarchy = "created_at"


@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin, SimpleHistoryAdmin):
    resource_class = ProductResource
    list_display = (
        "name", 
        "sku", 
        "category",
        "purchase_price", 
        "sale_price_piece", 
        "is_zakat_eligible",
        "is_active"
    )
    list_filter = ("category", "is_zakat_eligible", "is_active")
    search_fields = ("name", "sku", "barcode")
    history_list_display = ["is_active", "purchase_price", "sale_price_piece"]
    readonly_fields = ("created_at", "updated_at")
    
    fieldsets = (
        (None, {"fields": ("name", "category", "description", "is_active")}),
        ("Identification", {"fields": ("sku", "barcode")}),
        ("Finances & Zakat", {"fields": ("purchase_price", "sale_price_piece", "sale_price_carton", "is_zakat_eligible")}),
        ("Logistique", {"fields": ("conversion_factor",)}),
        ("Métadonnées", {"fields": ("created_at", "updated_at")}),
    )
