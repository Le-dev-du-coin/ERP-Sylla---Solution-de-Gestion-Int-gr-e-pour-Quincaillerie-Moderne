Status: ready-for-dev

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Gérant**,
I want **créer et gérer mon catalogue d'articles**,
so that **je puisse configurer les prix et les unités de vente pour l'ensemble du système**.

## Acceptance Criteria

1. **Given** l'application `inventory` est initialisée
2. **When** je crée un article
3. **Then** je peux saisir son nom, sa description, son prix d'achat, son prix de vente pièce et son prix de vente carton (en F CFA, entier uniquement)
4. **And** je dois définir un `conversion_factor` (ex: 1 carton = 24 pièces)
5. **And** le champ **Code Barre** est facultatif (peut être laissé vide)
6. **And** chaque modification est tracée via `django-simple-history`
7. **And** une interface de liste permet de visualiser tous les articles avec leurs stocks (stock initial à 0)
Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

...
- [x] Initialisation de l'application Inventory (AC: 1)
  - [x] Créer l'application `erp_sylla.apps.inventory`
  - [x] L'enregistrer dans `config/settings/base.py`
- [x] Modèle de données Product (AC: 2, 3, 4, 5, 6)
  - [x] Créer le modèle `Product` dans `apps/inventory/models.py`
  - [x] Utiliser `PositiveIntegerField` pour tous les champs monétaires (XOF sans centimes)
  - [x] Ajouter les champs : `name`, `description`, `sku`, `barcode` (null=True, blank=True), `purchase_price`, `sale_price_piece`, `sale_price_carton`, `conversion_factor`
  - [x] Intégrer `HistoricalRecords()` au modèle
  - [x] Créer et lancer la migration
- [x] Outils de Formatage Monétaire (AC: 8)
  - [x] Créer un dossier `apps/core/templatetags/`
  - [x] Créer un template filter `money` dans `apps/core/templatetags/erp_tags.py` pour le formatage F CFA
- [x] Interface d'administration et Vues (AC: 7, 8)
  - [x] Configurer `admin.py` pour une gestion aisée des produits
  - [x] Créer une vue `ProductListView` simple dans `apps/inventory/views.py`
  - [x] Créer le template `inventory/product_list.html` utilisant le filtre `money`
- [x] Validation (AC: 5, 6, 8)
  - [x] Créer un test unitaire vérifiant la création sans code barre
  - [x] Tester le filtre de template `money` avec plusieurs valeurs

- **Monnaie :** Franc CFA (XOF). Stockage en entiers (`PositiveIntegerField`) car pas de centimes.
- **Formatage :** Utiliser `intcomma` de Django ou un filtre personnalisé pour le séparateur de milliers (espace insécable préféré).
- **Conventions :** Suivre le pattern `erp_sylla.apps.[nom]`.

### Project Structure Notes

- Créer les dossiers `apps/inventory/migrations`, `apps/inventory/templates/inventory`.
- Les URLs de l'inventaire devront être incluses dans `config/urls.py`.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Inventory Ledger System]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 2: Gestion du Référentiel Articles & Multi-Stocks]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
