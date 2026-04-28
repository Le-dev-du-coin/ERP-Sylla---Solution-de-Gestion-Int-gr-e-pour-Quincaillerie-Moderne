Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Gérant**,
I want **que chaque modification de donnée sensible soit enregistrée avec l'ancienne et la nouvelle valeur**,
so that **je puisse auditer les erreurs ou les fraudes éventuelles**.

## Acceptance Criteria

1. **Given** la librairie `django-simple-history` est installée
2. **When** un modèle marqué comme "audité" est créé, modifié ou supprimé
3. **Then** une entrée est créée automatiquement dans la table d'historique
4. **And** l'enregistrement contient l'utilisateur, la date, l'action et les valeurs modifiées
5. **And** l'intégrité est garantie même en cas de micro-coupure (Idempotence)

## Tasks / Subtasks

- [x] Installation et configuration de base (AC: 1)
  - [x] Ajouter `'simple_history'` à `INSTALLED_APPS` dans `config/settings/base.py`
  - [x] Ajouter le middleware `'simple_history.middleware.HistoryRequestMiddleware'`
- [x] Mise en œuvre sur un modèle pilote (AC: 2, 3, 4)
  - [x] Créer une application `core` si elle n'existe pas encore (`apps/core/`)
  - [x] Définir un modèle de test ou utiliser un modèle existant dans `apps/core/models.py`
  - [x] Intégrer `HistoricalRecords()` au modèle choisi
- [x] Validation technique (AC: 5)
  - [x] Lancer les migrations (`poetry run python manage.py migrate`)
  - [x] Vérifier la création de la table `historical...` dans PostgreSQL
  - [x] Créer une vue admin ou un script de test pour confirmer l'enregistrement des modifications


## Dev Notes

- **Bibliothèque :** `django-simple-history` est le standard retenu dans l'architecture.
- **Middleware :** Indispensable pour capturer automatiquement l'utilisateur qui effectue la modification.
- **Modèles concernés :** À terme, tous les modèles sensibles (Ventes, Stocks, Prix) devront être audités.
- **Intégrité :** Utiliser les transactions atomiques de Django pour garantir l'idempotence.

### Project Structure Notes

- La configuration de l'audit doit être centralisée dans `apps/core/` ou via un mixin réutilisable.
- Les fichiers de migration doivent être vérifiés pour s'assurer que les tables d'historique sont correctement créées.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Security & Auditability]
- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.2: Traçabilité des Données via Audit Logs]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
