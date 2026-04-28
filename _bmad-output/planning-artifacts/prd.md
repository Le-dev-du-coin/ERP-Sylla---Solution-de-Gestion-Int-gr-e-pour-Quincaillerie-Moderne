---
stepsCompleted: [step-01-init, step-02-discovery, step-02b-vision, step-02c-executive-summary, step-03-success, step-04-journeys, step-05-domain, step-06-innovation, step-07-project-type, step-08-scoping, step-09-functional, step-10-nonfunctional]
inputDocuments: ['_bmad-output/brainstorming/brainstorming-session-2026-04-06-14-30.md']
classification:
  projectType: web_app
  domain: fintech/retail
  complexity: high
  projectContext: greenfield
documentCounts:
  briefCount: 0
  researchCount: 0
  brainstormingCount: 1
  projectDocsCount: 0
---

# PRD : ERP Ets Sylla Madjou

...

## Functional Requirements

### 1. Gestion des Ventes & Encaissement (Point de Vente)
*   **FR1 :** Le **Vendeur** peut rechercher un produit par son nom ou sa désignation via une barre de recherche intelligente ultra-rapide.
*   **FR2 :** Le **Vendeur** peut ajouter des articles au panier en sélectionnant l'unité de vente (Pièce ou Carton).
*   **FR3 :** Le **Système** calcule automatiquement les totaux, les taxes et la monnaie à rendre en fonction des prix configurés (prix carton vs prix pièce).
*   **FR4 :** Le **Vendeur** peut valider des paiements mixtes (ex: une partie en espèces, une partie en Mobile Money).
*   **FR5 :** Le **Vendeur** peut solliciter une remise exceptionnelle en générant une demande de code de déblocage pour le gérant.
*   **FR6 :** Le **Système** génère une facture au format A4 professionnel après chaque vente validée.

### 2. Gestion des Stocks & Multi-Entrepôts
*   **FR7 :** Le **Gestionnaire** peut créer, modifier ou supprimer des articles avec un suivi du prix d'achat et du prix de vente par unité.
*   **FR8 :** Le **Système** convertit automatiquement les stocks lors d'un achat en carton vers une vente à la pièce (et vice versa).
*   **FR9 :** Le **Gestionnaire** peut visualiser les niveaux de stock en temps réel par entrepôt (Magasin, Dépôt, etc.).
*   **FR10 :** Le **Gestionnaire** peut effectuer des transferts de stock entre deux entrepôts avec validation de réception.
*   **FR11 :** Le **Système** émet une alerte automatique dès qu'un produit atteint son seuil critique (configurable par article).

### 3. Intégration WhatsApp & Communications
*   **FR12 :** Le **Système** envoie automatiquement la facture PDF au numéro WhatsApp du client dès la validation de la vente.
*   **FR13 :** Le **Gérant** peut envoyer une relance de dette personnalisée à un client en un clic depuis sa fiche.
*   **FR14 :** Le **Gérant** reçoit des notifications WhatsApp pour les alertes de stock critique et les rapports de fin de journée.
*   **FR15 :** Le **Système** permet l'envoi de messages marketing (arrivages, promos) à toute la base client (Phase 2).

### 4. Pilotage Financier & Analyse (BI)
*   **FR16 :** Le **Gérant** peut consulter un tableau de bord en temps réel affichant le CA, la marge brute et le bénéfice net.
*   **FR17 :** Le **Gérant** peut visualiser le Top 10 des produits les plus vendus et les plus rentables sur une période donnée.
*   **FR18 :** Le **Gérant** peut générer des graphiques d'évolution des ventes (jour, mois, année).
*   **FR19 :** Le **Système** calcule automatiquement la valeur totale du stock immobilisé par entrepôt.
*   **FR27 :** Le **Gérant** peut consulter un Journal de Caisse interactif filtrable par période (début/fin) affichant toutes les entrées (ventes, paiements) et sorties (dépenses).

### 5. CRM & Gestion des Tiers
*   **FR20 :** Le **Vendeur/Gérant** peut créer des fiches clients avec historique d'achats et suivi précis du solde (dettes/créances).
*   **FR21 :** Le **Gérant** peut gérer une base de fournisseurs avec leurs coordonnées et les produits associés.
*   **FR28 :** Le **Gérant** peut enregistrer des dépenses classées par catégories (Loyer, Salaire, Divers) avec justificatif numérique.

### 6. Administration, Sécurité & Audit
*   **FR22 :** Le **Système** enregistre chaque action utilisateur (log d'audit) avec l'ancienne et la nouvelle valeur des données modifiées.
*   **FR23 :** Le **Gérant** peut gérer les utilisateurs et leurs niveaux d'accès (Vendeur vs Gérant).
*   **FR24 :** Le **Système** demande un code de déblocage valide pour toute opération sensible (remise, annulation, modification de stock).
*   **FR25 :** Le **Système** garantit l'intégrité des transactions même en cas de micro-coupure réseau (idempotence).
*   **FR26 :** Le **Gérant** peut annuler ou corriger une transaction (vente, entrée de stock, transfert) erronée, avec obligation de motif et enregistrement automatique dans le log d'audit.
*   **FR29 :** Le **Gérant** peut effectuer des sauvegardes manuelles de la base de données SQL depuis l'interface et configurer des sauvegardes automatiques quotidiennes.

## Non-Functional Requirements

### Performance
*   **Réactivité de Recherche :** L'affichage des résultats de recherche textuelle (FR1) doit s'effectuer en moins de **500ms**, même avec une base de données de 5 000 articles.
*   **Fluidité de Navigation :** Le passage entre les écrans de vente et les tableaux de bord doit être perçu comme instantané (< 200ms).
*   **Génération de Documents :** La préparation du PDF de facture et le déclenchement de l'impression A4 doivent prendre moins de **2 secondes** après la validation de la vente.

### Sécurité & Confidentialité
*   **Chiffrement des Flux :** Toutes les communications entre les terminaux (mobiles/PC) et le VPS doivent être sécurisées via le protocole **HTTPS/SSL (TLS 1.3)**.
*   **Isolation des Données (RBAC) :** Le système doit garantir une isolation stricte des routes API. Un utilisateur avec le rôle "Vendeur" ne doit techniquement pas pouvoir accéder aux données de bénéfices nets, même via des outils externes.
*   **Protection des Données (Backups) :** Une sauvegarde automatisée de la base de données doit être effectuée toutes les **6 heures** vers un stockage externe au VPS principal pour prévenir toute perte majeure.

### Fiabilité & Disponibilité
*   **Taux de Disponibilité (Uptime) :** Le service doit être accessible **99,9%** du temps (soit moins de 9 heures d'interruption cumulées par an).
*   **Auto-Guérison (Auto-Restart) :** En cas de plantage du processus ou de redémarrage du serveur VPS, les services applicatifs (backend/frontend) doivent redémarrer automatiquement sans intervention humaine.
*   **Intégrité des Transactions :** Le système doit être capable de reprendre ou d'annuler proprement une transaction interrompue par une perte de connexion subite.

### Utilisabilité & Ergonomie
*   **Mobile-First Responsive :** L'interface doit être 100% fonctionnelle et lisible sur des écrans de **5 pouces** (smartphones standards).
*   **Lisibilité Terrain :** Le contraste et la taille de la police doivent être optimisés pour une lecture aisée sous forte luminosité ou dans des environnements de stockage sombres.
*   **Zéro Configuration Client :** L'accès au logiciel ne doit nécessiter aucune installation côté client (navigateur standard uniquement).
