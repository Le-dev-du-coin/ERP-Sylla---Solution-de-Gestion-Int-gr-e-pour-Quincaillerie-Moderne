---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
workflowType: 'architecture'
lastStep: 8
status: 'complete'
completedAt: '2026-04-08'
inputDocuments: ['_bmad-output/planning-artifacts/prd.md', '_bmad-output/planning-artifacts/implementation-readiness-report-2026-04-06.md']
project_name: 'ERP Ets Sylla Madjou'
user_name: 'MaliandevBoy'
technical_constraints:
  backend: 'Django (Python)'
date: '2026-04-08'
---

# Architecture Decision Document

_Ce document est construit de manière collaborative via une découverte étape par étape. Les sections sont ajoutées au fur et à mesure que nous prenons ensemble chaque décision architecturale._

## Project Context Analysis

### Requirements Overview

**Functional Requirements:**
Analyse de 26 FRs couvrant la vente (POS), le stock multi-entrepôts, le CRM et le pilotage financier. Architecturalement, cela impose un modèle de données normalisé et une gestion stricte des transactions pour l'intégrité des stocks.

**Non-Functional Requirements:**
Performance critique (Recherche < 500ms, PDF < 2s). Sécurité par rôles (RBAC) et logs d'audit exhaustifs. Disponibilité de 99,9%.

**Scale & Complexity:**
- Primary domain: Full-Stack Web App (Django Backend)
- Complexity level: High (Transactions complexes, multi-unités, intégrations tierces)
- Estimated architectural components: 6-8 (API, Workers, DB, Cache, PDF Engine, WhatsApp Gateway)

### Technical Constraints & Dependencies
- **Backend :** Django (Python) imposé.
- **Frontend :** Mobile-First, Tailwind/Flowbite (UX Spec).
- **Intégrations :** API WhatsApp, Système de fichiers pour PDF, Audit Logs persistants.

### Cross-Cutting Concerns Identified
- **Transactions atomiques :** Crucial pour la conversion des stocks.
- **Caching :** Nécessaire pour les performances de recherche intelligente.
- **Audit Traceability :** Système global pour enregistrer chaque modification de valeur.

## Starter Template Evaluation

### Primary Technology Domain
**Full-Stack Web Application (Django Monolith)** basé sur les exigences de performance et de développement rapide.

### Starter Options Considered
1.  **Cookiecutter Django :** Le standard industriel pour la production.
2.  **Django-Tailwind :** Pour une intégration CSS moderne.
3.  **HTMX Extension :** Pour l'interactivité "SPA-like" sans DRF.

### Selected Starter: Cookiecutter Django
**Rationale for Selection:**
Fournit une base de production robuste avec PostgreSQL, Docker, et une gestion de sécurité avancée. L'absence de DRF simplifie la logique métier en la gardant dans les vues Django standard, tout en utilisant HTMX pour la réactivité UX demandée (Recherche < 500ms).

**Initialization Command:**
```bash
cookiecutter https://github.com/cookiecutter/cookiecutter-django
```
*Options recommandées lors du prompt :*
- `use_docker: y`
- `use_celery: y`
- `frontend_pipeline: Tailwind`

**Architectural Decisions Provided by Starter:**
- **Language & Runtime :** Python 3.12+ / Django 5.0+.
- **Styling Solution :** Tailwind CSS configuré via un container dédié.
- **Task Queue :** Celery + Redis pour les traitements lourds (Génération PDF, API WhatsApp).
- **Code Organization :** Structure `apps/` pour découper l'ERP (sales, inventory, customers, finances).
- **Development Experience :** Rechargement automatique, Docker Compose pour PostgreSQL/Redis/Mailhog.

## Core Architectural Decisions

### Data Architecture
*   **Inventory Ledger System :** Approche "Grand Livre" pour les stocks. Table `StockTransaction` immuable. Le stock physique est calculé par agrégation (Sum).
*   **Unit Conversion Engine :** Table `UnitConversion` reliant les produits aux unités (Carton, Pièce, Sac) avec un `conversion_factor` basé sur l'unité minimale.
*   **PostgreSQL Trigram Search :** Activation de l'extension `pg_trgm` pour la recherche prédictive ultra-rapide (< 500ms).

### PDF Generation & Communications
*   **Chromium-based PDF Engine :** Utilisation de **Playwright-Python** pour transformer les templates Django/Tailwind en PDF A4 professionnels.
*   **Asynchronous Messaging :** **Celery** avec **Redis** comme broker pour l'envoi des factures WhatsApp et la génération des rapports financiers BI.

### Security & Auditability
*   **Data Traceability :** Utilisation de `django-simple-history` pour l'audit complet des modifications de données sensibles (Prix, Clients).
*   **Role-Based Access Control (RBAC) :** Utilisation des groupes `Vendeur` (POS + Stock limité) et `Gérant` (Full access + BI).

### Decision Impact Analysis
*   **Implication Docker :** Ajout d'un container `worker` pour Celery et installation des binaires Chromium/Playwright dans l'image Docker du projet.
*   **Implication Performance :** Les calculs de stock agrégés (Ledger) seront optimisés via des index PostgreSQL et potentiellement des vues matérialisées si le volume dépasse 100k transactions.

