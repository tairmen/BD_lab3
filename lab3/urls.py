from django.conf.urls import include, url
from django.contrib import admin
from . import views

urlpatterns = [
	url(r'^$', views.index),
	url(r'^travels/$', views.main_list),
	url(r'^travels/add/$', views.add_travels),
	url(r'^travels/delete/$', views.delete_travels),
	url(r'^travels/trigger/$', views.trigger),
	url(r'^(?P<secondary_name>cities)/$', views.secondary_list),
	url(r'^(?P<secondary_name>cities)/upload/$', views.secondary_upload),
	url(r'^admin/', include(admin.site.urls)),
]
