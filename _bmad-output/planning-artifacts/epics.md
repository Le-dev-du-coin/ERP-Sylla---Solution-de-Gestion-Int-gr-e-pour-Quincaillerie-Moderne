---
stepsCompleted: [step-01-validate-prerequisites]
inputDocuments: ['_bmad-output/planning-artifacts/prd.md', '_bmad-output/planning-artifacts/architecture.md', '_bmad-output/planning-artifacts/ux-design-specification.md']
---

# ERP Ets Sylla Madjou - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for ERP Ets Sylla Madjou, decomposing the requirements from the PRD, UX Design if it exists, and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

FR1: Recherche intelligente ultra-rapide par nom ou désignation.
FR2: Ajout au panier avec sélection de l'unité (Pièce ou Carton).
FR3: Calcul automatique totaux, taxes et monnaie (prix carton vs pièce).
FR4: Validation de paiements mixtes (Espèces + Mobile Money).
FR5: Demande de remise exceptionnelle avec code de déblocage.
FR6: Génération de facture A4 professionnelle post-vente.
FR7: Gestion articles avec suivi prix d'achat/vente par unité.
FR8: Conversion automatique des stocks (Achat carton -> Vente pièce).
FR9: Visualisation des stocks en temps réel par entrepôt.
FR10: Transferts de stock entre entrepôts avec validation.
FR11: Alertes automatiques de seuil critique configurables.
FR12: Envoi automatique facture PDF via WhatsApp.
FR13: Relance de dette personnalisée WhatsApp en un clic.
FR14: Notifications WhatsApp gérant (stocks critiques, rapports fin de journée).
FR15: Envoi messages marketing WhatsApp (Phase 2).
FR16: Dashboard temps réel (CA, Marge brute, Bénéfice net).
FR17: Top 10 produits les plus vendus/rentables.
FR18: Graphiques d'évolution des ventes (Jour/Mois/Année).
FR19: Calcul valeur totale du stock immobilisé par entrepôt.
FR20: Fiches clients avec historique et suivi dettes/créances.
FR21: Gestion base fournisseurs et produits associés.
FR22: Logs d'audit exhaustifs (ancienne vs nouvelle valeur).
FR23: Gestion utilisateurs et rôles (Vendeur vs Gérant).
FR24: Codes de déblocage pour remises, annulations, modifs stock.
FR25: Idempotence et intégrité des transactions (micro-coupures).
FR26: Annulation/Correction de transaction avec motif obligatoire et audit.

### NonFunctional Requirements

NFR1: Performance - Recherche < 500ms, Navigation < 200ms, PDF < 2s.
NFR2: Sécurité - HTTPS/TLS 1.3, RBAC strict, Backups toutes les 6h.
NFR3: Fiabilité - 99,9% uptime, Auto-restart des services, Intégrité transactionnelle.
NFR4: Utilisabilité - Mobile-First responsive, Lisibilité terrain (contraste), Zéro config client.

### Additional Requirements

- **Starter Template**: Cookiecutter Django (Docker + Celery + PostgreSQL).
- **Data Architecture**: Stock Ledger System (Table `StockTransaction` immuable).
- **Unit Conversion Engine**: Logique centralisée basée sur un `conversion_factor`.
- **Search Engine**: PostgreSQL Trigram Index (`pg_trgm`).
- **PDF Engine**: Playwright-Python (Chromium) dans un container dédié.
- **Audit System**: `django-simple-history` pour le suivi des modifications.
- **Service Layer**: Isolation de la logique métier dans `services.py`.
- **HTMX**: Utilisation de fragments HTMX pour la réactivité sans SPA.

### UX Design Requirements

UX-DR1: Design Tokens - Slate-900 (Primary), Green-500 (Accent/WhatsApp), Inter font.
UX-DR2: Composant "Smart Toggle" pour basculer Pièce/Carton instantanément.
UX-DR3: Composant "Basket Editor" pour ajustements avant facturation (remises, suppression).
UX-DR4: Barre de recherche flottante "Quick-Search" universelle.
UX-DR5: Badges de statut de stock (Vert/Orange/Rouge).
UX-DR6: Navigation "Thumb-Zone" regroupant les actions critiques en bas de l'écran.
UX-DR7: Formatage monétaire F CFA (pas de décimales, séparateur milliers).
UX-DR8: Feedback visuel (Toasts confirmation, spinners sur boutons).
UX-DR9: États vides (Empty States) pédagogiques pour les tableaux de bord.

