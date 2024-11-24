from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('categorias/', views.categorias, name='categorias'),
    path('pesquisa/', views.pesquisa, name='pesquisa'),
    path('produto/', views.produto, name='produto'),
    path('usuario/conta', views.conta, name='conta'),
    path('usuario/carrinho/', views.carrinho, name='carrinho'),
    path('usuario/lista_de_desejos/', views.lista_de_desejos, name='lista_de_desejos'),
    path('usuario/cupons/', views.cupons, name='cupons'),
    path('usuario/compra/endereco', views.compra_endereco, name='compra_endereco'),
    path('usuario/compra/transportadora', views.compra_transportadora, name='compra_transportadora'),
    path('usuario/compra/pagamento', views.compra_pagamento, name='compra_pagamento'),
    path('usuario/historico_compras/', views.historico_compras, name='historico_compras'),
    path('usuario/enderecos/', views.enderecos, name='enderecos'),
    path('usuario/enderecos/criar', views.enderecos_criar, name='enderecos_criar'),
    path('usuario/enderecos/editar', views.enderecos_editar, name='enderecos_editar'),
    path('usuario/formas_pagamento/', views.formas_pagamento, name='formas_pagamento'),
    path('usuario/formas_pagamento_criar/', views.formas_pagamento_criar, name='formas_pagamento_criar'),
    path('entrar/', views.entrar, name='entrar'),
    path('cadastrar/', views.cadastrar, name='cadastrar'),
    path('sair/', views.sair, name='sair'),
]