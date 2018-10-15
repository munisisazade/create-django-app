from oscar.apps.dashboard.catalogue import app as catalogue_admin_app
from .views import ProductClassCreateView, ProductClassUpdateView, ProductCreateUpdateView, \
    CategoryCreateView, CategoryUpdateView


class CatalogueAdminApp(catalogue_admin_app.CatalogueApplication):
    product_class_create_view = ProductClassCreateView
    product_class_update_view = ProductClassUpdateView
    product_createupdate_view = ProductCreateUpdateView
    category_create_view = CategoryCreateView
    category_update_view = CategoryUpdateView


application = CatalogueAdminApp()
