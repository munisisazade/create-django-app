from oscar.apps.promotions import views as promotions_views
from oscar_apps.catalogue.models import Product
from django.db.models import Q
# from bucket.models import BaseSlider, InstagramImage, Composition
# from bucket.tasks import instagram_task


class IndexView(promotions_views.HomeView):
    template_name = 'promotions/home.html'

    def get_context_data(self, **kwargs):
        context = super(IndexView, self).get_context_data(**kwargs)
        # context['sliders'] = BaseSlider.objects.filter(status=True)
        # context['new_products'] = Product.objects.filter(~Q(structure="child"))[:16]
        # context['compositions'] = Composition.objects.filter(status=True)[:2]
        # context['best_seller_products'] = Product.objects.filter(~Q(structure="child"), Q(best_seller=True))
        # context['instagram_images'] = InstagramImage.objects.all().order_by('-id')[:6]
        # context['instagram_cover'] = InstagramImage.objects.all().order_by('-id')[6:7]
        # instagram_task.delay()
        return context