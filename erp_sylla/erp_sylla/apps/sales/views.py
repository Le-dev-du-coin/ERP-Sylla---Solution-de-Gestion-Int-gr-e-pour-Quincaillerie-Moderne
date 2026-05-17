from django.views import View
from django.views.generic import TemplateView, ListView, DetailView, DeleteView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin
from erp_sylla.apps.core.permissions import GerantRequiredMixin
from django.urls import reverse_lazy, reverse
from django.shortcuts import render, redirect
from django.db.models import Q
from erp_sylla.apps.inventory.models import Product, Warehouse
from .models import Sale, SaleItem, Customer, Payment

from .cart import Basket
from django.views.decorators.http import require_POST
from django.shortcuts import get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, HttpResponseBadRequest
from django_weasyprint import WeasyTemplateResponseMixin


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
        context["assigned_warehouse"] = self.request.user.assigned_warehouse
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
        customer_phone = request.POST.get("customer_phone", "").strip()
        customer_name = request.POST.get("customer_name", "").strip()
        customer_id = request.POST.get("customer_id")
        
        # La sortie se fait toujours depuis l'entrepôt lié au vendeur.
        warehouse_id = request.user.assigned_warehouse.id if request.user.assigned_warehouse else None

        if not warehouse_id:
            from django.contrib import messages
            messages.error(
                request,
                "Erreur : aucun entrepôt n'est assigné à votre compte vendeur. Contactez un gérant.",
            )
            return self.get(request, *args, **kwargs)

        from .services import complete_sale
        try:
            sale = complete_sale(
                basket=basket,
                user=request.user,
                warehouse_id=warehouse_id,
                sale_type=sale_type,
                payment_method=payment_method,
                customer_phone=customer_phone,
                customer_id=customer_id,
                customer_name=customer_name
            )
            return render(request, "sales/success.html", {"sale": sale})
        except Exception as e:
            from django.contrib import messages
            messages.error(request, f"Erreur lors de la validation : {str(e)}")
            return self.get(request, *args, **kwargs)


@login_required
def customer_search_ajax(request):
    """Recherche HTMX de clients."""
    query = request.GET.get("q", "").strip()
    if len(query) < 2:
        return HttpResponse("")

    customers = Customer.objects.filter(
        Q(name__icontains=query) | Q(phone__icontains=query)
    )[:5]
    return render(request, "sales/_customer_search_results.html", {"customers": customers})


class CustomerListView(LoginRequiredMixin, ListView):
    model = Customer
    template_name = "sales/customer_list.html"
    context_object_name = "customers"
    paginate_by = 20

    def get_queryset(self):
        queryset = super().get_queryset()
        query = self.request.GET.get("q")
        if query:
            queryset = queryset.filter(Q(name__icontains=query) | Q(phone__icontains=query))
        return queryset


class CustomerDetailView(LoginRequiredMixin, DetailView):
    model = Customer
    template_name = "sales/customer_detail.html"
    context_object_name = "customer"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Historique d'audit
        context["history_records"] = self.object.history.all()
        # Ventes associées
        context["sales"] = self.object.sales.all()[:10]
        return context



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


class SaleCancelView(LoginRequiredMixin, View):
    """Permet au vendeur d'annuler une vente avec remise en stock si le code est valide."""
    def post(self, request, pk):
        sale = get_object_or_404(Sale, pk=pk)
        code_str = request.POST.get("code", "").strip().upper()

        # 1. Validation du code de déblocage
        from erp_sylla.apps.core.services import validate_release_code
        from django.core.exceptions import ValidationError
        try:
            validate_release_code(code_str, request.user, "CANCEL")
        except ValidationError as e:
            from django.contrib import messages
            messages.error(request, f"Échec annulation : {str(e)}")
            return redirect("sales:sale-detail", pk=pk)

        # 2. Exécution de l'annulation
        from .services import cancel_sale
        try:
            cancel_sale(sale, request.user)
            from django.contrib import messages
            messages.success(request, f"La vente {sale.invoice_number} a été annulée TOTALEMENT.")
        except Exception as e:
            from django.contrib import messages
            messages.error(request, f"Erreur lors de l'annulation : {str(e)}")
            
        return redirect("sales:sale-detail", pk=pk)





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
    """Met à jour la quantité, le prix ou l'unité d'un article."""
    basket = Basket(request)
    action = request.POST.get("action")
    price = request.POST.get("price")
    new_unit = request.POST.get("new_unit")
    qty_input = request.POST.get("quantity")

    # On récupère la quantité actuelle
    key = f"{product_id}_{unit}"
    current_item = basket.basket.get(key, {})
    current_qty = current_item.get("quantity", 0)

    # 1. Gestion du changement d'unité
    if new_unit and new_unit != unit and new_unit in ["PIECE", "CARTON"]:
        product = get_object_or_404(Product, id=product_id)
        basket.remove(product_id, unit)
        basket.add(product=product, unit=new_unit, quantity=current_qty)
        if price:
            basket.update(product_id, new_unit, price=price)
    else:
        # 2. Gestion de la quantité
        new_qty = None
        if qty_input is not None:
            try:
                new_qty = int(qty_input)
            except (ValueError, TypeError):
                new_qty = current_qty
        elif action == "plus":
            new_qty = current_qty + 1
        elif action == "minus":
            new_qty = current_qty - 1
        
        # Mise à jour (quantité et/ou prix)
        basket.update(product_id, unit, quantity=new_qty, price=price)
    
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


