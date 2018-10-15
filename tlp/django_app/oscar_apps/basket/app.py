from oscar.apps.basket import app as basket_app
from .views import BasketAddView


class OscarBasketApplication(basket_app.BasketApplication):
    add_view = BasketAddView


application = OscarBasketApplication()
