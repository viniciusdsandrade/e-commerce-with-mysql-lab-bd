from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('categorias/', views.categorias, name='categorias'),
    path('pesquisa/', views.pesquisa, name='pesquisa'),
    path('produto/', views.produto, name='produto'),
    path('usuario/conta', views.conta, name='conta'),
    path('usuario/carrinho/', views.carrinho, name='carrinho'),
    path('usuario/lista_de_desejos/', views.lista_de_desejos, name='lista_de_desejos'),
    path('usuario/cupons/', views.cupons, name='cupons'),
]