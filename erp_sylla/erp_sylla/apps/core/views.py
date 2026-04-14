from django.views.generic import TemplateView
from django.contrib.auth.mixins import LoginRequiredMixin
from .permissions import GerantRequiredMixin, VendeurRequiredMixin
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.http import HttpResponse
from .services import validate_release_code
from django.core.exceptions import ValidationError

class DashboardFinancierView(GerantRequiredMixin, TemplateView):
    template_name = "core/dashboard_financier.html"

class POSView(VendeurRequiredMixin, TemplateView):
    template_name = "core/pos.html"


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
        
        # Si succès, on ferme la modal et on déclenche l'événement de succès
        response = HttpResponse("") # On renvoie vide pour supprimer la modal (si swap="outerHTML" et target="#release-code-modal")
        response["HX-Trigger"] = "code-validated"
        return response
        
    except ValidationError as e:
        # En cas d'erreur, on renvoie le fragment avec le message d'erreur
        return render(request, "core/partials/release_code_modal.html", {
            "error": str(e.message),
            "op_type": op_type
        })
