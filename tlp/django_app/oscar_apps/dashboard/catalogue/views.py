from oscar.apps.dashboard.catalogue import views as catalogue_admin_views
from .formsets import ProductAttributesFormSet
from .forms import ProductForm, CategoryForm


class ProductClassCreateView(catalogue_admin_views.ProductClassCreateView):
    product_attributes_formset = ProductAttributesFormSet


class ProductClassUpdateView(catalogue_admin_views.ProductClassUpdateView):
    product_attributes_formset = ProductAttributesFormSet


class ProductCreateUpdateView(catalogue_admin_views.ProductCreateUpdateView):
    form_class = ProductForm


class CategoryCreateView(catalogue_admin_views.CategoryCreateView):
    form_class = CategoryForm


class CategoryUpdateView(catalogue_admin_views.CategoryUpdateView):
    form_class = CategoryForm
