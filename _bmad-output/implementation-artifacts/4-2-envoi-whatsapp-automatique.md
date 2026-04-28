Status: done

## Story

As a **Gérant**,
I want **envoyer automatiquement la facture PDF au client par WhatsApp via Wachap dès la validation de la vente**,
so that **le client reçoive son justificatif instantanément et que je réduise mes coûts d'impression**.

## Acceptance Criteria

1. **Given** une vente validée avec un numéro de téléphone client renseigné
2. **When** la transaction est terminée avec succès
3. **Then** le système génère le PDF et l'enregistre dans le dossier `media` (via Celery)
4. **And** le système envoie une requête POST à l'API Wachap avec l'Instance ID et le Token configurés.
5. **And** le message contient un lien public sécurisé par un token UUID avec une durée de validité configurable.
6. **And** le client est invité à télécharger son document avant expiration du lien.
7. **And** le gérant reçoit un rapport journalier détaillé au format PDF chaque soir à l'heure configurée.
8. **And** une interface de suivi permet aux vendeurs et gérants de voir l'état des envois (Succès/Échec).

## Tasks / Subtasks

- [x] Configuration de l'API Wachap (AC: 4)
  - [x] Créer le modèle `CommunicationConfig` (Instance ID, Token, Version ERP, Heure Rapport)
  - [x] Créer l'interface de réglages pour le gérant
- [x] Logique Asynchrone avec Celery (AC: 3, 5, 7)
  - [x] Créer la tâche `send_sale_summary_whatsapp_task` avec lien expirable
  - [x] Implémenter la génération du rapport journalier PDF (`send_daily_report_task`)
- [x] Sécurité et Expiration (AC: 5, 6)
  - [x] Créer la vue `SecurePDFDownloadView` avec validation de token et date
  - [x] Ajouter une page d'erreur conviviale pour les liens expirés
- [x] Interface de Suivi (AC: 8)
  - [x] Créer le tableau de bord des notifications WhatsApp
  - [x] Intégrer les liens dans la sidebar (Vendeur & Gérant)
- [x] Finitions
  - [x] Afficher la version de l'ERP dynamiquement sur tous les supports
  - [x] Forcer le format 24h pour la programmation des rapports

## Dev Notes

- **Identifiants :** Utilisation du couple `wachap_instance_id` et `wachap_token`.
- **Rapports :** Programmation via `django-celery-beat`.
- **Version :** Gérée via un Context Processor pour une mise à jour globale.

### Project Structure Notes

- Application `communications` centralise toute la logique de notification et configuration.

### Completion Notes List

- Système de notification robuste avec gestion des échecs.
- Double authentification Wachap implémentée.
- Rapports journaliers PDF automatisés avec liens sécurisés.
- Fluidité de navigation améliorée via HTMX Boost.
