---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
inputDocuments: ['_bmad-output/planning-artifacts/prd.md', '_bmad-output/planning-artifacts/implementation-readiness-report-2026-04-06.md']
project_name: 'ERP Ets Sylla Madjou'
---

# Spécifications du Design UX

Ce document définit les principes visuels, les parcours écrans et le système de composants pour l'ERP Mobile-First de la quincaillerie Ets Sylla Madjou.

## 1. Executive Summary

### Project Vision
L'ERP Ets Sylla Madjou doit être perçu comme un outil de précision et de rapidité. Le design doit refléter la modernité et la fiabilité, avec une interface **Mobile-First** qui ne fait aucun compromis sur la richesse des données financières et de stock.

### Target Users
*   **Vendeurs Modernes :** Utilisateurs à l'aise avec le digital, exigeant une interface fluide (type App mobile) avec des temps de réponse instantanés pour les opérations de caisse.
*   **Gérant Mobile :** Un superviseur qui pilote l'activité à distance, principalement sur smartphone, avec un besoin de lecture rapide des indicateurs de performance (BI).

## 2. Core User Experience

### 2.1 Defining Experience : La "Vente Flash"
L'interaction centrale est la conversion d'une intention d'achat en transaction validée. Elle doit être "Invisible", c'est-à-dire demander le minimum d'effort cognitif à l'utilisateur.

### 2.2 User Mental Model
L'utilisateur ne remplit pas un formulaire, il "compose une commande". Le système agit comme un assistant qui pré-remplit les prix, suggère les unités (Carton/Pièce) et gère la logistique WhatsApp en arrière-plan.

### 2.3 Success Criteria
*   **Vitesse :** Moins de 5 secondes pour rechercher et ajouter un article complexe au panier.
*   **Zéro Calcul :** Toutes les conversions cartons/pièces et les reliquats de monnaie sont calculés instantanément.

### 2.4 Novel UX Patterns
*   **Sélecteur d'Unité "Smart Toggle" :** Un basculement instantané entre vente en gros (Carton) et détail (Pièce).
*   **Navigation "Thumb-Zone" :** Actions critiques regroupées dans le tiers inférieur de l'écran.

## 3. Visual Design Foundation

### 3.1 Color System
*   **Primary :** `Slate-900 (#0F172A)` - Rigueur industrielle.
*   **Accent :** `Green-500 (#22C55E)` - Succès WhatsApp.
*   **Semantic :** Succès = Vert, Attention = Orange, Danger = Rouge.

### 3.2 Typography System
*   **Font :** Inter (Sans-Serif).
*   **Hierarchy :** Chiffres tabulaires pour les montants financiers, Inter Bold pour les titres.
*   **Currency Formatting :** Tous les montants en **F CFA** doivent utiliser un séparateur de milliers (point ou espace insécable) et ne comporter **aucune décimale** (ex: 1.250.000 F CFA).

## 4. Design Direction Decision

### 4.1 Chosen Direction : Hybride Adaptive
Fusion de l'efficacité du "Mobile Flow" pour le terrain et de la puissance du "Cockpit" pour l'analyse.

### 4.2 Design Rationale
Permet de servir deux besoins critiques : la vente ultra-rapide au comptoir et la gestion de stock complexe.

## 5. User Journey Flows

### 5.1 La "Vente Flash" au Comptoir
C'est le parcours le plus fréquent. L'interface doit minimiser les clics.
*   **Mécanique :** Recherche -> Sélection -> Unité -> Valider.
*   **Success :** Moins de 4 interactions pour un article standard.

### 5.2 Conversion Devis en Facture (Ajustable)
Parcours critique pour la négociation commerciale.
*   **Mécanique :** Rappel Devis -> Édition (Ajout/Suppression/Remise) -> Conversion -> Facture finale.
*   **Success :** Flexibilité totale sur le panier avant la validation comptable.

### 5.3 Gestion des Stocks Multi-Entrepôts
Le gérant doit pouvoir déplacer des marchandises avec une traçabilité totale.
*   **Mécanique :** Choisir Source -> Choisir Destination -> Saisir Quantité -> Valider Transfert.

### 5.4 Journey Patterns & Optimization
*   **Pattern "One-Tap" :** Boutons d'action rapide pour les tâches répétitives.
*   **Pattern "Progressive Disclosure" :** Masquage des détails financiers complexes par défaut.

## 6. Component Strategy

