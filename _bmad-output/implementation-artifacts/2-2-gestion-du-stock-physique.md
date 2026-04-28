Status: ready-for-dev

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Gérant**,
I want **gérer mes entrepôts et suivre les niveaux de stock physique**,
so that **je connaisse exactement la disponibilité de chaque article en temps réel**.

## Acceptance Criteria

1. **Given** le catalogue d'articles est opérationnel
2. **When** je crée un entrepôt (ex: "Magasin Central")
3. **Then** je peux enregistrer des mouvements de stock (Entrée/Sortie) pour cet entrepôt
4. **And** le système calcule automatiquement le stock disponible (en pièces et en cartons)
5. **And** une interface permet de visualiser l'état global des stocks par entrepôt
Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

...
- [x] Modèles de Gestion des Stocks (AC: 1, 2, 3, 6)
  - [x] Créer le modèle `Warehouse` (Name, Location, is_active) dans `apps/inventory/models.py`
  - [x] Créer le modèle `StockTransaction` (Product, Warehouse, Quantity, Type, Notes)
  - [x] Définir les types de transactions (ENTRÉE, SORTIE, TRANSFERT, INVENTAIRE)
  - [x] Intégrer l'audit (`HistoricalRecords`) sur les deux modèles
  - [x] Créer et lancer les migrations
- [x] Logique Métier (AC: 4)
  - [x] Ajouter des méthodes property au modèle `Product` pour calculer le stock total
  - [x] Implémenter une logique de conversion inverse (Pièces -> Cartons) pour l'affichage
- [x] Interface Utilisateur (AC: 5)
  - [x] Créer la vue `StockStatusView` pour afficher le tableau des stocks
  - [x] Mettre à jour la Sidebar pour inclure le lien "Gestion des Stocks"
  - [x] Créer le template `inventory/stock_status.html`
- [x] Validation (AC: 4, 6)
  - [x] Créer un test unitaire vérifiant que l'ajout d'une transaction d'entrée augmente bien le stock calculé

- **Ledger System :** On ne stocke pas la quantité "en dur" dans le produit. On la calcule par la somme des `StockTransaction.quantity`.
- **Unité de référence :** Toutes les transactions sont stockées en **Pièces** (unité minimale) pour éviter les erreurs de calcul.
- **Audit :** Crucial pour la traçabilité demandée par le gérant.

### Project Structure Notes

- L'application `inventory` centralise toute cette logique.
- Utilisation de `django.db.models.Sum` pour les performances de calcul.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Inventory Ledger System]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2: Gestion du Référentiel Articles & Multi-Stocks]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
