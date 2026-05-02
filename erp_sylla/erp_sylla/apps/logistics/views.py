from django.shortcuts import redirect, render
from django.http import HttpResponse
from django.views.generic import ListView, CreateView, UpdateView, DetailView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy
from django.db.models import Sum, F
from erp_sylla.apps.core.permissions import GerantRequiredMixin, VendeurRequiredMixin
from .models import Container, LogisticsSupplier, ContainerExpense
from .forms import ContainerForm, LogisticsSupplierForm, ContainerExpenseForm
from .resources import ContainerResource

# --- Vues Fournisseurs ---
# ... (rest of imports)

class ContainerExportView(LoginRequiredMixin, GerantRequiredMixin, ListView):
    def get(self, request, *args, **kwargs):
        resource = ContainerResource()
        dataset = resource.export()
        response = HttpResponse(dataset.xlsx, content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        response['Content-Disposition'] = 'attachment; filename="export_conteneurs.xlsx"'
        return response

class SupplierListView(LoginRequiredMixin, VendeurRequiredMixin, ListView):
    model = LogisticsSupplier
    template_name = "logistics/supplier_list.html"
    context_object_name = "suppliers"

class SupplierCreateView(LoginRequiredMixin, GerantRequiredMixin, CreateView):
    model = LogisticsSupplier
    form_class = LogisticsSupplierForm
    template_name = "logistics/supplier_form.html"
    success_url = reverse_lazy("logistics:supplier-list")

class SupplierUpdateView(LoginRequiredMixin, GerantRequiredMixin, UpdateView):
    model = LogisticsSupplier
    form_class = LogisticsSupplierForm
    template_name = "logistics/supplier_form.html"
    success_url = reverse_lazy("logistics:supplier-list")

# --- Vues Conteneurs ---

class ContainerListView(LoginRequiredMixin, VendeurRequiredMixin, ListView):
    model = Container
    template_name = "logistics/container_list.html"
    context_object_name = "containers"
    paginate_by = 20

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Stats pour le dashboard logistique
        context["total_containers"] = Container.objects.exclude(status=Container.Status.CANCELLED).count()
        context["in_transit"] = Container.objects.filter(status=Container.Status.IN_TRANSIT).count()
        context["arrived"] = Container.objects.filter(status=Container.Status.ARRIVED_WAREHOUSE).count()
        return context

class ContainerDetailView(LoginRequiredMixin, VendeurRequiredMixin, DetailView):
    model = Container
    template_name = "logistics/container_detail.html"
    context_object_name = "container"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["expense_form"] = ContainerExpenseForm()
        return context

class ContainerCreateView(LoginRequiredMixin, GerantRequiredMixin, CreateView):
    model = Container
    form_class = ContainerForm
    template_name = "logistics/container_form.html"
    success_url = reverse_lazy("logistics:container-list")

class ContainerUpdateView(LoginRequiredMixin, GerantRequiredMixin, UpdateView):
    model = Container
    form_class = ContainerForm
    template_name = "logistics/container_form.html"
    success_url = reverse_lazy("logistics:container-list")

# --- Frais (AJAX/HTMX) ---

class ContainerExpenseCreateView(LoginRequiredMixin, GerantRequiredMixin, CreateView):
    model = ContainerExpense
    form_class = ContainerExpenseForm

    def form_valid(self, form):
        container = Container.objects.get(pk=self.kwargs["pk"])
        expense = form.save(commit=False)
        expense.container = container
        expense.save()
        
        if self.request.htmx:
            from django.shortcuts import render
            return render(self.request, "logistics/partials/expense_list.html", {"container": container})
        return redirect("logistics:container-detail", pk=container.pk)
