from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('categorias/', views.categorias, name='categorias'),
    path('pesquisa/', views.pesquisa, name='pesquisa'),
    path('produto/', views.produto, name='produto'),
]