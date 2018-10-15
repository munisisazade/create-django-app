from oscar.apps.dashboard.pages import app as pages_app_admin
from .views import PageUpdateView, PageCreateView


class PagesApplication(pages_app_admin.FlatPageManagementApplication):
    create_view = PageCreateView
    update_view = PageUpdateView


application = PagesApplication()
