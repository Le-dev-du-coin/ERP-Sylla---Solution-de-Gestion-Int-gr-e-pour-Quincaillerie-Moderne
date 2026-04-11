import pytest
from django.urls import reverse
from django.test import Client
from erp_sylla.users.models import User

@pytest.mark.django_db
class TestPermissions:
    def setup_method(self):
        self.client = Client()
        
        # Création des utilisateurs
        self.gerant = User.objects.create_user(
            username="gerant_test", 
            password="password", 
            role=User.Roles.GERANT
        )
        self.vendeur = User.objects.create_user(
            username="vendeur_test", 
            password="password", 
            role=User.Roles.VENDEUR
        )

    def test_gerant_access_finance(self):
        self.client.login(username="gerant_test", password="password")
        response = self.client.get(reverse("core:finance"))
        assert response.status_code == 200

    def test_vendeur_denied_finance(self):
        self.client.login(username="vendeur_test", password="password")
        response = self.client.get(reverse("core:finance"))
        assert response.status_code == 403

    def test_vendeur_access_pos(self):
        self.client.login(username="vendeur_test", password="password")
        response = self.client.get(reverse("core:pos"))
        assert response.status_code == 200

    def test_gerant_access_pos(self):
        self.client.login(username="gerant_test", password="password")
        response = self.client.get(reverse("core:pos"))
        assert response.status_code == 200
