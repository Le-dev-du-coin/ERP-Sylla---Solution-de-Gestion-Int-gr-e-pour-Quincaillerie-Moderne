from django import forms
from .models import Container, LogisticsSupplier, ContainerExpense

class LogisticsSupplierForm(forms.ModelForm):
    class Meta:
        model = LogisticsSupplier
        fields = ["name", "country", "contact_person", "phone", "email"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})

class ContainerForm(forms.ModelForm):
    class Meta:
        model = Container
        fields = [
            "container_number", "order_reference", "supplier", "status",
            "origin_port", "destination_port", "main_product", "container_type",
            "quantity_packages", "order_date", "loading_date", "etd", "eta",
            "actual_arrival_date", "merchandise_value", "observation"
        ]
        widgets = {
            "order_date": forms.DateInput(attrs={"type": "date", "class": "form-control rounded-3"}),
            "loading_date": forms.DateInput(attrs={"type": "date", "class": "form-control rounded-3"}),
            "etd": forms.DateInput(attrs={"type": "date", "class": "form-control rounded-3"}),
            "eta": forms.DateInput(attrs={"type": "date", "class": "form-control rounded-3"}),
            "actual_arrival_date": forms.DateInput(attrs={"type": "date", "class": "form-control rounded-3"}),
            "observation": forms.Textarea(attrs={"rows": 3, "class": "form-control rounded-3"}),
            "status": forms.Select(attrs={"class": "form-select rounded-3"}),
            "supplier": forms.Select(attrs={"class": "form-select rounded-3"}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Liste des champs qui ont déjà un widget spécifique défini dans Meta
        custom_widgets = ["order_date", "loading_date", "etd", "eta", "actual_arrival_date", "observation", "status", "supplier"]
        for field_name, field in self.fields.items():
            if field_name not in custom_widgets:
                field.widget.attrs.update({"class": "form-control rounded-3"})

class ContainerExpenseForm(forms.ModelForm):
    class Meta:
        model = ContainerExpense
        fields = ["label", "amount", "notes"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            if isinstance(field.widget, forms.Textarea):
                field.widget.attrs.update({"class": "form-control rounded-3", "rows": 2})
            else:
                field.widget.attrs.update({"class": "form-control rounded-3"})
