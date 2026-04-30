from django.views.generic import TemplateView, ListView, CreateView
from django.contrib.auth.mixins import LoginRequiredMixin
from .permissions import GerantRequiredMixin, VendeurRequiredMixin
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseBadRequest
from django.urls import reverse_lazy, reverse
from django.db.models import Sum, Q, F, Count, Avg
from django.db.models.functions import TruncDate, Coalesce
from django.utils import timezone
from .services import validate_release_code, BackupService
from django.core.exceptions import ValidationError
from .models import Expense, ExpenseCategory, DatabaseBackup
from django.contrib import messages
from erp_sylla.apps.sales.models import Sale, Payment, SaleItem
from erp_sylla.apps.inventory.models import Product, Warehouse, StockTransaction
import datetime
import json
from django.http import JsonResponse

class POSView(VendeurRequiredMixin, TemplateView):
    template_name = "core/pos.html"

class DashboardVendeurView(VendeurRequiredMixin, TemplateView):
    """Tableau de bord simplifié pour les vendeurs."""
    template_name = "core/dashboard_vendeur.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        today = timezone.now().date()
        
        # Filtre les ventes du vendeur pour aujourd'hui
        my_sales = Sale.objects.filter(
            created_at__date=today, 
            type=Sale.Types.VENTE,
            # Supposons qu'il y ait un champ 'created_by' ou similaire dans Sale
            # Si non, on prend toutes les ventes du jour pour la boutique
        )
        
        context['total_sales_amount'] = my_sales.aggregate(total=Sum('total_amount'))['total'] or 0
        context['sales_count'] = my_sales.count()
        
        # Top produit du jour pour ce vendeur
        top_item = SaleItem.objects.filter(
            sale__in=my_sales
        ).values('product__name').annotate(
            total_qty=Sum('quantity')
        ).order_by('-total_qty').first()
        
        context['top_product'] = top_item['product__name'] if top_item else "Aucun"
        
        # Commandes/Devis en attente (optionnel selon le modèle)
        context['pending_quotes'] = Sale.objects.filter(
            type=Sale.Types.DEVIS,
            status=Sale.Status.PENDING
        ).count()

        return context

@login_required
@require_POST
def validate_code_ajax(request):
    """Vue HTMX pour valider un code de déblocage."""
    code_str = request.POST.get("release_code", "").strip()
    op_type = request.POST.get("op_type")
    
    try:
        success, release_code = validate_release_code(
            code_str=code_str,
            user=request.user,
            operation_type=op_type
        )
        
        response = HttpResponse("")
        response["HX-Trigger"] = "code-validated"
        return response
        
    except ValidationError as e:
        return render(request, "core/partials/release_code_modal.html", {
            "error": str(e.message),
            "op_type": op_type
        })

# --- PILOTAGE BI ---

