from oscar.apps.promotions import app as promotions_app
from .views import IndexView


class PromotionsApp(promotions_app.PromotionsApplication):
    name = 'promotions'

    home_view = IndexView


application = PromotionsApp()