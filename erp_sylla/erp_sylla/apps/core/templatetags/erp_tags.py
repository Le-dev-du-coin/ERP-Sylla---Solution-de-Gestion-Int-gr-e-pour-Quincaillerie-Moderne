from django import template
from django.contrib.humanize.templatetags.humanize import intcomma

register = template.Library()

@register.filter(name="money")
def money(value):
    """
    Formate un entier en Franc CFA avec séparateur de milliers.
    Exemple : 1500 -> 1 500 F CFA
    """
    if value is None:
        return "0 F CFA"
    
    try:
        # On utilise intcomma pour le séparateur puis on remplace la virgule par un espace
        formatted_value = intcomma(value).replace(",", " ")
        return f"{formatted_value} F CFA"
    except (ValueError, TypeError):
        return f"{value} F CFA"