### 6.1 Design System Components (Flowbite)
Nous utilisons les composants de base de Flowbite pour garantir la rapidité de développement :
*   **Modals & Drawers :** Pour les formulaires de création (Clients, Fournisseurs).
*   **Data Tables :** Avec filtres intégrés pour le listing des stocks.
*   **Alerts & Toasts :** Pour les confirmations d'envoi WhatsApp.

### 6.2 Custom Components Specifications

#### Smart Toggle d'Unité
*   **Purpose :** Permettre au vendeur de basculer entre la vente en gros et au détail en un clic.
*   **States :** Actif (Vert WhatsApp), Inactif (Gris Slate), Focus (Bordure bleue).

#### Basket Editor (Éditeur de Panier)
*   **Purpose :** Permettre l'ajustement final (remise, quantité, suppression) lors de la conversion d'un devis en facture.
*   **Features :** Boutons de suppression rapides, champs de remise par ligne, recalcul dynamique du total net.

#### Quick-Search-Bar Flottante
*   **Purpose :** Accès universel à la recherche de produits avec stock en temps réel.

#### Badge de Statut de Stock
*   **Purpose :** Visualisation rapide des niveaux de stock (Vert/Orange/Rouge).

### 6.3 Implementation Roadmap
*   **Phase 1 (Vente & Devis) :** Barre de recherche, Panier éditable, Smart Toggle, Conversion Devis ➔ Facture.
*   **Phase 2 (Gestion) :** Tableaux de stock, Filtres entrepôts.
*   **Phase 3 (Admin) :** Tableaux de bord gérant, Logs d'audit.

## 7. UX Consistency Patterns

### 7.1 Button Hierarchy
*   **Primary Action (Action Forte) :** Bouton plein `Green-500`. Utilisé pour "Valider la Vente", "Convertir en Facture", "Enregistrer".
*   **Secondary Action (Navigation) :** Bouton contour (Ghost) `Slate-200`. Utilisé pour "Retour", "Annuler", "Détails".
*   **Destructive Action (Danger) :** Bouton plein `Red-600`. Utilisé pour "Supprimer Article", "Vider le Panier". Demande toujours une confirmation via modale.

### 7.2 Feedback & Messaging
*   **Toasts de Confirmation :** Apparaissent en bas au centre (zone du pouce). Durée : 3 secondes. Couleur : Vert (Succès) / Bleu (Info).
*   **Validation de Formulaire :** Validation en temps réel. Si le stock saisi est supérieur au stock réel, le champ devient orange immédiatement avec le message "Stock insuffisant".
*   **Indicateurs de Chargement :** Spinner discret sur le bouton cliqué pour éviter les doubles clics accidentels.

### 7.3 Empty States & Onboarding
*   **Dashboard vide :** "Bienvenue MaliandevBoy ! Aucune vente enregistrée aujourd'hui. Commencez par créer un devis."
*   **Recherche sans résultat :** "Produit non trouvé. Voulez-vous créer l'article 'XYZ' dans le stock ?" (Lien direct vers la création).

### 7.4 Search & Filtering
*   **Pattern "Search-as-you-type" :** Filtrage instantané dès le 3ème caractère saisi.
*   **Filtres "Pills" :** Des pastilles cliquables (ex: [Ciment], [Fer], [Électricité]) pour filtrer le stock en un tap.

## 8. Responsive Design & Accessibility

### 8.1 Responsive Strategy
L'application adopte une approche **Mobile-First** pour la vente et **Desktop-Rich** pour l'administration.
*   **Mobile :** Priorité à la zone du pouce (bas de l'écran). Navigation par onglets.
*   **Desktop :** Utilisation de la largeur d'écran pour l'affichage BI (Business Intelligence) et les inventaires complexes.

### 8.2 Breakpoint Strategy
*   **Mobile (320px - 767px) :** Layout fluide, interactions tactiles prioritaires.
*   **Desktop (1024px+) :** Sidebar fixe, tableaux multi-colonnes, focus sur la saisie clavier rapide.

### 8.3 Accessibility Strategy (Standard AA)
*   **Color Contrast :** Ratio minimum de 4.5:1 pour tous les textes critiques (Finances/Stocks).
*   **Touch Targets :** Taille minimale de 44x44px pour tous les boutons d'action sur mobile.
*   **Screen Readers :** Balisage sémantique correct (ARIA roles) pour les lecteurs d'écran, facilitant l'usage pour les malvoyants légers.

### 8.4 Testing & Implementation
*   **Responsive Testing :** Tests sur Chrome DevTools et sur dispositifs réels (Android/iOS standards).
*   **Keyboard Support :** Support complet des touches de navigation pour une saisie "sans souris" sur ordinateur.
