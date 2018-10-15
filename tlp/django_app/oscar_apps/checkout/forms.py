from oscar.apps.checkout import forms as checkout_forms
from oscar.apps.order.models import ShippingAddress
from oscar.apps.address import forms as current_address
from django import forms


class ShippingAddressForm(checkout_forms.ShippingAddressForm):
    class Meta:
        model = ShippingAddress
        fields = [
            'first_name', 'last_name',
            'line1', 'line4', 'postcode', 'country',
            'phone_number', 'notes',
        ]
        labels = {
            'first_name': checkout_forms._("Ad"),
            'last_name': checkout_forms._("Soyad"),
            'line1': checkout_forms._("Ünvan"),
            'line4': checkout_forms._("Şəhər"),
            'postcode': checkout_forms._("Poçt index"),
            'country': checkout_forms._("Ölkə"),
            'phone_number': checkout_forms._("Telefon nömrəsi"),
            'notes': checkout_forms._("Qeydlər"),
        }


class UserAddressForm(current_address.UserAddressForm):
    class Meta:
        model = current_address.UserAddress
        fields = [
            'first_name', 'last_name',
            'line1', 'line4', 'postcode', 'country',
            'phone_number', 'notes',
        ]


class GatewayForm(checkout_forms.GatewayForm):
    username = forms.EmailField(label=checkout_forms._("Mənim email addresim"))
    GUEST, NEW, EXISTING = 'anonymous', 'new', 'existing'
    CHOICES = (
        (GUEST, checkout_forms._('Qeydiyyatsız email ilə ödəniş etmək')),
        (NEW, checkout_forms._('Yeni hesab yaratmaq')),
        (EXISTING, checkout_forms._('Hesaba daxil olmaq'))
    )
    options = forms.ChoiceField(widget=forms.widgets.RadioSelect,
                                choices=CHOICES, initial=GUEST)