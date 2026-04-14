from django.views.generic import ListView, CreateView, UpdateView, DeleteView, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy
from django.db import models, transaction
from django.db.models import Sum, F, ExpressionWrapper, IntegerField
from .models import Product, Warehouse, StockTransaction
from .forms import ProductForm, StockTransactionForm
from erp_sylla.apps.core.permissions import GerantRequiredMixin


class ProductListView(LoginRequiredMixin, ListView):
    model = Product
    template_name = "inventory/product_list.html"
    context_object_name = "products"
    paginate_by = 20

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        from simple_history.models import HistoricalRecords
        context["history_records"] = Product.history.all()[:15]
        return context



class ProductCreateView(LoginRequiredMixin, CreateView):
    model = Product
    form_class = ProductForm
    template_name = "inventory/product_form.html"
    success_url = reverse_lazy("inventory:product-list")


class ProductUpdateView(LoginRequiredMixin, UpdateView):
    model = Product
    form_class = ProductForm
    template_name = "inventory/product_form.html"
    success_url = reverse_lazy("inventory:product-list")


class ProductDeleteView(LoginRequiredMixin, DeleteView):
    model = Product
    template_name = "inventory/product_confirm_delete.html"
    success_url = reverse_lazy("inventory:product-list")

class StockStatusView(LoginRequiredMixin, ListView):
    model = Product
    template_name = "inventory/stock_status.html"
    context_object_name = "products"
    paginate_by = 50

class LowStockListView(GerantRequiredMixin, ListView):
    """Affiche les articles en alerte de stock."""
    model = Product
    template_name = "inventory/low_stock_list.html"
    context_object_name = "products"

    def get_queryset(self):
        # Optimisation : une seule requête SQL avec annotation et filtre
        return Product.objects.annotate(
            total_stock_calc=Sum("stock_transactions__quantity")
        ).filter(
            total_stock_calc__lte=F("low_stock_threshold")
        )


class StockTransactionCreateView(LoginRequiredMixin, CreateView):
    model = StockTransaction
    form_class = StockTransactionForm
    template_name = "inventory/stock_transaction_form.html"

    def get_success_url(self):
        return reverse_lazy("inventory:warehouse-detail", kwargs={"pk": self.object.warehouse.pk})

    def get_initial(self):
        initial = super().get_initial()
        warehouse_id = self.request.GET.get("warehouse")
        if warehouse_id:
            initial["warehouse"] = warehouse_id
        return initial

    @transaction.atomic
    def form_valid(self, form):
        transaction_obj = form.save(commit=False)
        product = transaction_obj.product
        warehouse = transaction_obj.warehouse
        quantity = form.cleaned_data["quantity"]
        unit = form.cleaned_data["input_unit"]

        # 1. Conversion en pièces si nécessaire
        final_qty = quantity
        if unit == "CARTON":
            final_qty = quantity * product.conversion_factor

        # 2. Gestion spécifique par type
        if transaction_obj.type == StockTransaction.Types.AJUSTEMENT:
            # Logique Option 2 : Saisie du stock réel final
            current_stock = product.stock_transactions.filter(warehouse=warehouse).aggregate(total=Sum("quantity"))["total"] or 0
            transaction_obj.quantity = final_qty - current_stock
            transaction_obj.notes = f"Inventaire : stock corrigé de {current_stock} vers {final_qty}. {transaction_obj.notes}"
            transaction_obj.save()
            return super().form_valid(form)

        if transaction_obj.type == StockTransaction.Types.TRANSFERT:
            to_warehouse = form.cleaned_data.get("to_warehouse")
            if not to_warehouse:
                form.add_error("to_warehouse", "Veuillez sélectionner un entrepôt cible.")
                return self.form_invalid(form)
            
            # Création du mouvement de SORTIE sur l'entrepôt d'origine
            transaction_obj.quantity = -abs(final_qty)
            transaction_obj.save()

            # Création du mouvement d'ENTRÉE sur l'entrepôt cible
            StockTransaction.objects.create(
                product=product,
                warehouse=to_warehouse,
                quantity=abs(final_qty),
                type=StockTransaction.Types.ENTREE,
                notes=f"Transfert depuis {transaction_obj.warehouse.name}. {transaction_obj.notes}"
            )
            # On utilise Redirect car l'objet est déjà sauvé manuellement
            from django.shortcuts import redirect
            return redirect(self.get_success_url())
        
        # Pour les autres types (Entrée, Sortie)
        if transaction_obj.type == StockTransaction.Types.SORTIE:
            transaction_obj.quantity = -abs(final_qty)
        else:
            transaction_obj.quantity = final_qty
            
        return super().form_valid(form)



