from oscar.apps.basket import views as basket_views
from django.http import JsonResponse


class BasketAddView(basket_views.BasketAddView):
    def form_valid(self, form):
        offers_before = self.request.basket.applied_offers()

        self.request.basket.add_product(
            form.product, form.cleaned_data['quantity'],
            form.cleaned_options())

        basket_views.messages.success(self.request, self.get_success_message(form),
                                      extra_tags='safe noicon')

        # Check for additional offer messages
        basket_views.BasketMessageGenerator().apply_messages(self.request, offers_before)

        # Send signal for basket addition
        self.add_signal.send(
            sender=self, product=form.product, user=self.request.user,
            request=self.request)
        line_id = self.request.basket.all_lines().last().id
        # if form.product.is_parent:
        attributes = form.product.attribute_values.all()
        _attributes = {}
        for av in attributes:
            if av.attribute.code == 'color' or av.attribute.code == 'type':
                if hasattr(av.value, "option"):
                    _attributes[av.attribute.code] = av.value.option
                else:
                    pass

        return JsonResponse({
            "line_id": line_id,
            "attributes": _attributes,
            "quantity": form.cleaned_data['quantity']
        })
        # else:
        #     return JsonResponse({"line_id": line_id})
