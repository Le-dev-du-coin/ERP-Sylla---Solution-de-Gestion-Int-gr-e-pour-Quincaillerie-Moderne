---
story_id: 1.5
story_key: 1-5-sauvegarde-et-exportation-de-la-base-de-donnees
status: done
epic_id: 1
project: ERP Ets Sylla Madjou
date: 2026-04-25
---

# Story 1.5: Sauvegarde et Exportation de la Base de Données

**En tant que** Gérant,
**Je veux** pouvoir exporter la base de données manuellement et configurer des sauvegardes automatiques,
**Afin de** sécuriser mes données contre toute perte matérielle ou logicielle.

## 🎯 Critères d'Acceptation (BDD)

### 1. Export Manuel
**Étant donné que** je suis connecté en tant que **Gérant**
**Quand** j'accède aux paramètres du système et que je clique sur "Sauvegarde Manuelle"
**Alors** un dump SQL de la base de données PostgreSQL est généré
**Et** je peux télécharger le fichier directement.

### 2. Sauvegarde Automatique
**Étant donné que** le système est en production
**Alors** une tâche Celery s'exécute périodiquement pour créer une sauvegarde
**Et** les sauvegardes sont listées dans l'interface avec leur taille et date.

## 🏗️ Implémentation Technique
*   **Modèle :** `DatabaseBackup` dans `apps.core`.
*   **Service :** `BackupService` utilisant `pg_dump`.
*   **Tâche :** `run_auto_backup` via Celery.
*   **Interface :** Vue `SettingsDashboardView` dédiée.

## ✅ Statut
- **Fait le :** 25/04/2026
- **Validé par :** MaliandevBoy
