from django.urls import path
from . import views

urlpatterns = [
    path('', views.teste, name='teste'),
    path('produtos', views.produtos, name='produtos'),
]