# ERP Sylla - Solution de Gestion Intégrée pour Quincaillerie Moderne

**ERP Sylla** est une plateforme robuste et moderne conçue pour transformer la gestion opérationnelle des quincailleries et commerces de gros/détail. Alliant performance technique et simplicité d'utilisation, elle centralise l'ensemble du cycle de vente et de stock dans une interface unique et réactive.

## 🚀 Points forts de la solution

*   **Vente "Ultra-Rapide" (POS) :** Interface de caisse optimisée pour mobile avec recherche prédictive intelligente.
*   **Gestion Intelligente des Stocks :** Conversion automatique Pièces/Cartons et suivi en temps réel sur plusieurs entrepôts (Magasin, Dépôt, etc.).
*   **Communication WhatsApp :** Automatisation de l'envoi des factures PDF et relances de dettes personnalisées via API WhatsApp.
*   **Pilotage BI (Business Intelligence) :** Tableaux de bord dynamiques pour le gérant (Calcul des marges nettes, Top 10 produits, Graphiques d'évolution du CA).
*   **Sécurité & Audit :** Traçabilité totale des modifications (Logs d'audit) et système de codes de déblocage pour les opérations sensibles.
*   **Trésorerie & Dépenses :** Journal de caisse unifié capturant chaque entrée (vente/paiement) et sortie (dépense par catégorie).
*   **Protection des Données :** Système de sauvegarde (backups) automatique quotidien et export manuel de la base de données SQL.

## 🛠 Stack Technique

*   **Backend :** Django 5.0+, Python 3.12+
*   **Frontend :** Tailwind CSS, Flowbite, HTMX (pour une réactivité "SPA-like")
*   **Base de données :** PostgreSQL avec extension Trigram Search
*   **Tâches Asynchrones :** Celery & Redis
*   **Génération de documents :** Playwright-Python (Moteur Chromium pour des PDF haute fidélité)

## 📦 Installation (Développement)

Le projet utilise **Poetry** pour la gestion des dépendances.

```bash
# Installation des dépendances
poetry install

# Lancement des migrations
poetry run python manage.py migrate

# Démarrage du serveur
poetry run python manage.py runserver
```

---
*Développé pour les Ets Sylla Madjou par MaliandevBoy.*
