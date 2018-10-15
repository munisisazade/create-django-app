from oscar.apps.customer import forms as customer_form
from oscar.apps.address import forms as address_form


class UserAddressForm(address_form.UserAddressForm):
    class Meta:
        model = address_form.UserAddress
        fields = [
            'first_name', 'last_name',
            'line1', 'line4', 'postcode', 'country',
            'phone_number', 'notes',
        ]
