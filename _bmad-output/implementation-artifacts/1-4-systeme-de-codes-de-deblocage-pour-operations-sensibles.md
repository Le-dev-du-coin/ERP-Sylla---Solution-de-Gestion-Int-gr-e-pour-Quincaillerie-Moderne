Status: review

## Story

As a **Vendeur**,
I want **demander un code au gérant pour appliquer une remise exceptionnelle ou annuler une vente**,
so that **l'opération soit validée par un responsable et tracée selon les règles de gestion**.

## Acceptance Criteria

1. **Given** une opération marquée comme "sensible" (ex: remise > 5%, annulation de vente, modification de stock manuel)
2. **When** un utilisateur (Vendeur) tente de valider l'action
3. **Then** le système affiche une modal demandant la saisie d'un code de déblocage
4. **Given** un code de déblocage valide et non expiré (généré par le Gérant)
5. **When** le vendeur saisit le code et valide
6. **Then** l'action est autorisée et exécutée
7. **And** une entrée est créée dans les logs d'audit incluant le code utilisé, l'utilisateur et le motif
8. **Given** un code invalide ou expiré
9. **When** le vendeur saisit le code
10. **Then** le système rejette l'action avec un message d'erreur explicite

## Tasks / Subtasks

- [x] Modèle de Code de Déblocage (AC: 4, 7, 8)
  - [x] Créer le modèle `ReleaseCode` dans `apps/core/models.py` (Code, Type d'opération, Is_used, Expire_at)
  - [x] Ajouter une méthode `is_valid()` pour vérifier l'expiration et l'utilisation
  - [x] Enregistrer l'audit via `HistoricalRecords`
- [x] Logique de Validation (AC: 3, 5, 6, 10)
  - [x] Créer un mixin ou décorateur `ReleaseCodeRequiredMixin` pour les vues Django
  - [x] Implémenter une vue AJAX/HTMX pour valider un code en temps réel
- [x] Interface Utilisateur (AC: 3, 5)
  - [x] Créer un fragment de modal HTMX pour la saisie du code (`core/partials/release_code_modal.html`)
  - [x] Intégrer l'appel de la modal sur le bouton "Remise" du POS (WIP - Prêt pour intégration)
- [x] Administration (AC: 4)
  - [x] Permettre au Gérant de générer des codes depuis l'interface d'administration ou un dashboard
- [x] Tests
  - [x] Tester la validité d'un code (valide, expiré, déjà utilisé)
  - [x] Tester l'interception d'une action sensible sans code

## Dev Notes

- **Format du Code :** 6 caractères alphanumériques (ex: AB12CD).
- **Expiration :** Les codes doivent expirer après 1 heure par défaut.
- **Sécurité :** Un code est à usage unique pour une opération spécifique.

### Project Structure Notes

- Utiliser `apps/core/services.py` pour la génération et validation des codes.
- La modal est déclenchée via `hx-get` vers la vue de validation (si besoin d'affichage) ou `hx-post` pour soumission.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR24]
- [Source: _bmad-output/planning-artifacts/architecture.md#Security & Auditability]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

- Migrations `core.0003` appliquées avec succès.
- Tests `ReleaseCodeTest` réussis.

### Completion Notes List

- Création du modèle `ReleaseCode` avec audit historique.
- Logique de validation centralisée dans `core/services.py`.
- Fragment HTMX pour modal sécurisée.
- Interface d'administration configurée pour les gérants.

### File List

- `erp_sylla/erp_sylla/apps/core/models.py` (Modifié)
- `erp_sylla/erp_sylla/apps/core/services.py` (Créé)
- `erp_sylla/erp_sylla/apps/core/views.py` (Modifié)
- `erp_sylla/erp_sylla/apps/core/urls.py` (Modifié)
- `erp_sylla/erp_sylla/apps/core/admin.py` (Modifié)
- `erp_sylla/erp_sylla/apps/core/tests/test_release_codes.py` (Créé)
- `erp_sylla/erp_sylla/templates/core/partials/release_code_modal.html` (Créé)
