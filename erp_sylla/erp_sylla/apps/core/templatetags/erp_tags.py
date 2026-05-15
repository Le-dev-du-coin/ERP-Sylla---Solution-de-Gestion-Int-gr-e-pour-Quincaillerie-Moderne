from django import template
from django.contrib.humanize.templatetags.humanize import intcomma
from num2words import num2words

register = template.Library()

@register.filter(name="subtract")
def subtract(value, arg):
    """Soustrait arg de value."""
    try:
        return int(value) - int(arg)
    except (ValueError, TypeError):
        return value

@register.filter(name="sum_refunds")
def sum_refunds(returns_queryset):
    """Calcule la somme totale des montants remboursés dans un queryset de retours."""
    if not returns_queryset:
        return 0
    return sum(r.total_refund_amount for r in returns_queryset)

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


