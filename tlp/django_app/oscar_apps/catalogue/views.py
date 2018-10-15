# from oscar.apps.catalogue import views as catalogue_views
# from oscar.apps.partner.strategy import Selector
# from django.shortcuts import render
# from django.http import JsonResponse
# from bucket.options.debug import Logger
#
# mslog = Logger(file="test.log")
#
#
# class ProductCategoryView(catalogue_views.ProductCategoryView):
#     ajax_template_name = 'catalogue/partials/money_range_product.html'
#
#     def get(self, request, *args, **kwargs):
#         # Fetch the category; return 404 or redirect as needed
#         self.category = self.get_category()
#         mslog.debug(self.category)
#         potential_redirect = self.redirect_if_necessary(
#             request.path, self.category)
#         mslog.debug(potential_redirect)
#         if potential_redirect is not None:
#             return potential_redirect
#
#         try:
#             self.search_handler = self.get_search_handler(
#                 request.GET, request.get_full_path(), self.get_categories())
#             mslog.debug(self.search_handler.get_queryset())
#         except catalogue_views.InvalidPage:
#             catalogue_views.messages.error(request, catalogue_views._('The given page number was invalid.'))
#             return catalogue_views.redirect(self.category.get_absolute_url())
#         if self.request.is_ajax():
#             return render(self.request, self.ajax_template_name, {'product':self.search_handler.get_queryset()})
#         return super(ProductCategoryView, self).get(request, *args, **kwargs)
#
#     def handle_product_price_range(self, queryset, min, max):
#         selector = Selector()
#         strategy = selector.strategy()
#         pass