---
stepsCompleted: [step-01-validate-prerequisites, step-02-design-epics]
inputDocuments: ['_bmad-output/planning-artifacts/prd.md', '_bmad-output/planning-artifacts/architecture.md', '_bmad-output/planning-artifacts/ux-design-specification.md']
---

# ERP Ets Sylla Madjou - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for ERP Ets Sylla Madjou, decomposing the requirements from the PRD, UX Design if it exists, and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

FR1: Recherche intelligente ultra-rapide par nom ou désignation.
FR2: Ajout au panier avec sélection de l'unité (Pièce ou Carton).
FR3: Calcul automatique totaux, taxes et monnaie (prix carton vs pièce).
FR4: Validation de paiements mixtes (Espèces + Mobile Money).
FR5: Demande de remise exceptionnelle avec code de déblocage.
FR6: Génération de facture A4 professionnelle post-vente.
FR7: Gestion articles avec suivi prix d'achat/vente par unité.
FR8: Conversion automatique des stocks (Achat carton -> Vente pièce).
FR9: Visualisation des stocks en temps réel par entrepôt.
FR10: Transferts de stock entre entrepôts avec validation.
FR11: Alertes automatiques de seuil critique configurables.
FR12: Envoi automatique facture PDF via WhatsApp.
FR13: Relance de dette personnalisée WhatsApp en un clic.
FR14: Notifications WhatsApp gérant (stocks critiques, rapports fin de journée).
FR15: Envoi messages marketing WhatsApp (Phase 2).
FR16: Dashboard temps réel (CA, Marge brute, Bénéfice net).
FR17: Top 10 produits les plus vendus/rentables.
FR18: Graphiques d'évolution des ventes (Jour/Mois/Année).
FR19: Calcul valeur totale du stock immobilisé par entrepôt.
FR20: Fiches clients avec historique et suivi dettes/créances.
FR21: Gestion base fournisseurs et produits associés.
FR22: Logs d'audit exhaustifs (ancienne vs nouvelle valeur).
FR23: Gestion utilisateurs et rôles (Vendeur vs Gérant).
FR24: Codes de déblocage pour remises, annulations, modifs stock.
FR25: Idempotence et intégrité des transactions (micro-coupures).
FR26: Annulation/Correction de transaction avec motif obligatoire et audit.

### NonFunctional Requirements

NFR1: Performance - Recherche < 500ms, Navigation < 200ms, PDF < 2s.
NFR2: Sécurité - HTTPS/TLS 1.3, RBAC strict, Backups toutes les 6h.
NFR3: Fiabilité - 99,9% uptime, Auto-restart des services, Intégrité transactionnelle.
NFR4: Utilisabilité - Mobile-First responsive, Lisibilité terrain (contraste), Zéro config client.

### Additional Requirements

- **Starter Template**: Cookiecutter Django (Docker + Celery + PostgreSQL).
- **Data Architecture**: Stock Ledger System (Table `StockTransaction` immuable).
- **Unit Conversion Engine**: Logique centralisée basée sur un `conversion_factor`.
- **Search Engine**: PostgreSQL Trigram Index (`pg_trgm`).
- **PDF Engine**: Playwright-Python (Chromium) dans un container dédié.
- **Audit System**: `django-simple-history` pour le suivi des modifications.
- **Service Layer**: Isolation de la logique métier dans `services.py`.
- **HTMX**: Utilisation de fragments HTMX pour la réactivité sans SPA.

### UX Design Requirements

