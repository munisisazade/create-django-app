from oscar.apps.dashboard.pages import forms as page_forms_admin
from ckeditor_uploader.widgets import CKEditorUploadingWidget


class PageUpdateForm(page_forms_admin.PageUpdateForm):
    class Meta:
        model = page_forms_admin.FlatPage
        fields = ('title_az', 'title_en', 'title_ru',
                  'url', 'content_az', 'content_en',
                  'content_ru')
        widgets = {
            'content_az': CKEditorUploadingWidget(),
            'content_en': CKEditorUploadingWidget(),
            'content_ru': CKEditorUploadingWidget()
        }
