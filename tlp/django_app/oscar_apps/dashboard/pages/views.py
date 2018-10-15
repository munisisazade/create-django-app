from oscar.apps.dashboard.pages import views as page_views_admin
from .forms import PageUpdateForm


class PageCreateView(page_views_admin.PageCreateView):
    form_class = PageUpdateForm


class PageUpdateView(page_views_admin.PageUpdateView):
    form_class = PageUpdateForm
