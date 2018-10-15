# from django.conf import settings
# from oscar.apps.checkout import views as checkout_views
# from oscar.apps.payment import exceptions
# from django.core.mail import send_mail
#
# from bucket.models import AdminEmails
# from .forms import ShippingAddressForm, UserAddressForm, GatewayForm
#
# from pasha_payment.pashapay import PashaPay
# from pasha_payment.utils import get_client_ip
#
# import logging
#
# # Get an instance of a logger
# logr = logging.getLogger(__name__)
#
#
# class ShippingAddressView(checkout_views.ShippingAddressView):
#     form_class = ShippingAddressForm
#
#
# class UserAddressUpdateView(checkout_views.UserAddressUpdateView):
#     form_class = UserAddressForm
#
#
# class IndexView(checkout_views.IndexView):
#     form_class = GatewayForm
#
#
# # @method_decorator(csrf_exempt, name='dispatch')
# class PaymentDetailsView(checkout_views.PaymentDetailsView):
#     preview = True
#
#     def handle_payment(self, order_number, total_incl_tax, **kwargs):
#         # Payment requires a redirect so we raise a RedirectRequired exception
#         # and oscar's checkout flow will handle the rest.
#         payment = PashaPay()
#         url = payment.redirect_to_pay(
#             amount=total_incl_tax.incl_tax,
#             description='One-off bill for order #%s' % order_number,
#             client_ip=get_client_ip(self.request),
#         )
#         self.add_payment_event('pre-auth', total_incl_tax.incl_tax)
#
#         raise exceptions.RedirectRequired(url)
#
#
# # =========
# # Thank you
# # =========
#
#
# class ThankYouView(checkout_views.ThankYouView):
#
#     def get_context_data(self, *args, **kwargs):
#         ctx = super(ThankYouView, self).get_context_data(*args, **kwargs)
#         # Remember whether this view has been loaded.
#         # Only send tracking information on the first load.
#         self.send_message_to_admin(ctx['order'])
#         key = 'order_{}_thankyou_viewed'.format(ctx['order'].pk)
#         if not self.request.session.get(key, False):
#             self.request.session[key] = True
#             ctx['send_analytics_event'] = True
#         else:
#             ctx['send_analytics_event'] = False
#
#         return ctx
#
#     def send_message_to_admin(self, order):
#         emails = AdminEmails.objects.filter(status=True)
#         message = "{} nömrəli sifarışiniz var. Qiyməti: {} Link: {}".format(
#             order.number,
#             order.total_incl_tax,
#             "https://" + self.request.get_host() + "/ru/dashboard/orders/%s/" % order.number
#         )
#         if emails.last():
#             for email in emails:
#                 if email.status:
#                     send_mail("{} nömrəli yeni sifarişiniz var".format(order.number),
#                               message,
#                               settings.EMAIL_HOST_USER,
#                               [email.email]
#                     )
#         return "Messages successfuly send"
#
