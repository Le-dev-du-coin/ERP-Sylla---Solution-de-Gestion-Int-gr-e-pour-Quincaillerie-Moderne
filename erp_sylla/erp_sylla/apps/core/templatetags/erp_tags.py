from django import template
from django.contrib.humanize.templatetags.humanize import intcomma

register = template.Library()

@register.filter(name="subtract")
def subtract(value, arg):
    """Soustrait arg de value."""
    try:
        # On fait la soustraction inverse car en stock on veut Threshold - Stock
        return int(value) - int(arg)
    except (ValueError, TypeError):
        return 0

@register.filter(name="money")
def money(value):
    """Formate un entier en Franc CFA."""
    if value is None: return "0 F CFA"
    try:
        formatted = intcomma(value).replace(",", " ")
        return f"{formatted} F CFA"
    except: return f"{value} F CFA"