## Implementation Patterns & Consistency Rules

### Naming Patterns
*   **Python/Django :** `snake_case` strict (PEP 8).
*   **HTML/CSS :** `kebab-case` pour les IDs, classes et noms de fichiers templates.
*   **Database :** Tables en `snake_case` (standard Django).

### Structure Patterns
*   **Template Partials :** Tous les fragments HTMX doivent résider dans `templates/apps/partials/`.
*   **Service Layer :** La logique métier complexe (Calculs Ledger, WhatsApp) doit être isolée dans `apps/[app_name]/services.py`.
*   **HTMX Responses :** Utilisation systématique de `django-htmx` pour détecter les requêtes HTMX dans les vues.

### Format Patterns
*   **Date/Time :** Format ISO 8601 pour les échanges de données, format local (ex: 08/04/2026) pour l'affichage utilisateur.
*   **Currency :** Utilisation du filtre `humanize` de Django avec séparateur de milliers pour le F CFA.

### Process Patterns
*   **Error Handling :** Les erreurs HTMX sont renvoyées sous forme de fragments HTML avec le trigger `hx-trigger="error-occurred"`.
*   **Loading States :** Utilisation systématique de `hx-indicator` avec un spinner CSS Tailwind.

## Project Structure & Boundaries

### Complete Project Directory Structure
```text
erp_sylla/
├── .envs/ (Variables env : Postgres, Redis, WhatsApp_API)
├── compose/ (Docker config pour Postgres, Celery, Playwright)
├── erp_sylla/
│   ├── apps/
│   │   ├── sales/
│   │   │   ├── models.py (Sale, SaleItem, Quote)
│   │   │   ├── services.py (Logique conversion Devis -> Facture)
│   │   │   ├── views.py (HTMX views)
│   │   │   └── urls.py
│   │   ├── inventory/
│   │   │   ├── models.py (Product, Warehouse, StockTransaction, InventorySession)
│   │   │   ├── services.py (Calcul Ledger, Transferts, Reconciliation d'Inventaire)
│   │   │   └── urls.py
│   │   ├── customers/
│   │   ├── communications/
│   │   │   ├── tasks.py (Envoi WhatsApp, Génération PDF Rapport Inventaire)
│   │   │   └── services.py (Playwright/Chromium wrapper)
│   │   └── core/ (Audit logs, Dashboards)
│   ├── static/ (Tailwind output)
│   ├── templates/
│   │   ├── base.html
│   │   ├── apps/ (sales/, inventory/, etc.)
│   │   └── partials/ (fragments HTMX)
│   └── users/ (Custom User)
├── docker-compose.yml
└── manage.py
```

### Architectural Boundaries
*   **Stock Ledger Boundary :** Seul le service `inventory/services.py` crée des `StockTransactions`.
*   **PDF & Comms Boundary :** L'app `communications` centralise toute la génération de documents.

### Requirements to Structure Mapping
*   **Vente & Devis (FR1-FR6) :** `apps/sales/`.
*   **Stocks Ledger & Inventaire (FR7-FR11) :** `apps/inventory/`.
*   **WhatsApp & Impression PDF (FR12, Inventaire) :** `apps/communications/`.
*   **Audit & Sécurité (FR22-FR26) :** `apps/core/` + `django-simple-history`.

### Integration Points
*   **Async Processing :** Celery pour WhatsApp et Impression PDF pour ne pas bloquer le POS.
*   **Recherche Rapide :** PostgreSQL Trigram Index sur `inventory.Product`.

## Architecture Validation Results

### Coherence Validation ✅
Toutes les décisions (Django, HTMX, Ledger, Playwright) sont compatibles. L'utilisation de Docker garantit la disponibilité des binaires Chromium nécessaires à l'impression.

### Requirements Coverage Validation ✅
100% des exigences fonctionnelles du PRD sont mappées à des composants ou services spécifiques. Les NFRs (Performance, Sécurité) sont adressés par PostgreSQL (Trigram Index) et Django (RBAC/Simple-History).

### Gap Analysis Results
*   **Gap Mineur :** Nécessité de configurer précisément les volumes Docker pour la persistance des PDF générés avant envoi WhatsApp. (À traiter lors du premier sprint).

### Architecture Readiness Assessment
**Overall Status:** READY FOR IMPLEMENTATION
**Confidence Level:** High
**Key Strengths:** Modèle de données Ledger robuste, interface réactive avec HTMX, système d'impression haute fidélité.

### Implementation Handoff
**AI Agent Guidelines :**
*   Suivre strictement le modèle **Ledger** pour tout mouvement de stock.
*   Utiliser **HTMX** pour toute interaction dynamique (recherche, panier).
*   Isoler la logique complexe dans les fichiers `services.py`.
*   Respecter le formatage **F CFA** sans décimales.

**Première Priorité :** Initialisation du projet via Cookiecutter Django avec support Docker et Celery.
