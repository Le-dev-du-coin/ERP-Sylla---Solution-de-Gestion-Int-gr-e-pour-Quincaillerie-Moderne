from import_export import resources, fields
from import_export.widgets import ForeignKeyWidget
from .models import Container, LogisticsSupplier

class ContainerResource(resources.ModelResource):
    supplier = fields.Field(
        column_name='Fournisseur',
        attribute='supplier',
        widget=ForeignKeyWidget(LogisticsSupplier, 'name')
    )
    
    global_cost = fields.Field(column_name='Coût global (FCFA)')
    delay_days = fields.Field(column_name='Retard (jours)')

    class Meta:
        model = Container
        fields = (
            'container_number', 
            'order_reference', 
            'supplier', 
            'origin_port', 
            'destination_port', 
            'main_product', 
            'container_type',
            'quantity_packages',
            'order_date',
            'loading_date',
            'etd',
            'eta',
            'actual_arrival_date',
            'status',
            'merchandise_value',
            'total_expenses',
            'global_cost',
            'delay_days',
        )
        export_order = fields

    def dehydrate_global_cost(self, container):
        return container.global_cost

    def dehydrate_delay_days(self, container):
        return container.delay_days
