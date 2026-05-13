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
            'link_validity_hours',
            'developer_test_phone'
        ]
        widgets = {
            'wachap_instance_id': forms.TextInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3'}),
            'wachap_token': forms.PasswordInput(render_value=True, attrs={'class': 'form-control rounded-pill border-0 bg-light px-3'}),
            'erp_version': forms.TextInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3'}),
            'manager_phone_1': forms.TextInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3', 'placeholder': 'Ex: 223XXXXXXXX'}),
            'manager_phone_2': forms.TextInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3', 'placeholder': 'Ex: 223XXXXXXXX'}),
            'report_time': forms.TimeInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3', 'type': 'time'}),
            'link_validity_hours': forms.NumberInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3'}),
            'developer_test_phone': forms.TextInput(attrs={'class': 'form-control rounded-pill border-0 bg-light px-3', 'placeholder': 'Ex: 223XXXXXXXX'}),
        }
