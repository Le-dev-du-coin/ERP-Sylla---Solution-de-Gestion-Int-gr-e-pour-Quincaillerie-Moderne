from django.db import models
from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Product, StockTransaction, Warehouse

class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = [
            "name", "description", "sku", "barcode", 
            "purchase_price", "sale_price_piece", "sale_price_carton", 
            "conversion_factor", "alert_threshold_cartons", "alert_threshold_pieces", "is_active"
        ]
        widgets = {
            "description": forms.Textarea(attrs={"rows": 3}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Le SKU est généré automatiquement s'il est vide
        self.fields["sku"].required = False
        for field in self.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})
        self.fields["is_active"].widget.attrs.update({"class": "form-check-input"})

class ProductThresholdForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ["alert_threshold_cartons", "alert_threshold_pieces"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})


class StockTransactionForm(forms.ModelForm):
    UNIT_CHOICES = [
        ("PIECE", "Pièce(s)"),
        ("CARTON", "Carton(s)"),
    ]
    input_unit = forms.ChoiceField(
        choices=UNIT_CHOICES, 
        initial="PIECE", 
        label="Unité de saisie",
        widget=forms.Select(attrs={"class": "form-select rounded-3"})
    )

    class Meta:
        model = StockTransaction
        fields = ["product", "warehouse", "type", "to_warehouse", "input_unit", "quantity", "notes"]
        labels = {
            "product": _("Article"),
            "warehouse": _("Entrepôt"),
            "type": _("Type de mouvement"),
            "to_warehouse": _("Entrepôt de destination"),
            "quantity": _("Quantité"),
            "notes": _("Notes / Motif"),
        }
        widgets = {
            "type": forms.Select(attrs={
                "class": "form-select rounded-3",
                "onchange": "toggleTransferField(this.value)"
            }),
            "to_warehouse": forms.Select(attrs={"class": "form-select rounded-3"}),
            "notes": forms.Textarea(attrs={"rows": 2}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            if not isinstance(field.widget, (forms.Select, forms.CheckboxInput)):
                field.widget.attrs.update({"class": "form-control rounded-3"})

        # On cache initialement le champ to_warehouse
        self.fields["to_warehouse"].required = False

        # Si l'entrepôt est déjà fixé (via l'URL), on le rend non modifiable
        # et on l'exclut de la liste des destinations possibles
        warehouse_id = self.initial.get("warehouse")
        if warehouse_id:
            self.fields["warehouse"].disabled = True
            self.fields["to_warehouse"].queryset = Warehouse.objects.exclude(id=warehouse_id)



