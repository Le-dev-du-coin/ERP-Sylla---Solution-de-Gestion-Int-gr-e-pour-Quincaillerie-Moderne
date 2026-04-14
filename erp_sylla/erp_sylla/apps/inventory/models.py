from django.db import models
from django.utils.translation import gettext_lazy as _
from simple_history.models import HistoricalRecords


class Product(models.Model):
    """
    Représente un article du catalogue de la quincaillerie.
    Gère les prix en F CFA (entiers) et la conversion Carton -> Pièce.
    """
    name = models.CharField(_("Désignation"), max_length=255)
    description = models.TextField(_("Description"), blank=True)
    sku = models.CharField(_("SKU / Réf interne"), max_length=50, unique=True, blank=True)
    barcode = models.CharField(_("Code Barre"), max_length=100, blank=True, null=True, unique=True)
    
    # Prix en F CFA (Entiers)
    purchase_price = models.PositiveIntegerField(_("Prix d'achat"), default=0)
    sale_price_piece = models.PositiveIntegerField(_("Prix de vente (Pièce)"), default=0)
    sale_price_carton = models.PositiveIntegerField(_("Prix de vente (Carton)"), default=0)
    
    # Logique de conversion
    conversion_factor = models.PositiveIntegerField(
        _("Facteur de conversion"), 
        help_text=_("Nombre de pièces contenues dans un carton."),
        default=1
    )
    
    low_stock_threshold = models.PositiveIntegerField(
        _("Seuil d'alerte global (pièces)"),
        default=5
    )
    
    alert_threshold_cartons = models.PositiveIntegerField(
        _("Alerte Stock (Cartons)"),
        default=0,
        blank=True,
        null=True,
        help_text=_("Déclencher une alerte s'il reste moins de X cartons.")
    )

    alert_threshold_pieces = models.PositiveIntegerField(
        _("Alerte Stock (Pièces)"),
        default=5,
        blank=True,
        null=True,
        help_text=_("Déclencher une alerte s'il reste moins de X pièces.")
    )
    
    is_active = models.BooleanField(_("Actif"), default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Article")
        verbose_name_plural = _("Articles")
        ordering = ["name"]

    def save(self, *args, **kwargs):
        # Calcul automatique du seuil global en pièces (gestion des Nones)
        cartons = self.alert_threshold_cartons or 0
        pieces = self.alert_threshold_pieces or 0
        self.low_stock_threshold = (cartons * self.conversion_factor) + pieces
        
        if self.pk:
            # On récupère l'ancienne version pour comparer
            old_instance = Product.objects.get(pk=self.pk)
            reasons = []
            
            # Détection des changements pour le message d'historique
            if old_instance.name != self.name:
                reasons.append(f"Nom changé: {old_instance.name} -> {self.name}")
            if old_instance.purchase_price != self.purchase_price:
                reasons.append(f"Prix achat: {old_instance.purchase_price} -> {self.purchase_price}")
            if old_instance.sale_price_piece != self.sale_price_piece:
                reasons.append(f"Prix pièce: {old_instance.sale_price_piece} -> {self.sale_price_piece}")
            
            # On assigne le message à l'historique
            self._history_change_reason = ", ".join(reasons) if reasons else "Mise à jour des informations"
            
            # Logique SKU
            if old_instance.name != self.name and old_instance.sku == self.sku:
                import uuid
                from django.utils.text import slugify
                suffix = str(uuid.uuid4())[:4].upper()
                self.sku = f"{slugify(self.name).upper()}-{suffix}"
        else:
            # Nouveau produit
            self._history_change_reason = "Création initiale de l'article"
            if not self.sku:
                import uuid
                from django.utils.text import slugify
                suffix = str(uuid.uuid4())[:4].upper()
                self.sku = f"{slugify(self.name).upper()}-{suffix}"
            
        super().save(*args, **kwargs)


    def __str__(self):
        return f"{self.name} ({self.sku})"

    @property
    def total_stock(self):
        """Calcule le stock total disponible (en pièces)."""
        from django.db.models import Sum
        result = self.stock_transactions.aggregate(total=Sum("quantity"))["total"]
        return result or 0

    @property
    def stock_in_cartons(self):
        """Retourne un tuple (nb_cartons, nb_pieces_restantes)."""
        total = self.total_stock
        cartons = total // self.conversion_factor
        pieces = total % self.conversion_factor
        return cartons, pieces

    @property
    def formatted_stock(self):
        """Retourne une chaîne lisible du stock global."""
        return self.get_formatted_stock_for_warehouse()

    def get_formatted_stock_for_warehouse(self, warehouse=None):
        """Retourne une chaîne lisible du stock, optionnellement filtrée par entrepôt."""
        from django.db.models import Sum
        if warehouse:
            total = self.stock_transactions.filter(warehouse=warehouse).aggregate(total=Sum("quantity"))["total"] or 0
        else:
            total = self.total_stock
            
        cartons = total // self.conversion_factor
        pieces = total % self.conversion_factor
        
        parts = []
        if cartons > 0:
            parts.append(f"{cartons} carton{'s' if cartons > 1 else ''}")
        if pieces > 0 or not parts:
            parts.append(f"{pieces} pièce{'s' if pieces > 1 else ''}")
        return " & ".join(parts)




class Warehouse(models.Model):
    """Représente un lieu de stockage (Magasin, Dépôt, etc.)."""
    name = models.CharField(_("Nom de l'entrepôt"), max_length=255)
    location = models.CharField(_("Emplacement / Adresse"), max_length=255, blank=True)
    is_active = models.BooleanField(_("Actif"), default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Entrepôt")
        verbose_name_plural = _("Entrepôts")

    def __str__(self):
        return self.name

    @property
    def total_stock_value(self):
        """Calcule la valeur totale du stock (au prix d'achat) en une seule requête SQL."""
        from django.db.models import Sum, F
        result = self.stock_transactions.aggregate(
            total=Sum(F("quantity") * F("product__purchase_price"))
        )["total"]
        return result or 0

    @property
    def products_count(self):
        """Nombre de références distinctes en stock."""
        return self.stock_transactions.values('product').distinct().count()



class StockTransaction(models.Model):
    """
    Enregistre chaque mouvement de stock (Ledger).
    Toutes les quantités sont stockées en UNITES (PIECES) en base.
    """
    class Types(models.TextChoices):
        ENTREE = "IN", _("Entrée de stock")
        SORTIE = "OUT", _("Sortie de stock")
        TRANSFERT = "TRANS", _("Transfert entre entrepôts")
        AJUSTEMENT = "ADJ", _("Ajustement d'inventaire")

    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="stock_transactions")
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE, related_name="stock_transactions")
    # Pour les transferts
    to_warehouse = models.ForeignKey(
        Warehouse, 
        on_delete=models.CASCADE, 
        related_name="incoming_transfers", 
        null=True, 
        blank=True,
        verbose_name=_("Entrepôt cible (si transfert)")
    )
    
    quantity = models.IntegerField(_("Quantité"), help_text=_("Quantité en pièces."))
    type = models.CharField(_("Type de mouvement"), max_length=10, choices=Types.choices)
    notes = models.TextField(_("Notes / Motif"), blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    history = HistoricalRecords()

    class Meta:
        verbose_name = _("Mouvement de stock")
        verbose_name_plural = _("Mouvements de stock")
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.get_type_display()} : {self.quantity} x {self.product.name}"

    def save(self, *args, **kwargs):
        if not self.pk:
            self._history_change_reason = f"Enregistrement {self.get_type_display()} ({self.quantity} pcs)"
        else:
            self._history_change_reason = f"Modification du mouvement"
        super().save(*args, **kwargs)



