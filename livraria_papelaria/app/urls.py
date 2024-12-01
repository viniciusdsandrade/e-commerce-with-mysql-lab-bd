from django.urls import path
from . import views
from . import views_carrinho
from . import views_lista_de_desejos
from . import views_enderecos
from . import views_formas_pagamento

urlpatterns = [
    path('', views.home, name='home'),
    path('categorias/', views.categorias, name='categorias'),
    path('pesquisa/', views.pesquisa, name='pesquisa'),
    path('produto/', views.produto, name='produto'),
    path('usuario/conta', views.conta, name='conta'),

    path('usuario/carrinho/', views_carrinho.carrinho, name='carrinho'),
    path('usuario/carrinho/<int:id_produto>', views_carrinho.carrinho_adicionar, name='carrinho_adicionar'),
    path('usuario/carrinho/remover/<int:id_produto>', views_carrinho.carrinho_remover, name='carrinho_remover'),

    path('usuario/lista_de_desejos/', views_lista_de_desejos.lista_de_desejos, name='lista_de_desejos'),
    path('usuario/lista_de_desejos/<int:id_produto>', views_lista_de_desejos.lista_de_desejos_adicionar, name='lista_de_desejos_adicionar'),
    path('usuario/lista_de_desejos/remover/<int:id_produto>', views_lista_de_desejos.lista_de_desejos_remover, name='lista_de_desejos_remover'),

    path('usuario/cupons/', views.cupons, name='cupons'),

    path('usuario/compra/endereco', views.compra_endereco, name='compra_endereco'),
    path('usuario/compra/transportadora', views.compra_transportadora, name='compra_transportadora'),
    path('usuario/compra/pagamento', views.compra_pagamento, name='compra_pagamento'),

    path('usuario/historico_compras/', views.historico_compras, name='historico_compras'),

    path('usuario/enderecos/', views_enderecos.enderecos, name='enderecos'),
    path('usuario/enderecos/criar', views_enderecos.enderecos_criar, name='enderecos_criar'),
    path('usuario/enderecos/editar/<int:id_endereco>', views_enderecos.enderecos_editar, name='enderecos_editar'),
    path('usuario/enderecos/remover/<int:id_endereco>', views_enderecos.enderecos_remover, name='enderecos_remover'),

    path('usuario/formas_pagamento/', views_formas_pagamento.formas_pagamento, name='formas_pagamento'),
    path('usuario/formas_pagamento/<str:tipo_pagamento>', views_formas_pagamento.formas_pagamento_criar, name='formas_pagamento_criar'),
    path('usuario/formas_pagamento/remover/<str:tipo_pagamento>/<int:id_pagamento>', views_formas_pagamento.formas_pagamento_remover, name="formas_pagamento_remover"),

    path('entrar/', views.entrar, name='entrar'),
    path('cadastrar/', views.cadastrar, name='cadastrar'),
    path('sair/', views.sair, name='sair'),
]
