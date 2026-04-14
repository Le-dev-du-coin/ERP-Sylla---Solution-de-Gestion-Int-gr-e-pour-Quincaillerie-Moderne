from django.urls import path
from django.views.generic import RedirectView
from .views import DashboardFinancierView, POSView, validate_code_ajax

app_name = "core"
urlpatterns = [
    path("pos/", RedirectView.as_view(pattern_name="sales:pos"), name="pos"),
    path("finance/", DashboardFinancierView.as_view(), name="finance"),
    
    # AJAX / HTMX
    path("ajax/validate-code/", validate_code_ajax, name="validate-code-ajax"),
]
