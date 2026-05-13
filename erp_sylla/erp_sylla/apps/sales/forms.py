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
                'placeholder': 'Ex: 70000000 ou 22370000000',
                'maxlength': '15',
            }),
            'address': forms.Textarea(attrs={'class': 'form-control rounded-3', 'rows': 2, 'placeholder': 'Adresse physique'}),
        }

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        if phone:
            # Supprimer les espaces et caractères non numériques
            phone = "".join(filter(str.isdigit, phone))
            
            if len(phone) == 8:
                phone = "223" + phone
            
            if len(phone) != 11:
                raise ValidationError("Le numéro de téléphone doit comporter 8 chiffres (Mali) ou 11 chiffres avec l'indicatif 223.")
            
        return phone
