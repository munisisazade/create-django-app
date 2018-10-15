from oscar.apps.checkout import app as checkout_app
from .views import ShippingAddressView, UserAddressUpdateView, \
    IndexView, PaymentDetailsView, ThankYouView


class CheckoutAppOscar(checkout_app.CheckoutApplication):
    index_view = IndexView
    shipping_address_view = ShippingAddressView
    user_address_update_view = UserAddressUpdateView
    payment_details_view = PaymentDetailsView
    thankyou_view = ThankYouView


application = CheckoutAppOscar()
