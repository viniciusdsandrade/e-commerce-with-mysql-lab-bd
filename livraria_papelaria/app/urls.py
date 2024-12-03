from django.urls import path
from . import views
from . import views_carrinho
from . import views_lista_de_desejos
from . import views_enderecos
from . import views_formas_pagamento
from . import views_compra

urlpatterns = [
    path('', views.home, name='home'),
    path('categorias/', views.categorias, name='categorias'),
    path('pesquisa/', views.pesquisa, name='pesquisa'),
    path('produto/<int:id_produto>', views.produto, name='produto'),
    path('conta', views.conta, name='conta'),

    path('carrinho/', views_carrinho.carrinho, name='carrinho'),
    path('carrinho/<int:id_produto>', views_carrinho.carrinho_adicionar, name='carrinho_adicionar'),
    path('carrinho/remover/<int:id_produto>', views_carrinho.carrinho_remover, name='carrinho_remover'),
    path('carrinho/esvaziar', views_carrinho.carrinho_esvaziar, name='carrinho_esvaziar'),
    path('carrinho/_qtd/<int:id_produto>/<int:id_carrinho>/<int:quantidade>', views_carrinho.quantidade_produto, name='quantidade_produto'),

    path('lista_de_desejos/', views_lista_de_desejos.lista_de_desejos, name='lista_de_desejos'),
    path('lista_de_desejos/<int:id_produto>', views_lista_de_desejos.lista_de_desejos_adicionar, name='lista_de_desejos_adicionar'),
    path('lista_de_desejos/remover/<int:id_produto>', views_lista_de_desejos.lista_de_desejos_remover, name='lista_de_desejos_remover'),

    path('cupons/', views.cupons, name='cupons'),

    path('comprar/<int:id_produto>/', views_compra.comprar_agora, name='comprar_agora'),
    path('comprar/<int:id_produto>/<int:id_carrinho>', views_compra.comprar_agora_carrinho, name='comprar_agora_carrinho'),

    path('compra/endereco', views.compra_endereco, name='compra_endereco'),
    path('compra/transportadora', views.compra_transportadora, name='compra_transportadora'),
    path('compra/pagamento', views.compra_pagamento, name='compra_pagamento'),

    path('historico_compras/', views.historico_compras, name='historico_compras'),

    path('enderecos/', views_enderecos.enderecos, name='enderecos'),
    path('enderecos/criar', views_enderecos.enderecos_criar, name='enderecos_criar'),
    path('enderecos/editar/<int:id_endereco>', views_enderecos.enderecos_editar, name='enderecos_editar'),
    path('enderecos/remover/<int:id_endereco>', views_enderecos.enderecos_remover, name='enderecos_remover'),

    path('formas_pagamento/', views_formas_pagamento.formas_pagamento, name='formas_pagamento'),
    path('formas_pagamento/<str:tipo_pagamento>', views_formas_pagamento.formas_pagamento_criar, name='formas_pagamento_criar'),
    path('formas_pagamento/remover/<str:tipo_pagamento>/<int:id_pagamento>', views_formas_pagamento.formas_pagamento_remover, name="formas_pagamento_remover"),

    path('entrar/', views.entrar, name='entrar'),
    path('cadastrar/', views.cadastrar, name='cadastrar'),
    path('sair/', views.sair, name='sair'),
]
