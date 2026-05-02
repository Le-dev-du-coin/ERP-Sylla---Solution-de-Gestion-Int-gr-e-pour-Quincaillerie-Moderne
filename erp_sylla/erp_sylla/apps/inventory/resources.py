from import_export import resources, fields
from import_export.widgets import ForeignKeyWidget, BooleanWidget
from .models import Product, Category

class ProductResource(resources.ModelResource):
    sku = fields.Field(
        column_name='Code produit',
        attribute='sku'
    )
    name = fields.Field(
        column_name='Désignation',
        attribute='name'
    )
    category = fields.Field(
        column_name='Catégorie',
        attribute='category',
        widget=ForeignKeyWidget(Category, 'name')
    )
    conversion_factor = fields.Field(
        column_name='Pièces / carton',
        attribute='conversion_factor'
    )
    purchase_price = fields.Field(
        column_name='Coût d’achat par pièce (FCFA)',
        attribute='purchase_price'
    )
    is_zakat_eligible = fields.Field(
        column_name='Éligible zakat (Oui/Non)',
        attribute='is_zakat_eligible',
        widget=BooleanWidget()
    )
    
    class Meta:
        model = Product
        fields = (
            'sku', 
            'name', 
            'category', 
            'conversion_factor', 
            'purchase_price', 
            'is_zakat_eligible', 
            'barcode'
        )
        export_order = fields
        import_id_fields = ('sku',)

    def before_import_row(self, row, **kwargs):
        """Nettoyage des données avant l'import."""
        # Normalisation de la Zakat (Oui/Non -> True/False)
        zakat_col = 'Éligible zakat (Oui/Non)'
        if zakat_col in row:
            val = str(row[zakat_col]).lower()
            if 'oui' in val:
                row[zakat_col] = True
            else:
                row[zakat_col] = False
            
        # Création automatique de la catégorie si elle n'existe pas
        cat_col = 'Catégorie'
        if cat_col in row and isinstance(row[cat_col], str):
            cat_name = row[cat_col].strip()
            Category.objects.get_or_create(name=cat_name)
            row[cat_col] = cat_name
            
        # Gestion des colonnes numériques pour éviter les erreurs NaN
        numeric_cols = ['Pièces / carton', 'Coût d’achat par pièce (FCFA)']
        import math
        for col in numeric_cols:
            if col in row:
                val = row[col]
                try:
                    if val is None or (isinstance(val, float) and math.isnan(val)):
                        row[col] = 0
                except (TypeError, ValueError):
                    row[col] = 0
