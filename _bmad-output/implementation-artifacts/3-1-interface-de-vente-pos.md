Status: ready-for-dev

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Vendeur**,
I want **une interface de caisse ultra-rapide et mobile**,
so that **je puisse servir les clients au comptoir sans délai et sans erreur de calcul**.

## Acceptance Criteria

1. **Given** un vendeur connecté
2. **When** il accède à la vue "Point de Vente" (POS)
3. **Then** il voit une barre de recherche universelle flottante en haut de l'écran
4. **When** il saisit 3 caractères
5. **Then** les articles correspondants s'affichent instantanément avec leur stock actuel (HTMX)
6. **And** chaque article propose un bouton d'ajout rapide avec le choix "Pièce" ou "Carton"
7. **And** l'interface respecte la "Thumb-Zone" (actions principales accessibles en bas sur mobile)
8. **And** le design utilise la palette `Slate-900` (primaire) et `Green-500` (accent)

## Tasks / Subtasks

- [ ] Préparation du module Ventes (Epic 3)
  - [ ] Créer l'application `erp_sylla.apps.sales`
  - [ ] L'enregistrer dans `config/settings/base.py`
- [ ] Vues et Templates POS (AC: 2, 3, 7, 8)
  - [ ] Créer une vue `POSView` (TemplateView) dans `apps/sales/views.py`
  - [ ] Concevoir le template `sales/pos.html` avec une structure Mobile-First
  - [ ] Intégrer une barre de recherche flottante
- [ ] Moteur de Recherche en temps réel (AC: 4, 5, 6)
  - [ ] Créer une vue `ProductSearchView` (HTMX) qui renvoie des fragments HTML d'articles
  - [ ] Afficher pour chaque résultat : Nom, Stock (formatté), Prix Pièce et Prix Carton
  - [ ] Ajouter les boutons "Ajouter" avec sélection d'unité
- [ ] Intégration et Navigation
  - [ ] Mettre à jour `config/urls.py` pour inclure les ventes
  - [ ] Rediriger le lien "Point de Vente" de la sidebar vers cette nouvelle vue


## Dev Notes

- **Performance :** La recherche doit être ultra-fluide. Utiliser `hx-trigger="keyup changed delay:300ms"`.
- **UX :** Pas de chargement de page lors de la recherche. Les résultats s'affichent dans une liste sous la barre de recherche.
- **Stock :** Afficher le stock consolidé (somme de tous les entrepôts) ou demander l'entrepôt par défaut du vendeur (à affiner).

### Project Structure Notes

- Dossiers : `apps/sales/migrations`, `apps/sales/templates/sales`.
- Style : Utiliser les classes CSS existantes dans `dashboard.css`.

### References

- [Source: _bmad-output/planning-artifacts/ux-design-specification.md#5.1 La "Vente Flash" au Comptoir]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 3: Caisse Rapide (POS) & Vente au Comptoir]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
