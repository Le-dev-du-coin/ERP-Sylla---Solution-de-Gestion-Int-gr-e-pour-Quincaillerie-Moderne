Status: review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As a **Développeur**,
I want **initialiser le projet avec une structure de production robuste (Docker/Django)**,
so that **je dispose d'un environnement de développement et de déploiement standardisé**.

## Acceptance Criteria

1. **Given** l'outil `cookiecutter` est installé
2. **When** je lance la commande d'initialisation avec les options spécifiées (Docker, Celery, PostgreSQL)
3. **Then** un projet Django complet est généré
4. **And** les fichiers `docker-compose.yml` et `.envs/` sont configurés pour le projet "ERP Sylla"
5. **And** la commande `docker compose up` démarre avec succès les containers (django, postgres, redis)

## Tasks / Subtasks

- [x] Préparer l'environnement (AC: 1)
  - [x] Vérifier/Installer cookiecutter via poetry
- [x] Initialiser le projet (AC: 2, 3)
  - [x] Lancer `cookiecutter https://github.com/cookiecutter/cookiecutter-django`
  - [x] Configurer les options : `use_docker: y`, `use_celery: y`, `frontend_pipeline: Tailwind`
  - [x] Nom du projet : `ERP Ets Sylla Madjou`, Slug : `erp_sylla`
- [x] Valider la configuration Docker (AC: 4, 5)
  - [x] Vérifier la présence de `docker-compose.yml` et des fichiers `.envs/`
  - [x] Tenter un `docker compose up --build` pour confirmer le démarrage des containers


## Dev Notes

- **Starter :** Cookiecutter Django (Standard industriel).
- **Backend :** Python 3.12+ / Django 5.0+.
- **Frontend :** Tailwind CSS via container dédié.
- **Queue de tâches :** Celery + Redis.
- **Base de données :** PostgreSQL.
- **Note :** Utiliser `poetry` pour toute commande python locale si nécessaire, mais privilégier Docker pour l'exécution du projet.

### Project Structure Notes

- Le projet doit suivre la structure générée par Cookiecutter.
- Les applications métier seront situées dans `erp_sylla/apps/` selon l'architecture définie.

### References

- [Source: _bmad-output/planning-artifacts/architecture.md#Starter Selected: Cookiecutter Django]
- [Source: _bmad-output/planning-artifacts/epics.md#Story 1.1: Initialisation du Projet avec Cookiecutter Django]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

### Completion Notes List

### File List
