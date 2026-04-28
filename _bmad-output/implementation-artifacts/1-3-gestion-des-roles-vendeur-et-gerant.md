Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Gérant**,
I want **définir des niveaux d'accès spécifiques pour mes employés**,
so that **les vendeurs n'accèdent pas aux données financières confidentielles (marge, bénéfice)**.

## Acceptance Criteria

1. **Given** le modèle User personnalisé de Django
2. **When** je crée ou modifie un utilisateur
3. **Then** je peux lui assigner le rôle "Vendeur" ou "Gérant" via un champ dédié ou les Groupes Django
4. **And** un "Vendeur" est automatiquement ajouté au groupe 'Vendeurs' avec des permissions limitées
5. **And** un "Gérant" est automatiquement ajouté au groupe 'Gérants' avec accès aux rapports BI
6. **And** le système refuse l'accès aux vues sensibles si l'utilisateur n'a pas le rôle requis (Test avec une vue placeholder)

## Tasks / Subtasks

- [x] Mise au jour du modèle User (AC: 1, 2, 3)
  - [x] Ajouter un champ `role` (choices: 'GERANT', 'VENDEUR') au modèle `User` dans `users/models.py`
  - [x] Créer et lancer la migration (`makemigrations`, `migrate`)
- [x] Initialisation des Groupes et Permissions (AC: 4, 5)
  - [x] Créer une commande de gestion (`manage.py init_roles`) pour créer les groupes 'Vendeurs' et 'Gérants'
  - [x] Définir les permissions de base pour chaque groupe
  - [x] Surcharger la méthode `save()` du modèle User pour synchroniser le groupe en fonction du champ `role`
- [x] Sécurisation des accès (AC: 6)
  - [x] Créer des mixins/décorateurs réutilisables dans `apps/core/permissions.py` (ex: `GerantRequiredMixin`)
  - [x] Créer une vue de test "Dashboard Financier" accessible uniquement aux Gérants
  - [x] Créer une vue de test "POS" accessible aux deux rôles
- [x] Validation (AC: 6)
  - [x] Créer des tests unitaires pour vérifier les redirections/blocages en fonction du rôle


## Dev Notes

- **Modèle de données :** Privilégier un champ `role` sur le modèle User pour la simplicité, tout en utilisant les Groupes Django en arrière-plan pour la compatibilité avec le système de permissions natif.
- **Localisation :** Placer les outils de permissions transverses dans `erp_sylla/apps/core/permissions.py`.
- **Règle de gestion :** Un superuser doit par défaut avoir les droits de Gérant.

### Project Structure Notes

- Le modèle User est dans `erp_sylla/users/models.py`.
- L'application `core` (créée en story 1-2) doit accueillir la logique de sécurité globale.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Security & Auditability]
- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.3: Gestion des Rôles Vendeur et Gérant]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
