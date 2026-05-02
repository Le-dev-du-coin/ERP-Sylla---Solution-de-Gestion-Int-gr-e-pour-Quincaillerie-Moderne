from django import forms
from django.core.exceptions import ValidationError
from .models import Customer

class CustomerForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ['name', 'phone', 'address']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control rounded-3', 'placeholder': 'Nom complet'}),
            'phone': forms.TextInput(attrs={
                'class': 'form-control rounded-3', 
                'placeholder': 'Ex: 223XXXXXXXXX (12 chiffres)',
                'maxlength': '12',
                'minlength': '12'
            }),
            'address': forms.Textarea(attrs={'class': 'form-control rounded-3', 'rows': 2, 'placeholder': 'Adresse physique'}),
        }

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        if phone:
            # Supprimer les espaces éventuels
            phone = phone.replace(" ", "")
            if len(phone) != 12:
                raise ValidationError("Le numéro de téléphone doit comporter exactement 12 chiffres (ex: 223XXXXXXXXX).")
            if not phone.isdigit():
                raise ValidationError("Le numéro de téléphone ne doit contenir que des chiffres.")
        return phone
