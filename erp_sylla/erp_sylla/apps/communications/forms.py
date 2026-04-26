from django import forms
from .models import CommunicationConfig

class CommunicationConfigForm(forms.ModelForm):
    class Meta:
        model = CommunicationConfig
        fields = [
            'wachap_instance_id', 
            'wachap_token', 
            'erp_version', 
            'manager_phone_1', 
            'manager_phone_2', 
            'report_time',
            'link_validity_hours'
        ]
        widgets = {
            'wachap_instance_id': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Instance ID'}),
            'wachap_token': forms.PasswordInput(render_value=True, attrs={'class': 'form-control', 'placeholder': 'Token API'}),
            'erp_version': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'v1.x.x'}),
            'manager_phone_1': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '+223...'}),
            'manager_phone_2': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '+223...'}),
            # Pas de type="time" : le sélecteur natif suit la locale (souvent 12 h AM/PM).
            # TimeInput texte + format %H:%M affiche et saisit en 24 h (ex. 20:00).
            'report_time': forms.TimeInput(
                format='%H:%M',
                attrs={
                    'class': 'form-control',
                    'placeholder': '20:00',
                    'autocomplete': 'off',
                    'inputmode': 'numeric',
                    'title': 'Heure au format 24 h (HH:MM)',
                },
            ),
            'link_validity_hours': forms.NumberInput(attrs={'class': 'form-control'}),
        }