UX-DR1: Design Tokens - Slate-900 (Primary), Green-500 (Accent/WhatsApp), Inter font.
UX-DR2: Composant "Smart Toggle" pour basculer Pièce/Carton instantanément.
UX-DR3: Composant "Basket Editor" pour ajustements avant facturation (remises, suppression).
UX-DR4: Barre de recherche flottante "Quick-Search" universelle.
UX-DR5: Badges de statut de stock (Vert/Orange/Rouge).
UX-DR6: Navigation "Thumb-Zone" regroupant les actions critiques en bas de l'écran.
UX-DR7: Formatage monétaire F CFA (pas de décimales, séparateur milliers).
UX-DR8: Feedback visuel (Toasts confirmation, spinners sur boutons).
UX-DR9: États vides (Empty States) pédagogiques pour les tableaux de bord.

### FR Coverage Map

- **FR1 (Recherche) :** Epic 3 - Caisse Rapide
- **FR2 (Panier) :** Epic 3 - Caisse Rapide
- **FR3 (Calculs) :** Epic 3 - Caisse Rapide
- **FR4 (Paiements) :** Epic 3 - Caisse Rapide
- **FR5 (Remises) :** Epic 3 - Caisse Rapide
- **FR6 (Facture PDF) :** Epic 4 - Facturation & WhatsApp
- **FR7 (Catalogue) :** Epic 2 - Référentiel & Stocks
- **FR8 (Conversion) :** Epic 2 - Référentiel & Stocks
- **FR9 (Vision Stock) :** Epic 2 - Référentiel & Stocks
- **FR10 (Transferts) :** Epic 5 - CRM & Mouvements
- **FR11 (Alertes) :** Epic 2 - Référentiel & Stocks
- **FR12 (Envoi Facture) :** Epic 4 - Facturation & WhatsApp
- **FR13 (Relance Dettes) :** Epic 5 - CRM & Mouvements
- **FR14 (Notifs Gérant) :** Epic 4 - Facturation & WhatsApp
- **FR15 (Marketing) :** Phase 2 (Hors périmètre actuel)
- **FR16 (Dashboard BI) :** Epic 6 - BI
- **FR17 (Top Produits) :** Epic 6 - BI
- **FR18 (Graphiques) :** Epic 6 - BI
- **FR19 (Valeur Stock) :** Epic 6 - BI
- **FR20 (Fiches Clients) :** Epic 5 - CRM & Mouvements
- **FR21 (Fournisseurs) :** Epic 2 - Référentiel & Stocks
- **FR22 (Audit Logs) :** Epic 1 - Fondation
- **FR23 (Utilisateurs) :** Epic 1 - Fondation
- **FR24 (Codes Déblocage) :** Epic 1 - Fondation
- **FR25 (Idempotence) :** Epic 1 - Fondation
- **FR26 (Annulations) :** Epic 5 - CRM & Mouvements

## Epic List

### Epic 1: Fondation Système, Authentification & Audit
Mise en place de la structure Django/Docker, de la gestion des rôles (Vendeur/Gérant) et de la traçabilité complète des données.
**FRs couverts:** FR22, FR23, FR24, FR25.

### Epic 2: Gestion du Référentiel Articles & Multi-Stocks
Création du catalogue produits, configuration des unités (Pièce/Carton) et visualisation temps réel des stocks par entrepôt.
**FRs couverts:** FR7, FR8, FR9, FR11, FR21.

### Epic 3: Caisse Rapide (POS) & Vente au Comptoir
Interface de vente Mobile-First avec recherche ultra-rapide, gestion du panier intelligent et calculs automatiques.
**FRs couverts:** FR1, FR2, FR3, FR4, FR5.

### Epic 4: Facturation Professionnelle & Intégration WhatsApp
Génération automatique des factures PDF A4 et envoi via WhatsApp au client, avec notifications de gestion pour le gérant.
**FRs couverts:** FR6, FR12, FR14.

### Epic 5: CRM, Gestion des Dettes & Mouvements de Stock
Suivi précis des fiches clients, gestion des créances avec relances WhatsApp et logistique de transfert entre entrepôts.
**FRs couverts:** FR10, FR13, FR20, FR26.

### Epic 6: Pilotage Financier & Business Intelligence (BI)
Tableaux de bord de performance (CA, Marges, Top produits) et analyse de la rentabilité globale.
**FRs couverts:** FR16, FR17, FR18, FR19.

## Epic 1: Fondation Système, Authentification & Audit

