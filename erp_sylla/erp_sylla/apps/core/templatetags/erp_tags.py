from django import template
from django.contrib.humanize.templatetags.humanize import intcomma
from num2words import num2words

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

@register.filter(name="amount_to_words")
def amount_to_words(value):
    """Convertit un montant en toutes lettres (Français)."""
    if value is None: return ""
    try:
        words = num2words(value, lang='fr')
        return f"{words} francs CFA".capitalize()
    except Exception:
        return f"{value} francs CFA"