class DashboardFinancierView(GerantRequiredMixin, TemplateView):
    """Tableau de bord Business Intelligence (BI)."""
    template_name = "core/dashboard_financier.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        # Période par défaut : 30 derniers jours
        days = int(self.request.GET.get('days', 30))
        start_date = timezone.now().date() - datetime.timedelta(days=days)
        
        # 1. KPIs GLOBAUX
        sales_qs = Sale.objects.filter(created_at__date__gte=start_date, type=Sale.Types.VENTE)
        context['total_ca'] = sales_qs.aggregate(total=Sum('total_amount'))['total'] or 0
        context['sales_count'] = sales_qs.count()
        context['avg_basket'] = sales_qs.aggregate(avg=Avg('total_amount'))['avg'] or 0
        
        # Calcul de la marge brute (Ventes - Coût d'achat)
        items_qs = SaleItem.objects.filter(sale__created_at__date__gte=start_date, sale__type=Sale.Types.VENTE)
        # On multiplie la qté par (prix_vente - prix_achat) pour chaque ligne
        margin_data = items_qs.annotate(
            margin_line=(F('unit_price') - F('product__purchase_price')) * F('quantity')
        ).aggregate(total_margin=Sum('margin_line'))
        context['total_margin'] = margin_data['total_margin'] or 0
        
        # 2. VALORISATION DU STOCK
        # On calcule la valeur = Somme (Quantité actuelle * Prix d'achat)
        # Pour être performant, on utilise une annotation complexe
        stock_value_qs = Product.objects.annotate(
            current_qty=Coalesce(Sum('stock_transactions__quantity'), 0)
        ).annotate(
            computed_value=F('current_qty') * F('purchase_price')
        )
        context['total_stock_value'] = stock_value_qs.aggregate(total=Sum('computed_value'))['total'] or 0
        
        # Valeur par entrepôt
        warehouses_val = []
        for wh in Warehouse.objects.filter(is_active=True):
            val = Product.objects.filter(stock_transactions__warehouse=wh).annotate(
                qty=Sum('stock_transactions__quantity')
            ).aggregate(total=Sum(F('qty') * F('purchase_price')))['total'] or 0
            if val > 0:
                warehouses_val.append({'name': wh.name, 'value': val})
        context['warehouses_value'] = warehouses_val

        # 3. GRAPHIQUE ÉVOLUTION CA (Ligne)
        daily_sales = sales_qs.annotate(date=TruncDate('created_at')) \
                             .values('date') \
                             .annotate(total=Sum('total_amount')) \
                             .order_by('date')
        
        context['chart_ca_labels'] = [d['date'].strftime('%d/%m') for d in daily_sales]
        context['chart_ca_values'] = [d['total'] for d in daily_sales]

        # 4. RÉPARTITION PAIEMENTS (Cercle)
        methods_labels = {'CASH': 'Espèces', 'ORANGE': 'Orange', 'WAVE': 'Wave', 'MOOV': 'Moov', 'CHEQUE': 'Chèque', 'CREDIT': 'Crédit'}
        payment_data = sales_qs.values('payment_method').annotate(count=Count('id'))
        
        context['chart_pay_labels'] = [methods_labels.get(p['payment_method'], p['payment_method']) for p in payment_data]
        context['chart_pay_values'] = [p['count'] for p in payment_data]

        # 5. TOP 10 PRODUITS (Quantité)
        top_products = SaleItem.objects.filter(sale__created_at__date__gte=start_date, sale__type=Sale.Types.VENTE) \
                                      .values('product__name', 'product__sku') \
                                      .annotate(total_qty=Sum('quantity'), total_revenue=Sum('total_line')) \
                                      .order_by('-total_qty')[:10]
        context['top_products'] = top_products
        
        # 6. ALERTES ANALYTIQUES (Top ventes à stock faible)
        context['risk_products'] = Product.objects.annotate(
            qty=Coalesce(Sum('stock_transactions__quantity'), 0)
        ).filter(qty__lte=F('low_stock_threshold')).order_by('qty')[:5]

        context['selected_days'] = days
        return context

# --- VUES POUR LES DÉPENSES ---

class ExpenseListView(VendeurRequiredMixin, ListView):
    model = Expense
    template_name = "core/expense_list.html"
    context_object_name = "expenses"
    paginate_by = 20

    def get_queryset(self):
        queryset = super().get_queryset().select_related('category', 'recorded_by')
        q = self.request.GET.get('q')
        if q:
            queryset = queryset.filter(Q(title__icontains=q) | Q(notes__icontains=q))
        return queryset

class ExpenseCreateView(VendeurRequiredMixin, CreateView):
    model = Expense
    fields = ['title', 'category', 'amount', 'date', 'notes', 'receipt']
    template_name = "core/expense_form.html"
    success_url = reverse_lazy("core:expense-list")

    def form_valid(self, form):
        form.instance.recorded_by = self.request.user
        from django.contrib import messages
        messages.success(self.request, "Dépense enregistrée avec succès.")
        return super().form_valid(form)

# --- JOURNAL DE CAISSE ---

