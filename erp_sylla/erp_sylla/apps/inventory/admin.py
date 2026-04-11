from django.contrib import admin
from simple_history.admin import SimpleHistoryAdmin
from .models import Product


@admin.register(Product)
class ProductAdmin(SimpleHistoryAdmin):
    list_display = (
        "name", 
        "sku", 
        "purchase_price", 
        "sale_price_piece", 
        "sale_price_carton", 
        "is_active"
    )
    list_filter = ("is_active",)
    search_fields = ("name", "sku", "barcode")
    history_list_display = ["is_active", "purchase_price", "sale_price_piece"]
    readonly_fields = ("created_at", "updated_at")
    
    fieldsets = (
        (None, {"fields": ("name", "description", "is_active")}),
        ("Identification", {"fields": ("sku", "barcode")}),
        ("Prix (F CFA)", {"fields": ("purchase_price", "sale_price_piece", "sale_price_carton")}),
        ("Logistique", {"fields": ("conversion_factor",)}),
        ("Métadonnées", {"fields": ("created_at", "updated_at")}),
    )
