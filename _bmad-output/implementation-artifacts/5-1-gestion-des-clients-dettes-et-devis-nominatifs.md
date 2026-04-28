Status: ready-for-dev

## Story

As a **Gérant / Vendeur**,
I want **créer des fiches clients et les associer aux ventes ou devis**,
so that **je puisse suivre les dettes de chacun et fournir des documents nominatifs**.

## Acceptance Criteria

1. **Given** un nouveau client
2. **When** je saisis son nom et son téléphone WhatsApp
3. **Then** une fiche client est créée avec un solde initial à 0 F CFA
4. **Given** un client existant
5. **When** je réalise une vente (SALE) ou un devis (QUOTE)
6. **Then** je peux sélectionner ce client dans l'interface de Checkout
7. **And** le nom du client apparaît sur la facture PDF ou le devis PDF généré
8. **When** une vente est validée avec le mode de paiement "CREDIT"
9. **Then** le montant total est automatiquement ajouté à la dette (solde) du client
10. **And** une entrée est créée dans les logs d'audit du client
11. **When** je consulte la fiche client
12. **Then** je vois son solde actuel et l'historique complet de ses transactions (Ventes, Devis, Paiements)

## Tasks / Subtasks

- [ ] Modèle Client (AC: 1, 3, 11)
  - [ ] Créer le modèle `Customer` dans `apps/sales/models.py` (Nom, Téléphone, Adresse, Solde)
  - [ ] Ajouter l'audit (`HistoricalRecords`)
  - [ ] Créer et lancer les migrations
- [ ] Association Client-Vente (AC: 4, 5, 6, 8, 9)
  - [ ] Ajouter un lien ForeignKey `customer` (optionnel) dans le modèle `Sale`
  - [ ] Mettre à jour `complete_sale` pour gérer l'incrémentation automatique du solde client si "CREDIT"
  - [ ] Créer les migrations nécessaires
- [ ] Interface Utilisateur (AC: 2, 6, 7, 12)
  - [ ] Créer une vue `CustomerListView` et `CustomerDetailView`
  - [ ] Ajouter une recherche de client (HTMX) dans la page de Checkout
  - [ ] Mettre à jour les templates PDF (`invoice_pdf.html`) pour afficher le nom du client si présent
- [ ] Validation
  - [ ] Tester une vente à crédit et vérifier que le solde client augmente
  - [ ] Vérifier qu'un devis associé à un client n'impacte pas son solde
  - [ ] Valider l'affichage du nom sur le PDF

## Dev Notes

- **Solde :** Un solde positif représente une dette du client envers l'entreprise.
- **WhatsApp :** Le numéro du client sur la fiche doit être utilisé par défaut pour l'envoi de la facture si renseigné.
- **Audit :** Utiliser `django-simple-history` pour tracer les changements de solde.

### Project Structure Notes

- La logique de mise à jour du solde doit être isolée dans `apps/sales/services.py` au sein de la transaction atomique.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR20]
- [Source: _bmad-output/planning-artifacts/epics.md#Epic 5: CRM, Gestion des Dettes & Mouvements de Stock]
