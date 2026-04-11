from django.urls import path
from .views import DashboardFinancierView, POSView

app_name = "core"
urlpatterns = [
    path("pos/", POSView.as_view(), name="pos"),
    path("finance/", DashboardFinancierView.as_view(), name="finance"),
]
