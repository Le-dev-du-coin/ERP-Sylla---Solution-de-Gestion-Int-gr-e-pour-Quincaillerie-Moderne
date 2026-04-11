from django.urls import path
from .views import (
    ProductListView, StockStatusView, ProductCreateView, ProductUpdateView, ProductDeleteView,
    StockTransactionCreateView, WarehouseListView, WarehouseCreateView, WarehouseUpdateView, 
    WarehouseDetailView, WarehouseDeleteView, get_product_stock_info
)

app_name = "inventory"
urlpatterns = [
    path("products/", ProductListView.as_view(), name="product-list"),
    path("products/add/", ProductCreateView.as_view(), name="product-add"),
    path("products/<int:pk>/edit/", ProductUpdateView.as_view(), name="product-edit"),
    path("products/<int:pk>/delete/", ProductDeleteView.as_view(), name="product-delete"),
    
    path("stock/", StockStatusView.as_view(), name="stock-status"),
    path("stock/add/", StockTransactionCreateView.as_view(), name="stock-transaction-add"),
    path("ajax/product-info/", get_product_stock_info, name="ajax-product-info"),
    
    path("warehouses/", WarehouseListView.as_view(), name="warehouse-list"),

    path("warehouses/add/", WarehouseCreateView.as_view(), name="warehouse-add"),
    path("warehouses/<int:pk>/", WarehouseDetailView.as_view(), name="warehouse-detail"),
    path("warehouses/<int:pk>/edit/", WarehouseUpdateView.as_view(), name="warehouse-edit"),
    path("warehouses/<int:pk>/delete/", WarehouseDeleteView.as_view(), name="warehouse-delete"),
]
