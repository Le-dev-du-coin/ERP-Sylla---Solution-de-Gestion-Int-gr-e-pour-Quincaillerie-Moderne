import os
from django.conf import settings
from django.http import FileResponse, Http404, HttpResponseForbidden
from django.shortcuts import get_object_or_404, render
from django.utils import timezone
from django.views import View
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, UpdateView
from django.urls import reverse_lazy
from django.contrib import messages
from erp_sylla.apps.core.permissions import GerantRequiredMixin
from .forms import CommunicationConfigForm

from .models import WhatsAppNotification, CommunicationConfig, DailyReport

class SecurePDFDownloadView(View):
    """Sert le PDF si le token est valide et non expiré."""
    def get(self, request, token):
        notification = get_object_or_404(WhatsAppNotification, token=token)
        
        if notification.is_expired():
            return render(request, "communications/link_expired.html", status=403)
        
        if notification.sale:
            sale = notification.sale
            filename = f"Facture-{sale.invoice_number}.pdf"
            file_path = os.path.join(settings.MEDIA_ROOT, "invoices", filename)
        elif notification.payment:
            payment = notification.payment
            filename = f"Recu-{payment.reference}.pdf"
            file_path = os.path.join(settings.MEDIA_ROOT, "receipts", filename)
        else:
            raise Http404("Document non trouvé.")
        
        if not os.path.exists(file_path):
            raise Http404("Le fichier n'est plus disponible.")
            
        return FileResponse(open(file_path, "rb"), content_type="application/pdf")

class SecureReportDownloadView(View):
    """Sert le PDF du rapport journalier via token."""
    def get(self, request, token):
        report = get_object_or_404(DailyReport, token=token)
        filename = f"Rapport-Journalier-{report.date.strftime('%Y%m%d')}.pdf"
        file_path = os.path.join(settings.MEDIA_ROOT, "reports", filename)
        
        if not os.path.exists(file_path):
            raise Http404("Le rapport n'est plus disponible.")
            
        return FileResponse(open(file_path, "rb"), content_type="application/pdf")

class CommunicationConfigUpdateView(GerantRequiredMixin, UpdateView):
    """Permet au gérant de modifier la configuration API et gérants."""
    model = CommunicationConfig
    form_class = CommunicationConfigForm
    template_name = "communications/config_form.html"
    success_url = reverse_lazy("communications:config-update")

    def get_object(self, queryset=None):
        return CommunicationConfig.get_solo()

    def form_valid(self, form):
        messages.success(self.request, "La configuration a été mise à jour avec succès.")
        return super().form_valid(form)

class NotificationDashboardView(LoginRequiredMixin, ListView):
    """Tableau de bord pour gérer les envois WhatsApp."""
    model = WhatsAppNotification
    template_name = "communications/dashboard.html"
    context_object_name = "notifications"
    paginate_by = 50

    def get_queryset(self):
        queryset = WhatsAppNotification.objects.select_related("sale", "payment").all()
        status_filter = self.request.GET.get("status")
        if status_filter == "FAILED":
            queryset = queryset.filter(status=WhatsAppNotification.Status.FAILED)
        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["current_status"] = self.request.GET.get("status", "ALL")
        return context
