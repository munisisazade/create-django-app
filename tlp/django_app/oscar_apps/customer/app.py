from oscar.apps.customer import app as customer_app
from .views import CustomerLoginView, AddressCreateView, AddressUpdateView, \
    AnonymousOrderDetailView


class CustomerOscarApplication(customer_app.CustomerApplication):
    login_view = CustomerLoginView
    address_create_view = AddressCreateView
    address_update_view = AddressUpdateView
    anon_order_detail_view = AnonymousOrderDetailView


application = CustomerOscarApplication()
