from django.urls import path
from .views import (
    ContainerListView, ContainerDetailView, ContainerCreateView, ContainerUpdateView,
    SupplierListView, SupplierCreateView, SupplierUpdateView,
    ContainerExpenseCreateView, ContainerExportView
)

app_name = "logistics"

urlpatterns = [
    # Conteneurs
    path("containers/", ContainerListView.as_view(), name="container-list"),
    path("containers/add/", ContainerCreateView.as_view(), name="container-add"),
    path("containers/export/", ContainerExportView.as_view(), name="container-export"),
    path("containers/<int:pk>/", ContainerDetailView.as_view(), name="container-detail"),
    path("containers/<int:pk>/edit/", ContainerUpdateView.as_view(), name="container-edit"),
    
    # Frais
    path("containers/<int:pk>/expenses/add/", ContainerExpenseCreateView.as_view(), name="expense-add"),
    
    # Fournisseurs
    path("suppliers/", SupplierListView.as_view(), name="supplier-list"),
    path("suppliers/add/", SupplierCreateView.as_view(), name="supplier-add"),
    path("suppliers/<int:pk>/edit/", SupplierUpdateView.as_view(), name="supplier-edit"),
]
