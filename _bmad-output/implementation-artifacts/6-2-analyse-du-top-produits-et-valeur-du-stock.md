Status: ready-for-dev

## Story

As a **Gérant**,
I want **connaître mes produits les plus vendus et la valeur financière de mon stock**,
so that **je puisse optimiser mon approvisionnement et protéger ma trésorerie**.

## Acceptance Criteria

1. **Given** une connexion en tant que Gérant
2. **When** je consulte l'onglet "Stocks & Produits" des rapports BI
3. **Then** je vois le Top 10 des articles les plus vendus (en volume de pièces)
4. **And** je vois la valeur financière totale de mon stock (Quantité physique x Prix d'achat moyen)
5. **And** je peux filtrer cette valeur par entrepôt (Boutique 1, Dépôt, etc.)
6. **And** le système met en évidence les produits "à risque" (faible rotation ou rupture imminente cumulée au top vente)

## Tasks / Subtasks

- [ ] Logique Top Ventes (AC: 3)
  - [ ] Créer une méthode d'agrégation dans `ProductManager` ou un service dédié
  - [ ] Classer par `Sum('sale_items__quantity')`
- [ ] Calcul de Valeur de Stock (AC: 4, 5)
  - [ ] Calculer dynamiquement `Sum(Quantité actuelle * purchase_price)`
  - [ ] Permettre le filtrage par entrepôt via une annotation SQL performante
- [ ] Interface (AC: 6)
  - [ ] Ajouter une section "Analyse Produits" dans `core/finance_report.html`
  - [ ] Créer un graphique à barres horizontales pour le Top 10
- [ ] Validation
  - [ ] Vérifier que la valeur du stock correspond à l'inventaire physique théorique
  - [ ] Tester les performances sur un catalogue de plus de 1000 articles

## Dev Notes

- **Optimisation :** Pour la valeur du stock, utiliser une vue matérialisée ou un cache si le catalogue devient très important.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR17, FR19]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 6: Pilotage Financier & Business Intelligence (BI)]
