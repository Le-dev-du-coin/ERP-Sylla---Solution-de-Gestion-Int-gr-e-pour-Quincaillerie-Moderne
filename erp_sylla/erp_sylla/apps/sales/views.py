from django.views.generic import TemplateView, ListView, DetailView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
from erp_sylla.apps.core.permissions import GerantRequiredMixin
from django.urls import reverse_lazy
from django.shortcuts import render, redirect
from django.db.models import Q
from erp_sylla.apps.inventory.models import Product, Warehouse
from .models import Sale, SaleItem

from .cart import Basket
from django.views.decorators.http import require_POST
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, HttpResponseBadRequest


class POSView(LoginRequiredMixin, TemplateView):
    template_name = "sales/pos.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["basket"] = Basket(self.request)
        return context


class CheckoutView(LoginRequiredMixin, TemplateView):
    template_name = "sales/checkout.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["basket"] = Basket(self.request)
        # On ne propose les entrepôts que si le vendeur n'en a pas d'assigné
        if not self.request.user.assigned_warehouse:
            context["warehouses"] = Warehouse.objects.filter(is_active=True)
        return context

    def post(self, request, *args, **kwargs):
        basket = Basket(request)
        if not basket.total_items:
            from django.contrib import messages
            messages.error(request, "Votre panier est vide.")
            return redirect("sales:pos")

        # Récupération des données du formulaire
        payment_method = request.POST.get("payment_method", "CASH")
        sale_type = request.POST.get("sale_type", "SALE")
        
        # Logique de sélection automatique de l'entrepôt
        if request.user.assigned_warehouse:
            warehouse_id = request.user.assigned_warehouse.id
        else:
            warehouse_id = request.POST.get("warehouse")

        if not warehouse_id:
            from django.contrib import messages
            messages.error(request, "Erreur : Aucun entrepôt détecté pour cette vente.")
            return self.get(request, *args, **kwargs)

        from .services import complete_sale
        try:
            sale = complete_sale(
                basket=basket,
                user=request.user,
                warehouse_id=warehouse_id,
                sale_type=sale_type,
                payment_method=payment_method
            )
            return render(request, "sales/success.html", {"sale": sale})
        except Exception as e:
            from django.contrib import messages
            messages.error(request, f"Erreur lors de la validation : {str(e)}")
            return self.get(request, *args, **kwargs)



class SaleListView(LoginRequiredMixin, ListView):
    model = Sale
    template_name = "sales/sale_list.html"
    context_object_name = "sales"
    paginate_by = 20

    def get_queryset(self):
        queryset = super().get_queryset()
        sale_type = self.request.GET.get("type")
        if sale_type:
            queryset = queryset.filter(type=sale_type)
        return queryset


class SaleDetailView(LoginRequiredMixin, DetailView):
    model = Sale
    template_name = "sales/sale_detail.html"
    context_object_name = "sale"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Historique d'audit pour cette vente spécifique
        context["history_records"] = self.object.history.all()
        return context


class SaleDeleteView(GerantRequiredMixin, DeleteView):
    model = Sale
    template_name = "sales/sale_confirm_delete.html"
    success_url = reverse_lazy("sales:sale-list")





@login_required
@require_POST
def cart_add(request, product_id):
    """Ajoute un article au panier via HTMX."""
    basket = Basket(request)
    product = get_object_or_404(Product, id=product_id)
    unit = request.POST.get("unit", "PIECE")
    
    if unit not in ["PIECE", "CARTON"]:
        return HttpResponseBadRequest("Unité invalide.")

    basket.add(product=product, unit=unit)
    return render(request, "sales/_cart_detail.html", {"basket": basket, "is_htmx": True})


@login_required
@require_POST
def cart_remove(request, product_id, unit):
    """Supprime un article du panier via HTMX."""
    basket = Basket(request)
    basket.remove(product_id, unit)
    return render(request, "sales/_cart_detail.html", {"basket": basket, "is_htmx": True})


@login_required
@require_POST
def cart_update(request, product_id, unit):
    """Met à jour la quantité d'un article."""
    basket = Basket(request)
    action = request.POST.get("action") # 'plus' or 'minus'

    # On récupère la quantité actuelle
    key = f"{product_id}_{unit}"
    current_qty = basket.basket.get(key, {}).get("quantity", 0)

    if action == "plus":
        new_qty = current_qty + 1
    else:
        new_qty = current_qty - 1

    basket.update(product_id, unit, new_qty)
    return render(request, "sales/_cart_detail.html", {"basket": basket, "is_htmx": True})


@login_required
def product_search_ajax(request):
    """Recherche HTMX d'articles filtrée par l'entrepôt de l'utilisateur."""
    query = request.GET.get("q", "").strip()
    user = request.user
    
    if len(query) < 3:
        return HttpResponse("")

    # On récupère le magasin assigné ou le premier actif
    warehouse = user.assigned_warehouse or Warehouse.objects.filter(is_active=True).first()
    
    products = Product.objects.filter(
        Q(name__icontains=query) | 
        Q(sku__icontains=query) | 
        Q(barcode__icontains=query),
        is_active=True
    )[:10]

    # Pour chaque produit, on calcule le stock SPECIFIQUE au magasin
    from django.db.models import Sum
    for p in products:
        p.local_stock = p.stock_transactions.filter(warehouse=warehouse).aggregate(total=Sum("quantity"))["total"] or 0
        p.local_formatted_stock = p.get_formatted_stock_for_warehouse(warehouse=warehouse)

    return render(request, "sales/_search_results.html", {"products": products, "warehouse": warehouse})



@login_required
def get_product_stock_info(request):
    """Vue pour HTMX : renvoie le stock actuel local."""
    product_id = request.GET.get("product")
    user = request.user
    # On utilise l'entrepôt assigné ou celui passé en paramètre
    warehouse = user.assigned_warehouse
    if not warehouse and request.GET.get("warehouse"):
        warehouse = Warehouse.objects.get(id=request.GET.get("warehouse"))
    
    if not product_id or not warehouse:
        return HttpResponse("")

    try:
        product = Product.objects.get(id=product_id)
        total = product.stock_transactions.filter(warehouse=warehouse).aggregate(total=Sum("quantity"))["total"] or 0
        
        cartons = total // product.conversion_factor
        pieces = total % product.conversion_factor
        
        html = f"""
            <div id="product-info-panel" class="alert alert-warning border-0 shadow-sm mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-info-circle me-2"></i> Stock à {warehouse.name} :</span>
                    <span class="fw-bold fs-5">{total} pièces ({cartons} ct & {pieces} pc)</span>
                </div>
                <input type="hidden" id="current_conv_factor" value="{product.conversion_factor}">
            </div>
        """
        return HttpResponse(html)
    except (Product.DoesNotExist, Warehouse.DoesNotExist, ValueError):
        return HttpResponse("")
