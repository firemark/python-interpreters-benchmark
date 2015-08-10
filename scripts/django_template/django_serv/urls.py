from django.conf.urls import include, url
from views import hello_world

urlpatterns = [
    url(r'^', hello_world),
]
