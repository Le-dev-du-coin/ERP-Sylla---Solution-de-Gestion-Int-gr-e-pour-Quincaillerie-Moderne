from django.urls import path
from .views import POSView, product_search_ajax
from django.http import HttpResponse

app_name = "sales"
urlpatterns = [
    path("pos/", POSView.as_view(), name="pos"),
    path("ajax/search/", product_search_ajax, name="ajax-product-search"),
    path("ajax/cart/add/<int:product_id>/", lambda r, product_id: HttpResponse("Ajouté (WIP)"), name="ajax-cart-add"),
]
