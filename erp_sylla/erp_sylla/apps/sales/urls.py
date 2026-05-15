from django.urls import path
from .views import (
    POSView, product_search_ajax, cart_add, cart_remove, cart_update, 
    CheckoutView, SaleListView, SaleDetailView, SaleDeleteView, SaleInvoicePDFView,
    CustomerListView, CustomerDetailView, CustomerCreateView, customer_search_ajax,
    process_payment_ajax, PaymentReceiptPDFView, PaymentListView, AuditLogListView,
    SaleCancelView, resend_payment_whatsapp, request_release_code_ajax, process_return_ajax
)

app_name = "sales"
urlpatterns = [
    path("pos/", POSView.as_view(), name="pos"),
    path("pos/checkout/", CheckoutView.as_view(), name="checkout"),
    path("history/", SaleListView.as_view(), name="sale-list"),
    path("history/payments/", PaymentListView.as_view(), name="payment-list"),
    path("history/audit/", AuditLogListView.as_view(), name="audit-log"),
    path("history/<int:pk>/", SaleDetailView.as_view(), name="sale-detail"),
    path("history/<int:pk>/cancel/", SaleCancelView.as_view(), name="sale-cancel"),
    path("history/<int:pk>/delete/", SaleDeleteView.as_view(), name="sale-delete"),
    path("history/<int:pk>/pdf/", SaleInvoicePDFView.as_view(), name="sale-pdf"),
    path("payments/<int:pk>/pdf/", PaymentReceiptPDFView.as_view(), name="payment-pdf"),
    path("payments/<int:payment_id>/whatsapp/", resend_payment_whatsapp, name="ajax-payment-whatsapp"),
    path("customers/", CustomerListView.as_view(), name="customer-list"),
    path("customers/add/", CustomerCreateView.as_view(), name="customer-create"),
    path("customers/<int:pk>/", CustomerDetailView.as_view(), name="customer-detail"),
    path("customers/<int:customer_id>/payment/", process_payment_ajax, name="customer-payment"),
    path("ajax/search/", product_search_ajax, name="ajax-product-search"),
    path("ajax/customers/search/", customer_search_ajax, name="ajax-customer-search"),
    path("ajax/cart/add/<int:product_id>/", cart_add, name="ajax-cart-add"),
    path("ajax/cart/remove/<int:product_id>/<str:unit>/", cart_remove, name="ajax-cart-remove"),
    path("ajax/cart/update/<int:product_id>/<str:unit>/", cart_update, name="ajax-cart-update"),
    path("ajax/release-code/", request_release_code_ajax, name="ajax-release-code"),
    path("history/<int:pk>/return/", process_return_ajax, name="sale-return"),
]