Mise en place de la structure Django/Docker, de la gestion des rôles (Vendeur/Gérant) et de la traçabilité complète des données.
**Epic Goal:** Établir un environnement de production sécurisé et auditable pour toutes les transactions de l'ERP.

### Story 1.1: Initialisation du Projet avec Cookiecutter Django

As a **Développeur**,
I want **initialiser le projet avec une structure de production robuste (Docker/Django)**,
So that **je dispose d'un environnement de développement et de déploiement standardisé**.

**Acceptance Criteria:**

**Given** l'outil `cookiecutter` est installé
**When** je lance la commande d'initialisation avec les options spécifiées (Docker, Celery, PostgreSQL)
**Then** un projet Django complet est généré
**And** les fichiers `docker-compose.yml` et `.envs/` sont configurés pour le projet "ERP Sylla"
**And** la commande `docker compose up` démarre avec succès les containers (django, postgres, redis)

### Story 1.2: Traçabilité des Données via Audit Logs

As a **Gérant**,
I want **que chaque modification de donnée sensible soit enregistrée avec l'ancienne et la nouvelle valeur**,
So that **je puisse auditer les erreurs ou les fraudes éventuelles**.

**Acceptance Criteria:**

**Given** la librairie `django-simple-history` est installée
**When** un modèle marqué comme "audité" est créé, modifié ou supprimé
**Then** une entrée est créée automatiquement dans la table d'historique
**And** l'enregistrement contient l'utilisateur, la date, l'action et les valeurs modifiées
**And** l'intégrité est garantie même en cas de micro-coupure (Idempotence)

### Story 1.3: Gestion des Rôles Vendeur et Gérant

As a **Gérant**,
I want **définir des niveaux d'accès spécifiques pour mes employés**,
So that **les vendeurs n'accèdent pas aux données financières confidentielles (marge, bénéfice)**.

**Acceptance Criteria:**

**Given** le modèle User personnalisé est en place
**When** je crée un utilisateur avec le rôle "Vendeur"
**Then** il n'a accès qu'au POS et à la consultation limitée du stock
**And** un utilisateur "Gérant" a un accès complet aux tableaux de bord BI et à l'administration

### Story 1.4: Système de Codes de Déblocage pour Opérations Sensibles

As a **Vendeur**,
I want **demander un code au gérant pour appliquer une remise exceptionnelle**,
So that **l'opération soit validée et tracée selon les règles de gestion**.

**Acceptance Criteria:**

**Given** une opération marquée comme "sensible" (ex: remise > 5%)
**When** j'essaie de valider l'action
**Then** le système bloque et demande la saisie d'un code de déblocage valide
**And** une fois le code validé, l'action est autorisée et enregistrée dans les logs d'audit avec le motif

### Story 1.5: Sauvegarde et Exportation de la Base de Données

As a **Gérant**,
I want **pouvoir exporter la base de données manuellement et configurer des sauvegardes automatiques**,
So that **je puisse sécuriser mes données contre toute perte matérielle ou logicielle**.

**Acceptance Criteria:**

**Given** que je suis connecté en tant que Gérant
**When** je clique sur "Sauvegarde Manuelle" dans les paramètres
**Then** le système génère un fichier SQL complet de la base de données
**And** le fichier est disponible en téléchargement
**And** une tâche automatique crée une sauvegarde chaque jour à minuit

<!-- Repeat for each epic in epics_list (N = 1, 2, 3...) -->

## Epic 7: Interface d'Accueil Vendeur (Dashboard)

### Story 7.1: Création du Tableau de Bord Vendeur sans Graphiques

As a **Vendeur**,
I want **voir mes statistiques de vente de la journée dès ma connexion**,
So that **je puisse suivre mes performances sans accéder aux données confidentielles du gérant**.

**Acceptance Criteria:**

**Given** je suis connecté avec le rôle "Vendeur"
**When** j'accède à ma page d'accueil
**Then** je vois des cartes de statistiques (KPIs) uniquement
**And** les cartes affichent : "Mes ventes du jour (Montant)", "Nombre de ventes", "Mon Top produit", et "Commandes en attente"
**And** aucun graphique complexe (Chart.js) n'est affiché pour garder l'interface légère.