@login_required
@require_POST
def request_release_code_ajax(request):
    """Génère un code de déblocage et l'envoie au gérant par WhatsApp."""
    from erp_sylla.apps.core.models import ReleaseCode
    from erp_sylla.apps.core.services import send_release_code_whatsapp
    from django.utils import timezone
    from datetime import timedelta

    operation_type = request.POST.get("operation_type", "DISCOUNT")
    
    # Création du code
    code = ReleaseCode.objects.create(
        operation_type=operation_type,
        created_by=request.user,
        expires_at=timezone.now() + timedelta(minutes=15)
    )
    
    # Envoi WhatsApp
    success = send_release_code_whatsapp(code)
    
    if success:
        return HttpResponse(
            '<div class="alert alert-success border-0 small shadow-sm">'
            '<i class="fas fa-check-circle me-2"></i> Code envoyé au gérant par WhatsApp.'
            '</div>'
        )
    else:
        return HttpResponse(
            '<div class="alert alert-warning border-0 small shadow-sm">'
            '<i class="fas fa-exclamation-triangle me-2"></i> Code généré mais échec envoi WhatsApp (Vérifiez la config).'
            '</div>'
        )


@login_required
@require_POST
def process_return_ajax(request, pk):
    """Valide le code et traite le retour produit."""
    sale = get_object_or_404(Sale, pk=pk)
    code_str = request.POST.get("code", "").strip().upper()
    reason = request.POST.get("reason", "")
    
    # Extraction des données d'articles
    # Le format attendu est return_qty_{item_id}
    items_data = []
    for key, value in request.POST.items():
        if key.startswith("return_qty_") and int(value) > 0:
            item_id = key.replace("return_qty_", "")
            items_data.append({
                "sale_item_id": item_id,
                "quantity": int(value)
            })

    if not items_data:
        return HttpResponse('<div class="alert alert-danger border-0 small">Veuillez saisir au moins une quantité à retourner.</div>')

    # 1. Validation du code de déblocage
    from erp_sylla.apps.core.services import validate_release_code
    from django.core.exceptions import ValidationError
    try:
        validate_release_code(code_str, request.user, "CANCEL") # On utilise CANCEL pour les retours aussi
    except ValidationError as e:
        return HttpResponse(f'<div class="alert alert-danger border-0 small"><i class="fas fa-times-circle me-2"></i> {str(e)}</div>')

    # 2. Traitement du retour
    from .services import process_product_return
    try:
        process_product_return(sale, items_data, request.user, reason)
        from django.contrib import messages
        messages.success(request, f"Le retour sur la facture {sale.invoice_number} a été enregistré.")
        return HttpResponse(headers={"HX-Redirect": reverse("sales:sale-detail", args=[sale.pk])})
    except Exception as e:
        return HttpResponse(f'<div class="alert alert-danger border-0 small">Erreur : {str(e)}</div>')


class SaleInvoicePDFView(LoginRequiredMixin, WeasyTemplateResponseMixin, DetailView):
    model = Sale
    template_name = "sales/invoice_pdf.html"
    context_object_name = "sale"
    pdf_attachment = False # Affiche dans le navigateur au lieu de télécharger
    
    def get_pdf_filename(self):
        return f"Facture-{self.object.invoice_number}.pdf"


class PaymentReceiptPDFView(LoginRequiredMixin, WeasyTemplateResponseMixin, DetailView):
    model = Payment
    template_name = "sales/payment_receipt_pdf.html"
    context_object_name = "payment"
    pdf_attachment = False
    
    def get_pdf_filename(self):
        return f"Recu-{self.object.reference}.pdf"
from .forms import CustomerForm

