from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from .permissions import GerantRequiredMixin, VendeurRequiredMixin

class DashboardFinancierView(GerantRequiredMixin, TemplateView):
    template_name = "core/dashboard_financier.html"

class POSView(VendeurRequiredMixin, TemplateView):
    template_name = "core/pos.html"
