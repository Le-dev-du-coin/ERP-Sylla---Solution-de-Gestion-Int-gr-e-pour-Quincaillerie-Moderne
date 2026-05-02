from django.views.generic import ListView, CreateView, UpdateView, DeleteView, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy
from django.db import models, transaction
from django.db.models import Sum, F, ExpressionWrapper, IntegerField, Value
from django.db.models.functions import Coalesce
from .models import Product, Warehouse, StockTransaction
from .forms import ProductForm, StockTransactionForm
from erp_sylla.apps.core.permissions import GerantRequiredMixin
from .forms import ProductThresholdForm


from django.shortcuts import redirect, render
from django.contrib import messages
from tablib import Dataset
from .resources import ProductResource

from django.db.models import ProtectedError

class ProductExportView(LoginRequiredMixin, GerantRequiredMixin, ListView):
    def get(self, request, *args, **kwargs):
        resource = ProductResource()
        dataset = resource.export()
        response = HttpResponse(dataset.xlsx, content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        response['Content-Disposition'] = 'attachment; filename="export_produits.xlsx"'
        return response

class ProductImportView(LoginRequiredMixin, GerantRequiredMixin, CreateView):
    template_name = "inventory/product_import.html"
    
    def get(self, request, *args, **kwargs):
        return render(request, self.template_name)
        
    def post(self, request, *args, **kwargs):
        if 'file' not in request.FILES:
            messages.error(request, "Veuillez sélectionner un fichier.")
            return render(request, self.template_name)
            
        file = request.FILES['file']
        if not file.name.endswith(('.xlsx', '.xls')):
            messages.error(request, "Le fichier doit être au format Excel (.xlsx ou .xls).")
            return render(request, self.template_name)
            
        try:
            import pandas as pd
            try:
                df = pd.read_excel(file, sheet_name='Produits', skiprows=4)
            except Exception:
                df = pd.read_excel(file)
            
            df = df.dropna(subset=['Code produit', 'Désignation'], how='all')
            if df.empty:
                messages.error(request, "Le fichier semble vide ou mal formaté.")
                return render(request, self.template_name)

            dataset = Dataset().load(df)
            resource = ProductResource()
            result = resource.import_data(dataset, dry_run=False, raise_errors=False)
            
            if result.has_errors():
                messages.error(request, f"L'importation a rencontré des erreurs ({len(result.row_errors())} lignes en échec).")
            else:
                messages.success(request, f"Importation réussie : {result.total_rows} produits traités.")
            return redirect("inventory:product-list")
        except Exception as e:
            messages.error(request, f"Erreur lors de l'importation : {str(e)}")
            return render(request, self.template_name)


class BulkDeleteProductsView(LoginRequiredMixin, GerantRequiredMixin, ListView):
    """Vue pour supprimer plusieurs produits à la fois."""
    def post(self, request, *args, **kwargs):
        product_ids = request.POST.getlist('product_ids')
        if not product_ids:
            messages.warning(request, "Aucun article sélectionné.")
            return redirect('inventory:product-list')
        
        products = Product.objects.filter(id__in=product_ids)
        count = 0
        errors = 0
        
        for product in products:
            try:
                product.delete()
                count += 1
            except ProtectedError:
                # Si protégé, on désactive au lieu de supprimer
                product.is_active = False
                product.save()
                errors += 1
        
        if count > 0:
            messages.success(request, f"{count} articles ont été supprimés.")
        if errors > 0:
            messages.info(request, f"{errors} articles n'ont pas pu être supprimés (liés à des ventes) et ont été désactivés à la place.")
            
        return redirect('inventory:product-list')

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

    def post(self, request, *args, **kwargs):
        try:
            return super().post(request, *args, **kwargs)
        except ProtectedError:
            product = self.get_object()
            product.is_active = False
            product.save()
            messages.info(request, f"L'article '{product.name}' est lié à des ventes. Il a été désactivé au lieu d'être supprimé.")
            return redirect(self.success_url)

class StockStatusView(LoginRequiredMixin, ListView):
    model = Product
    template_name = "inventory/stock_status.html"
    context_object_name = "products"
    paginate_by = 50

from erp_sylla.apps.core.permissions import GerantRequiredMixin, VendeurRequiredMixin

class LowStockListView(VendeurRequiredMixin, ListView):
    """Affiche les articles en alerte de stock."""
    model = Product
    template_name = "inventory/low_stock_list.html"
    context_object_name = "products"
    paginate_by = 30

    def get_queryset(self):
        # Optimisation : une seule requête SQL avec annotation et filtre
        # Coalesce(..., 0) permet de gérer les articles sans transactions (NULL -> 0)
        return Product.objects.annotate(
            total_stock_calc=Coalesce(Sum("stock_transactions__quantity"), Value(0))
        ).filter(
            total_stock_calc__lte=F("low_stock_threshold")
        )

class ProductThresholdUpdateView(GerantRequiredMixin, UpdateView):
    model = Product
    form_class = ProductThresholdForm
    template_name = "inventory/partials/product_threshold_form.html"
    
    def get_success_url(self):
        return reverse_lazy("inventory:stock-alerts")

    def form_valid(self, form):
        # Sauvegarde manuelle pour avoir un contrôle total sur la réponse
        self.object = form.save()
        if self.request.htmx:
            # On renvoie un 200 OK avec le header de redirection pour HTMX
            from django.http import HttpResponse
            response = HttpResponse("")
            response["HX-Redirect"] = str(self.get_success_url())
            return response
        return super().form_valid(form)


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
        
        # Suggérer l'unité : CARTON si conversion > 1, sinon PIECE
        suggested_unit = "CARTON" if product.conversion_factor > 1 else "PIECE"
        
        html = f"""
            <div id="product-info-panel" class="alert alert-warning border-0 shadow-sm mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-info-circle me-2"></i> Stock actuel ici :</span>
                    <span class="fw-bold fs-5">{total} pièces ({cartons} ct & {pieces} pc)</span>
                </div>
                <input type="hidden" id="current_conv_factor" value="{product.conversion_factor}">
                <input type="hidden" id="suggested_unit" value="{suggested_unit}">
            </div>
        """
        return HttpResponse(html)
    except (Product.DoesNotExist, ValueError):
        return HttpResponse("")


class WarehouseListView(LoginRequiredMixin, ListView):
    model = Warehouse
    template_name = "inventory/warehouse_list.html"
    context_object_name = "warehouses"
    paginate_by = 10

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





