from django.urls import path
from .views import POSView, product_search_ajax, cart_add, cart_remove, cart_update, CheckoutView, SaleListView, SaleDetailView, SaleDeleteView

app_name = "sales"
urlpatterns = [
    path("pos/", POSView.as_view(), name="pos"),
    path("pos/checkout/", CheckoutView.as_view(), name="checkout"),
    path("history/", SaleListView.as_view(), name="sale-list"),
    path("history/<int:pk>/", SaleDetailView.as_view(), name="sale-detail"),
    path("history/<int:pk>/delete/", SaleDeleteView.as_view(), name="sale-delete"),
    path("ajax/search/", product_search_ajax, name="ajax-product-search"),
    path("ajax/cart/add/<int:product_id>/", cart_add, name="ajax-cart-add"),
    path("ajax/cart/remove/<int:product_id>/<str:unit>/", cart_remove, name="ajax-cart-remove"),
    path("ajax/cart/update/<int:product_id>/<str:unit>/", cart_update, name="ajax-cart-update"),
]
