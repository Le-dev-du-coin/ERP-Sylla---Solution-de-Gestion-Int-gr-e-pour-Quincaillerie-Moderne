from django.db import migrations

def create_initial_roles(apps, schema_editor):
    Group = apps.get_model("auth", "Group")
    Permission = apps.get_model("auth", "Permission")
    ContentType = apps.get_model("contenttypes", "ContentType")
    AuditTestModel = apps.get_model("core", "AuditTestModel")

    # 1. Création des groupes
    gerants_group, _ = Group.objects.get_or_create(name="Gérants")
    vendeurs_group, _ = Group.objects.get_or_create(name="Vendeurs")

    # 2. Permissions pour AuditTestModel
    content_type = ContentType.objects.get_for_model(AuditTestModel)
    
    # Le gérant peut tout faire
    permissions_gerant = Permission.objects.filter(content_type=content_type)
    for perm in permissions_gerant:
        gerants_group.permissions.add(perm)

    # Le vendeur peut uniquement voir (view)
    try:
        view_perm = Permission.objects.get(content_type=content_type, codename="view_audittestmodel")
        vendeurs_group.permissions.add(view_perm)
    except Permission.DoesNotExist:
        pass

def remove_initial_roles(apps, schema_editor):
    Group = apps.get_model("auth", "Group")
    Group.objects.filter(name__in=["Gérants", "Vendeurs"]).delete()

class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
        ('auth', '0012_alter_user_first_name_max_length'), # Assure que auth est chargé
        ('contenttypes', '0002_remove_content_type_name'),
    ]

    operations = [
        migrations.RunPython(create_initial_roles, remove_initial_roles),
    ]
