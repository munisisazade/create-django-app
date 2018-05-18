"""#{PROJ_NAME} URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls.i18n import i18n_patterns  # for url translation
from oscar.app import application # oscar applications urls here


urlpatterns = [
    url(r'^labmin/', admin.site.urls),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

urlpatterns += i18n_patterns(
    url(r'^', include("#{APP_NAME}.urls")),
    url(r'^', application.urls),
    url(r'^page/', include('django.contrib.flatpages.urls')),
)

# in development django built-in server serves static and media content
if not settings.PROD:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
# This is change default admin panel Headers and titles
admin.site.site_header = '#{PROJ_NAME} Admin'
admin.site.site_title = '#{PROJ_NAME} Administration'
admin.site.index_title = '#{PROJ_NAME} Administration'
