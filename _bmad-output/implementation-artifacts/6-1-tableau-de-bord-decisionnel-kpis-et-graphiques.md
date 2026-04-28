Status: ready-for-dev

## Story

As a **Gérant**,
I want **visualiser les indicateurs clés de mon activité sous forme de graphiques**,
so that **je puisse suivre l'évolution de mon chiffre d'affaires et de ma rentabilité en un coup d'œil**.

## Acceptance Criteria

1. **Given** une connexion en tant que Gérant
2. **When** j'accède à la page "Rapports BI"
3. **Then** je vois les indicateurs clés (KPIs) suivants :
    - Chiffre d'Affaires (CA) total sur la période sélectionnée
    - Nombre total de ventes validées
    - Panier moyen (CA / Nombre de ventes)
    - Marge brute estimée (Prix de vente - Prix d'achat)
4. **And** je vois un graphique linéaire montrant l'évolution quotidienne du CA (Chart.js)
5. **And** je vois un graphique circulaire montrant la répartition des ventes par mode de paiement (Orange Money, Wave, Moov, Espèces, Chèque)
6. **When** je change la période de filtrage (ex: "7 derniers jours")
7. **Then** les KPIs et les graphiques sont mis à jour instantanément (via HTMX ou rechargement)

## Tasks / Subtasks

- [ ] Préparation Backend (AC: 3)
  - [ ] Créer une vue `FinanceReportView` dans `apps/core/views.py`
  - [ ] Implémenter la logique de calcul des agrégats (Sum, Count) par période
  - [ ] Calculer la marge brute en se basant sur `SaleItem.unit_price` et `Product.purchase_price`
- [ ] Interface & Graphiques (AC: 4, 5)
  - [ ] Intégrer la bibliothèque `Chart.js` via CDN ou static
  - [ ] Créer le template `core/finance_report.html` avec une mise en page moderne (Grid)
  - [ ] Générer les données au format JSON pour les graphiques
- [ ] Filtres (AC: 6, 7)
  - [ ] Ajouter un formulaire de filtrage par date
  - [ ] Gérer les périodes prédéfinies (Aujourd'hui, 7j, 30j, Ce mois)
- [ ] Validation
  - [ ] Vérifier la cohérence entre les chiffres du journal de caisse et ceux du Dashboard
  - [ ] Valider que les marges ne sont visibles que par les gérants

## Dev Notes

- **Performance :** Utiliser `.select_related()` et `.prefetch_related()` pour minimiser les requêtes lors des calculs d'agrégation.
- **Chart.js :** Préférer les graphiques responsives pour une consultation mobile confortable.

### Project Structure Notes

- La vue sera portée par l'application `core` qui centralise déjà les fonctions financières.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR16, FR18]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 6: Pilotage Financier & Business Intelligence (BI)]
