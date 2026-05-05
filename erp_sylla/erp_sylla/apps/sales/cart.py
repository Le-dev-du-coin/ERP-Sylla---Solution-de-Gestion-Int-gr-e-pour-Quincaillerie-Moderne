from erp_sylla.apps.inventory.models import Product

class Basket:
    """
    Gère le panier d'achat stocké en session.
    Format du panier en session :
    {
        "product_id_UNIT": {
            "quantity": int,
            "unit": str, (PIECE or CARTON)
            "price": int,
            "name": str
        }
    }
    """
    def __init__(self, request):
        self.session = request.session
        basket = self.session.get("basket")
        if not basket:
            basket = self.session["basket"] = {}
        self.basket = basket

    def add(self, product, unit="PIECE", quantity=1):
        """Ajoute un produit au panier ou incrémente sa quantité."""
        product_id = str(product.id)
        # On crée une clé unique par couple produit/unité
        key = f"{product_id}_{unit}"
        
        price = product.sale_price_piece if unit == "PIECE" else product.sale_price_carton

        if key not in self.basket:
            # On calcule le prix d'achat équivalent pour l'unité choisie
            purchase_price_unit = product.purchase_price
            if unit == "CARTON":
                purchase_price_unit = product.purchase_price * product.conversion_factor

            self.basket[key] = {
                "product_id": product.id,
                "name": product.name,
                "price": price,
                "purchase_price": purchase_price_unit,
                "unit": unit,
                "quantity": 0,
                "sku": product.sku
            }
        
        self.basket[key]["quantity"] += quantity
        self.save()

    def remove(self, product_id, unit):
        """Supprime une ligne spécifique du panier."""
        key = f"{product_id}_{unit}"
        if key in self.basket:
            del self.basket[key]
            self.save()

    def update(self, product_id, unit, quantity=None, price=None):
        """Met à jour la quantité ou le prix d'une ligne."""
        key = f"{product_id}_{unit}"
        if key in self.basket:
            if quantity is not None:
                if quantity <= 0:
                    del self.basket[key]
                else:
                    self.basket[key]["quantity"] = quantity
            
            if price is not None:
                try:
                    self.basket[key]["price"] = int(price)
                except (ValueError, TypeError):
                    pass
            
            self.save()

    def clear(self):
        """Vide le panier."""
        del self.session["basket"]
        self.save()

    def save(self):
        self.session.modified = True

    @property
    def total_price(self):
        """Calcule le prix total du panier."""
        return sum(item["price"] * item["quantity"] for item in self.basket.values())

    @property
    def total_items(self):
        """Nombre total d'articles (lignes)."""
        return len(self.basket)

    def __iter__(self):
        """Permet d'itérer sur les items du panier dans les templates."""
        for key, item in self.basket.items():
            # On ajoute la clé pour faciliter les actions HTMX
            item["key"] = key
            item["total_line"] = item["price"] * item["quantity"]
            yield item
