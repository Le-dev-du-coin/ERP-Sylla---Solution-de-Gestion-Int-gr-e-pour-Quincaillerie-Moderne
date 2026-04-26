from django.urls import path
from .views import (
    DashboardFinancierView, 
    DashboardVendeurView,
    POSView, 
    validate_code_ajax,
    ExpenseListView,
    ExpenseCreateView,
    ExpenseCategoryListView,
    ExpenseCategoryCreateView,
    CashJournalView,
    SettingsDashboardView,
    create_manual_backup
)

app_name = "core"

urlpatterns = [
    path("vendeur/", DashboardVendeurView.as_view(), name="vendeur-dashboard"),
    path("finance/", DashboardFinancierView.as_view(), name="finance"),
    path("pos/", POSView.as_view(), name="pos"),
    path("ajax/validate-code/", validate_code_ajax, name="validate-code"),
    
    # Dépenses
    path("expenses/", ExpenseListView.as_view(), name="expense-list"),
    path("expenses/add/", ExpenseCreateView.as_view(), name="expense-add"),
    path("expenses/categories/", ExpenseCategoryListView.as_view(), name="expense-category-list"),
    path("expenses/categories/add/", ExpenseCategoryCreateView.as_view(), name="expense-category-add"),
    
    # Journal de Caisse
    path("journal/", CashJournalView.as_view(), name="cash-journal"),

    # Paramètres & Backups
    path("settings/", SettingsDashboardView.as_view(), name="settings-dashboard"),
    path("settings/backup/", create_manual_backup, name="create-manual-backup"),
]