class CashJournalView(VendeurRequiredMixin, TemplateView):
    """Vue récapitulative des Entrées (Ventes/Versements) et Sorties (Dépenses)."""
    template_name = "core/cash_journal.html"

    def get_template_names(self):
        # On ne renvoie le partiel que si c'est une mise à jour des filtres (cible journal-content)
        # Si c'est une navigation globale (boost), on renvoie la page complète
        if self.request.headers.get("HX-Target") == "journal-content":
            return ["core/partials/cash_journal_table.html"]
        return [self.template_name]

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        start_date_str = self.request.GET.get('start_date')
        end_date_str = self.request.GET.get('end_date')
        
        today = timezone.now().date()
        
        try:
            start_date = datetime.datetime.strptime(start_date_str, '%Y-%m-%d').date() if start_date_str else today
            end_date = datetime.datetime.strptime(end_date_str, '%Y-%m-%d').date() if end_date_str else today
        except ValueError:
            start_date = end_date = today
            
        context['start_date'] = start_date
        context['end_date'] = end_date

        sales_in = Sale.objects.filter(created_at__date__range=(start_date, end_date), type=Sale.Types.VENTE).exclude(payment_method=Sale.PaymentMethods.CREDIT)
        payments_in = Payment.objects.filter(created_at__date__range=(start_date, end_date))
        
        payment_summary = []
        methods = {'CASH': 'Espèces', 'ORANGE': 'Orange Money', 'WAVE': 'Wave', 'MOOV': 'Moov Money', 'CHEQUE': 'Chèque'}
        
        for code, label in methods.items():
            s_total = sales_in.filter(payment_method=code).aggregate(total=Sum('total_amount'))['total'] or 0
            p_total = payments_in.filter(payment_method=code).aggregate(total=Sum('amount'))['total'] or 0
            total = s_total + p_total
            if total > 0:
                payment_summary.append({'label': label, 'total': total})

        total_sales_in = sales_in.aggregate(total=Sum('total_amount'))['total'] or 0
        total_payments_in = payments_in.aggregate(total=Sum('amount'))['total'] or 0
        
        context['total_in'] = total_sales_in + total_payments_in
        context['sales_in'] = sales_in
        context['payments_in'] = payments_in
        context['payment_summary'] = payment_summary

        expenses_out = Expense.objects.filter(date__range=(start_date, end_date))
        context['total_out'] = expenses_out.aggregate(total=Sum('amount'))['total'] or 0
        context['expenses_out'] = expenses_out
        context['net_balance'] = context['total_in'] - context['total_out']
        
        return context

# --- PARAMÈTRES & BACKUPS ---

class SettingsDashboardView(GerantRequiredMixin, TemplateView):
    """Vue regroupant les paramètres du système et la gestion des sauvegardes."""
    template_name = "core/settings_dashboard.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['backups'] = DatabaseBackup.objects.all()[:10]
        return context

@login_required
@require_POST
def create_manual_backup(request):
    """Déclenche une sauvegarde manuelle via le service."""
    # Vérification simple du rôle (le décorateur GerantRequiredMixin n'est pas utilisable ici directement sur une fonction)
    if not request.user.is_superuser and not getattr(request.user, 'role', '') == 'GERANT':
        from django.http import HttpResponseForbidden
        return HttpResponseForbidden()
        
    backup, error = BackupService.create_backup(backup_type=DatabaseBackup.BackupType.MANUAL)
    if backup:
        messages.success(request, f"Sauvegarde réussie : {backup.file.name}")
    else:
        messages.error(request, f"Erreur lors de la sauvegarde : {error}")
    
    return redirect("core:settings-dashboard")

class ExpenseCategoryListView(GerantRequiredMixin, ListView):
    model = ExpenseCategory
    template_name = "core/expense_category_list.html"
    context_object_name = "categories"
    paginate_by = 50

class ExpenseCategoryCreateView(GerantRequiredMixin, CreateView):
    model = ExpenseCategory
    fields = ['name', 'description']
    template_name = "core/expense_category_form.html"
    success_url = reverse_lazy("core:expense-category-list")

    def form_valid(self, form):
        from django.contrib import messages
        messages.success(self.request, f"La catégorie '{form.cleaned_data['name']}' a été créée.")
        return super().form_valid(form)
