Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Vendeur**,
I want **valider une vente et déstocker automatiquement les articles**,
so that **mes stocks soient à jour et que je puisse fournir un reçu au client**.

## Acceptance Criteria

1. **Given** un panier rempli
2. **When** je valide la vente sur la page de Checkout
3. **Then** une instance du modèle `Sale` est créée avec le type "VENTE"
4. **And** pour chaque article, une ligne `SaleItem` est créée et le stock est déduit automatiquement (via `StockTransaction`)
5. **And** le panier est vidé après la validation réussie
6. **When** je choisis le type "DEVIS"
7. **Then** la transaction est enregistrée mais le stock n'est pas déduit
8. **And** tous les montants et quantités respectent la logique Carton/Pièce et Franc CFA

## Tasks / Subtasks

- [x] Modèles de Vente (AC: 3, 4, 7)
  - [x] Créer le modèle `Sale` dans `apps/sales/models.py` (Type: VENTE/DEVIS, Total, Paiement, Vendeur)
  - [x] Créer le modèle `SaleItem` (Sale, Product, Quantity, Unit, UnitPrice, Total)
  - [x] Intégrer l'audit (`HistoricalRecords`)
  - [x] Créer et lancer les migrations
- [x] Logique de Validation et Déstockage (AC: 4, 5, 7)
  - [x] Créer un service de validation `complete_sale(basket, user, warehouse, type, payment_method)`
  - [x] Implémenter la déduction automatique du stock lors d'une "VENTE"
  - [x] Gérer l'atomicité de la transaction (Vente + Stock + Clear Basket)
- [x] Interface Finale (AC: 2, 6, 8)
  - [x] Mettre à jour la vue `CheckoutView` pour traiter le formulaire de paiement
  - [x] Créer une page de succès affichant le numéro de facture/devis
  - [x] [Optionnel] Préparer le bouton "Imprimer" (Placeholder avant Story 4.1)
- [x] Validation
  - [x] Tester une vente complète et vérifier la table `StockTransaction`
  - [x] Tester un devis et vérifier que le stock ne bouge pas


## Dev Notes

- **Modèles :** `Sale` doit avoir un champ `status` (PENDING, COMPLETED, CANCELLED).
- **Stock :** La déduction doit se faire dans l'entrepôt du vendeur (à défaut, le premier entrepôt actif).
- **Facturation :** Le numéro de facture doit être unique (ex: FAC-2026-0001).

### Project Structure Notes

- Toute la logique de calcul de prix final doit se faire côté serveur lors de la validation.
- Utiliser `apps/sales/services.py` pour la logique de déstockage.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Sale & Payment Flow]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 3: Caisse Rapide (POS) & Vente au Comptoir]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

- Migration `0002_historicalsale_status_sale_status` appliquée avec succès.
- Tests unitaires réussis : `test_complete_sale_validates_and_reduces_stock`, `test_complete_quote_does_not_reduce_stock`, `test_insufficient_stock_raises_error`.

### Completion Notes List

- Implémentation du service `complete_sale` dans `apps/sales/services.py`.
- Ajout du champ `status` au modèle `Sale` (nécessaire pour le suivi futur).
- Activation de l'audit sur `SaleItem`.
- Validation complète de la boucle HTMX -> Panier -> Checkout -> Déstockage -> Success Page.

### File List

- `erp_sylla/erp_sylla/apps/sales/models.py` (Modifié)
- `erp_sylla/erp_sylla/apps/sales/services.py` (Modifié)
- `erp_sylla/erp_sylla/apps/sales/views.py` (Modifié)
- `erp_sylla/erp_sylla/apps/sales/tests.py` (Créé)
- `erp_sylla/erp_sylla/apps/sales/migrations/0002_historicalsale_status_sale_status.py` (Créé)