from django.http import HttpResponse

def get_product_stock_info(request):
    """Vue pour HTMX : renvoie le stock actuel et le facteur de conversion."""
    product_id = request.GET.get("product")
    warehouse_id = request.GET.get("warehouse")
    
    if not product_id or not warehouse_id:
        return HttpResponse("")

    try:
        product = Product.objects.get(id=product_id)
        # On calcule le stock pour cet entrepôt uniquement
        total = product.stock_transactions.filter(warehouse_id=warehouse_id).aggregate(total=Sum("quantity"))["total"] or 0
        
        cartons = total // product.conversion_factor
        pieces = total % product.conversion_factor
        
        html = f"""
            <div id="product-info-panel" class="alert alert-warning border-0 shadow-sm mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-info-circle me-2"></i> Stock actuel ici :</span>
                    <span class="fw-bold fs-5">{total} pièces ({cartons} ct & {pieces} pc)</span>
                </div>
                <input type="hidden" id="current_conv_factor" value="{product.conversion_factor}">
            </div>
        """
        return HttpResponse(html)
    except (Product.DoesNotExist, ValueError):
        return HttpResponse("")


class WarehouseListView(LoginRequiredMixin, ListView):
    model = Warehouse
    template_name = "inventory/warehouse_list.html"
    context_object_name = "warehouses"

    def get_queryset(self):
        return Warehouse.objects.filter(is_active=True).annotate(
            annotated_value=Sum(F("stock_transactions__quantity") * F("stock_transactions__product__purchase_price")),
            annotated_products_count=models.Count("stock_transactions__product", distinct=True)
        )



class WarehouseDetailView(LoginRequiredMixin, DetailView):
    model = Warehouse
    template_name = "inventory/warehouse_detail.html"
    context_object_name = "warehouse"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # On calcule le stock spécifique à cet entrepôt pour chaque produit
        products_in_stock = []
        for product in Product.objects.filter(is_active=True):
            qty = product.stock_transactions.filter(warehouse=self.object).aggregate(total=Sum("quantity"))["total"] or 0
            if qty != 0:
                # Ajout dynamique de la quantité et du formatage pour le template
                product.current_qty = qty
                product.current_formatted_stock = product.get_formatted_stock_for_warehouse(warehouse=self.object)
                products_in_stock.append(product)
        context["products_in_stock"] = products_in_stock
        return context


class WarehouseCreateView(LoginRequiredMixin, CreateView):
    model = Warehouse
    fields = ["name", "location", "is_active"]
    template_name = "inventory/warehouse_form.html"
    success_url = reverse_lazy("inventory:warehouse-list")

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        for field in form.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})
        form.fields["is_active"].widget.attrs.update({"class": "form-check-input"})
        return form


class WarehouseUpdateView(LoginRequiredMixin, UpdateView):
    model = Warehouse
    fields = ["name", "location", "is_active"]
    template_name = "inventory/warehouse_form.html"
    success_url = reverse_lazy("inventory:warehouse-list")

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        for field in form.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})
        form.fields["is_active"].widget.attrs.update({"class": "form-check-input"})
        return form


class WarehouseDeleteView(LoginRequiredMixin, DeleteView):
    model = Warehouse
    template_name = "inventory/warehouse_confirm_delete.html"
    success_url = reverse_lazy("inventory:warehouse-list")

    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        if self.object.total_stock_value > 0:
            from django.contrib import messages
            messages.error(request, "Impossible de supprimer un entrepôt qui contient encore des articles.")
            return self.render_to_response(self.get_context_data())
        return super().post(request, *args, **kwargs)





