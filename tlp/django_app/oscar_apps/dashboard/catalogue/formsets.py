from oscar.apps.dashboard.catalogue import formsets as catalogue_admin_formset
from .forms import ProductAttributesForm

ProductAttributesFormSet = catalogue_admin_formset.inlineformset_factory(catalogue_admin_formset.ProductClass,
                                                                         catalogue_admin_formset.ProductAttribute,
                                                                         form=ProductAttributesForm,
                                                                         extra=15)