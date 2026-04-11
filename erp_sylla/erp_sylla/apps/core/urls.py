from django.urls import path
from django.views.generic import RedirectView
from .views import DashboardFinancierView, POSView

app_name = "core"
urlpatterns = [
    path("pos/", RedirectView.as_view(pattern_name="sales:pos"), name="pos"),
    path("finance/", DashboardFinancierView.as_view(), name="finance"),
]
