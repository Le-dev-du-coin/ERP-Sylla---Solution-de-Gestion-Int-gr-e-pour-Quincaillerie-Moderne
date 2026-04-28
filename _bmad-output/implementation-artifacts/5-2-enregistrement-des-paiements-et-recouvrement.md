Status: ready-for-dev

## Story

As a **Gérant**,
I want **enregistrer les versements effectués par les clients**,
so that **leur solde de dette soit mis à jour et qu'ils reçoivent un reçu de paiement**.

## Acceptance Criteria

1. **Given** un client ayant une dette (solde positif)
2. **When** je saisis un montant de versement et le mode de paiement (Espèces, MOMO, etc.)
3. **Then** une instance du modèle `Payment` est créée
4. **And** le solde du client est déduit du montant versé de manière atomique
5. **And** un reçu de paiement PDF est généré (Format A5 ou A4)
6. **And** le système envoie une notification WhatsApp au client incluant :
    - Confirmation du montant reçu
    - Date et heure du versement
    - Nouveau solde restant dû
    - Lien vers le reçu PDF
7. **When** le versement est supérieur à la dette
8. **Then** le solde devient négatif (créance/avoir en faveur du client) ou le système demande confirmation

## Tasks / Subtasks

- [ ] Modèle Paiement (AC: 1, 2, 3)
  - [ ] Créer le modèle `Payment` dans `apps/sales/models.py` (Client, Amount, Method, Date, Reference)
  - [ ] Ajouter l'audit (`HistoricalRecords`)
  - [ ] Créer et lancer les migrations
- [ ] Logique de Recouvrement (AC: 4, 7, 8)
  - [ ] Créer un service `process_payment(customer, amount, method)`
  - [ ] Gérer la mise à jour atomique du solde client via `select_for_update()`
- [ ] Documents et Notifications (AC: 5, 6)
  - [ ] Créer le template HTML/CSS pour le reçu de paiement (`payment_receipt_pdf.html`)
  - [ ] Créer une tâche Celery `send_payment_notification_whatsapp_task`
  - [ ] Intégrer le lien public sécurisé pour le reçu (comme pour les factures)
- [ ] Interface Utilisateur
  - [ ] Ajouter un bouton "Enregistrer un versement" sur la fiche client
  - [ ] Créer une modal HTMX pour la saisie rapide du paiement
- [ ] Validation
  - [ ] Tester un remboursement partiel et vérifier le solde
  - [ ] Tester un remboursement total (solde à 0)
  - [ ] Vérifier la réception du WhatsApp de confirmation

## Dev Notes

- **Modèle :** Un `Payment` ne doit pas pouvoir être supprimé, seulement annulé (avec audit).
- **Trésorerie :** Ces paiements devront être liés au futur journal de caisse (Story 5.3).

### Project Structure Notes

- Réutiliser la logique de `SecurePDFDownloadView` pour les reçus de paiement.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR20]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 5: CRM, Gestion des Dettes & Mouvements de Stock]
