Status: ready-for-dev

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Vendeur**,
I want **gérer un panier d'achat dynamique**,
so that **je puisse voir le montant total de la vente et ajuster les quantités avant de valider**.

## Acceptance Criteria

1. **Given** l'interface POS ouverte
2. **When** je clique sur "Ajouter Pc" ou "Ajouter Ct" sur un article
3. **Then** l'article est ajouté au panier avec le prix correspondant à l'unité choisie
4. **And** le montant total est recalculé instantanément (HTMX)
5. **When** je modifie la quantité ou supprime un article du panier
6. **Then** l'interface se met à jour sans recharger la page
7. **And** le panier persiste même si je rafraîchis la page (Session)
8. **And** tous les calculs respectent le formatage F CFA sans virgule

## Tasks / Subtasks

- [ ] Logique Backend du Panier (Basket)
  - [ ] Créer une classe utilitaire `Basket` dans `apps/sales/cart.py` utilisant les sessions
  - [ ] Implémenter les méthodes : `add`, `remove`, `update`, `clear`, `get_total_price`
- [ ] Vues HTMX du Panier
  - [ ] Créer une vue `CartAddView` pour gérer l'ajout
  - [ ] Créer une vue `CartDetailView` (fragment) pour rafraîchir l'affichage du panier
  - [ ] Créer une vue `CartRemoveView` pour la suppression
- [ ] Templates et UI
  - [ ] Concevoir le fragment `sales/_cart_detail.html` (Tableau compact avec boutons +/-)
  - [ ] Intégrer les appels HTMX sur les boutons du panier
  - [ ] Afficher le résumé financier (Total Articles, Total Net)
- [ ] Validation
  - [ ] Tester l'ajout d'articles avec différentes unités (Carton vs Pièce)
  - [ ] Vérifier que le total est correct mathématiquement


## Dev Notes

- **Session key :** Utiliser `"basket"` comme clé de session.
- **Conversion :** Si l'unité est `CARTON`, le prix unitaire utilisé doit être `product.sale_price_carton`.
- **Performance :** Utiliser `hx-swap="innerHTML"` pour mettre à jour uniquement la zone du panier.

### Project Structure Notes

- Le fichier `cart.py` permettra de découpler la logique du panier des vues.
- Le panier doit stocker l'ID du produit, la quantité et l'unité choisie.

### References

- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#6.3 Implementation Roadmap]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 3: Caisse Rapide (POS) & Vente au Comptoir]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
