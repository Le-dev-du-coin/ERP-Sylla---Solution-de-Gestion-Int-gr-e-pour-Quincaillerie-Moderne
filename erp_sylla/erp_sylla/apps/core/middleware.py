
class ProxyIPMiddleware:
    """
    Middleware pour s'assurer que REMOTE_ADDR est correctement renseigné 
    derrière un reverse proxy, surtout quand celui-ci arrive vide.
    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Si REMOTE_ADDR est vide ou absent, on essaie de le peupler via X-Forwarded-For
        if not request.META.get('REMOTE_ADDR'):
            x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
            if x_forwarded_for:
                # On prend la première IP de la liste (l'IP réelle du client)
                ip = x_forwarded_for.split(',')[0].strip()
                request.META['REMOTE_ADDR'] = ip
            else:
                # Fallback de sécurité pour éviter que ce soit vide
                request.META['REMOTE_ADDR'] = '127.0.0.1'
        
        return self.get_response(request)
