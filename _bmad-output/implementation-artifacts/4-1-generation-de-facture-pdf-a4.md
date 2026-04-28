Status: review

## Story

As a **Vendeur**,
I want **générer une facture au format PDF A4 professionnel après chaque vente**,
so that **je puisse la remettre physiquement au client ou l'envoyer plus tard**.

## Acceptance Criteria

1. **Given** une vente (`Sale`) validée
2. **When** je clique sur le bouton "IMPRIMER LE REÇU" (ou automatiquement après validation)
3. **Then** le système génère un fichier PDF au format A4
4. **And** le PDF contient les informations obligatoires :
    - En-tête de l'entreprise (Nom, contact, localisation)
    - Numéro de facture unique et date
    - Liste détaillée des articles (Désignation, Qté, Unité, Prix unitaire, Total ligne)
    - Récapitulatif financier (Total Brut, Remises éventuelles, Total NET à payer)
    - Mode de paiement utilisé
5. **And** le design respecte la charte graphique (Logo, typographie lisible)
6. **When** la vente est un "DEVIS"
7. **Then** le document généré porte la mention "DEVIS / PROFORMA" et n'a pas de valeur de facture

## Tasks / Subtasks

- [x] Configuration du Moteur PDF (AC: 3)
  - [x] Installer et configurer `django-weasyprint` ou `weasyprint` directement
  - [x] Configurer les chemins de stockage temporaire des PDF
- [x] Template de Facture HTML (AC: 4, 5, 7)
  - [x] Créer le template `sales/invoice_pdf.html` optimisé pour l'impression A4
  - [x] Gérer l'affichage conditionnel "Facture" vs "Devis"
  - [x] Intégrer les styles CSS pour le formatage (logo, tableaux, totaux)
- [x] Logique Backend (AC: 2, 6)
  - [x] Créer une vue `generate_invoice_pdf_view` pour servir le PDF au navigateur
  - [x] Implémenter un service `generate_invoice_pdf_file` pour enregistrer le PDF (requis pour WhatsApp plus tard)
- [x] Interface Utilisateur (AC: 2)
  - [x] Lier le bouton d'impression de la page de succès à la nouvelle vue PDF
- [x] Tests
  - [x] Vérifier la génération sans erreur pour une vente et un devis
  - [x] S'assurer que les caractères spéciaux (F CFA) s'affichent correctement

## Dev Notes

- **Outil :** Utiliser `WeasyPrint` (recommandé pour Django) pour un rendu CSS fidèle.
- **Formatage :** Utiliser le filtre `money` personnalisé pour tous les montants.
- **Stockage :** Les factures peuvent être générées à la volée ou stockées dans un dossier `media/invoices/`.

### Project Structure Notes

- La logique de génération résidera dans `apps/sales/services.py` ou une nouvelle application `communications`.
- Utiliser des polices standard ou intégrées pour éviter les problèmes de rendu.

### References

- [Source: _bmad-output/planning-artifacts/prd.md#FR6]
- [Source: _bmad-output/planning-artifacts/architecture.md#PDF Generation & Communications]

## Dev Agent Record

### Agent Model Used

Gemini 2.0 Flash

### Debug Log References

- Installation de `weasyprint` et `django-weasyprint` via Poetry réussie.
- Template `invoice_pdf.html` testé pour les types SALE et QUOTE.

### Completion Notes List

- Intégration de WeasyPrint pour un rendu PDF professionnel.
- Template HTML/CSS sur mesure pour Ets Sylla Madjou.
- Vue de téléchargement direct ajoutée à l'historique des ventes.

### File List

- `erp_sylla/erp_sylla/templates/sales/invoice_pdf.html` (Créé)
- `erp_sylla/erp_sylla/apps/sales/views.py` (Modifié)
- `erp_sylla/erp_sylla/apps/sales/urls.py` (Modifié)
- `erp_sylla/erp_sylla/templates/sales/success.html` (Modifié)
- `erp_sylla/erp_sylla/templates/sales/sale_detail.html` (Modifié)
- `erp_sylla/pyproject.toml` (Modifié)
- `erp_sylla/poetry.lock` (Modifié)
