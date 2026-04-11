from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render
from django.db.models import Q
from erp_sylla.apps.inventory.models import Product


class POSView(LoginRequiredMixin, TemplateView):
    template_name = "sales/pos.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # On peut passer quelques infos initiales si besoin
        return context


def product_search_ajax(request):
    """Recherche HTMX d'articles pour le POS."""
    query = request.GET.get("q", "").strip()
    
    if len(query) < 3:
        return HttpResponse("") # On ne renvoie rien si moins de 3 caractères

    products = Product.objects.filter(
        Q(name__icontains=query) | 
        Q(sku__icontains=query) | 
        Q(barcode__icontains=query),
        is_active=True
    )[:10]

    return render(request, "sales/_search_results.html", {"products": products})


from django.http import HttpResponse # Pour le fallback si besoin

