from oscar.apps.customer import views as customer_views
from oscar.apps.wishlists.models import WishList
from .forms import UserAddressForm


class CustomerLoginView(customer_views.AccountAuthView):
    def get_registration_success_message(self, form):
        user = form.save(commit=False)
        WishList.objects.create(
            owner=user,
            name="Arzu siyahısı",
            visibility='Public'
        )
        return customer_views._("Qeydiyyat üçün təşəkkürlər")


class AddressCreateView(customer_views.AddressCreateView):
    form_class = UserAddressForm


class AddressUpdateView(customer_views.AddressUpdateView):
    form_class = UserAddressForm


class AnonymousOrderDetailView(customer_views.AnonymousOrderDetailView):
    pass