class CustomerCreateView(LoginRequiredMixin, CreateView):
    model = Customer
    form_class = CustomerForm
    success_url = reverse_lazy("sales:customer-list")

    def form_valid(self, form):
        from django.contrib import messages
        messages.success(self.request, f"Le client {form.cleaned_data['name']} a été créé avec succès.")
        return super().form_valid(form)

@login_required
@require_POST
def process_payment_ajax(request, customer_id):
    """Enregistre un versement client via AJAX/HTMX."""
    customer = get_object_or_404(Customer, id=customer_id)
    amount = request.POST.get("amount")
    method = request.POST.get("payment_method", "CASH")
    notes = request.POST.get("notes", "")

    if not amount or int(amount) <= 0:
        return HttpResponse("Montant invalide.", status=400)

    from .services import process_payment
    try:
        payment = process_payment(
            customer=customer,
            amount=amount,
            method=method,
            received_by=request.user,
            notes=notes
        )
        from django.contrib import messages
        messages.success(request, f"Versement de {amount} F CFA enregistré avec succès pour {customer.name}.")
        
        # Redirection complète via HTMX (ferme la modal et affiche le message de succès)
        return HttpResponse(headers={"HX-Redirect": request.META.get('HTTP_REFERER', reverse("sales:customer-list"))})
    except ValueError as e:
        # On renvoie un petit fragment HTML d'erreur pour la zone d'erreur de la modal
        error_html = f'<div class="alert alert-danger border-0 small mb-4"><i class="fas fa-exclamation-circle me-2"></i> {str(e)}</div>'
        return HttpResponse(error_html)
    except Exception as e:
        error_html = f'<div class="alert alert-danger border-0 small mb-4"><i class="fas fa-exclamation-triangle me-2"></i> Une erreur est survenue : {str(e)}</div>'
        return HttpResponse(error_html)

@login_required
@require_POST
def resend_payment_whatsapp(request, payment_id):
    """Renvoie manuellement un reçu via WhatsApp."""
    payment = get_object_or_404(Payment, id=payment_id)
    if not payment.customer.phone:
        return HttpResponse("Le client n'a pas de numéro WhatsApp.", status=400)
    
    from .tasks import send_payment_notification_whatsapp_task
    send_payment_notification_whatsapp_task.delay(payment.id)
    
    from django.contrib import messages
    messages.success(request, f"Le reçu pour {payment.customer.name} a été mis en file d'attente pour envoi WhatsApp.")
    return HttpResponse(headers={"HX-Refresh": "true"})


class PaymentListView(LoginRequiredMixin, ListView):
    """Liste globale des versements effectués par les clients."""
    model = Payment
    template_name = "sales/payment_list.html"
    context_object_name = "payments"
    paginate_by = 20

    def get_queryset(self):
        queryset = Payment.objects.select_related('customer', 'received_by').all()
        query = self.request.GET.get("q")
        if query:
            queryset = queryset.filter(
                Q(customer__name__icontains=query) | 
                Q(reference__icontains=query)
            )
        return queryset

class AuditLogListView(GerantRequiredMixin, ListView):
    """Journal d'audit global (simple-history) pour le gérant."""
    template_name = "sales/audit_log.html"
    context_object_name = "history_records"
    paginate_by = 50

    def get_queryset(self):
        # On récupère l'historique des clients pour commencer
        # Dans un vrai système, on pourrait fusionner plusieurs historiques
        return Customer.history.all().select_related('history_user')

class QuoteConvertToSaleView(LoginRequiredMixin, View):
    """Permet de convertir un devis validé en vente réelle (avec déstockage)."""
    def post(self, request, pk):
        from .services import convert_quote_to_sale
        from django.contrib import messages
        
        sale = get_object_or_404(Sale, pk=pk, type=Sale.Types.DEVIS)
        
        # On utilise l'entrepôt assigné ou le premier disponible
        warehouse_id = getattr(request.user, 'assigned_warehouse_id', None)
        if not warehouse_id:
            warehouse = Warehouse.objects.filter(is_active=True).first()
            if not warehouse:
                messages.error(request, "Aucun entrepôt actif configuré pour le déstockage.")
                return redirect("sales:sale-detail", pk=pk)
            warehouse_id = warehouse.id

        try:
            convert_quote_to_sale(sale, request.user, warehouse_id)
            messages.success(request, f"Conversion réussie ! Le devis est devenu la facture {sale.invoice_number}.")
        except ValueError as e:
            messages.error(request, str(e))
        except Exception as e:
            import logging
            logger = logging.getLogger(__name__)
            logger.exception("Erreur lors de la conversion de devis")
            messages.error(request, f"Erreur technique : {str(e)}")
            
        return redirect("sales:sale-detail", pk=pk)
