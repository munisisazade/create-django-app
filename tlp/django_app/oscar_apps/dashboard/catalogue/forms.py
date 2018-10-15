from oscar.apps.dashboard.catalogue import forms as catalogue_admin_forms
from ckeditor_uploader.widgets import CKEditorUploadingWidget


class ProductAttributesForm(catalogue_admin_forms.ProductAttributesForm):
    class Meta:
        model = catalogue_admin_forms.ProductAttribute
        fields = ["name_az", "name_en", "name_ru", "code", "type", "option_group", "required"]


class ProductForm(catalogue_admin_forms.ProductForm):
    class Meta:
        model = catalogue_admin_forms.Product
        fields = [
            'title_az', 'title_en', 'title_ru', 'upc', 'description_az', 'description_en', 'description_ru',
            'is_discountable', 'best_seller', 'structure']
        widgets = {
            'structure': catalogue_admin_forms.forms.Select(),
            'description_az': CKEditorUploadingWidget(),
            'description_en': CKEditorUploadingWidget(),
            'description_ru': CKEditorUploadingWidget()
        }


CategoryForm = catalogue_admin_forms.movenodeform_factory(
    catalogue_admin_forms.Category,
    fields=['name_az', 'name_en', 'name_ru', 'description_az',
            'description_en', 'description_ru', 'image'],
    widgets={
        'description_az': CKEditorUploadingWidget(),
        'description_en': CKEditorUploadingWidget(),
        'description_ru': CKEditorUploadingWidget()
    }
)
