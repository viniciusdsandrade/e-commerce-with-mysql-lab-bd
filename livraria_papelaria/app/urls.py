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
    path('usuario/lista_de_desejos/<int:id_produto>', views.lista_de_desejos_adicionar, name='lista_de_desejos_adicionar'),
    path('usuario/lista_de_desejos/<int:id_produto>/remover', views.lista_de_desejos_remover, name='lista_de_desejos_remover'),
    path('usuario/cupons/', views.cupons, name='cupons'),
    path('usuario/compra/endereco', views.compra_endereco, name='compra_endereco'),
    path('usuario/compra/transportadora', views.compra_transportadora, name='compra_transportadora'),
    path('usuario/compra/pagamento', views.compra_pagamento, name='compra_pagamento'),
    path('usuario/historico_compras/', views.historico_compras, name='historico_compras'),
    path('usuario/enderecos/', views.enderecos, name='enderecos'),
    path('usuario/enderecos/criar', views.enderecos_criar, name='enderecos_criar'),
    path('usuario/enderecos/editar/<int:id_endereco>', views.enderecos_editar, name='enderecos_editar'),
    path('usuario/enderecos/remover/<int:id_endereco>', views.enderecos_remover, name='enderecos_remover'),
    path('usuario/formas_pagamento/', views.formas_pagamento, name='formas_pagamento'),
    path('usuario/formas_pagamento/criar/<str:tipo_pagamento>', views.formas_pagamento_criar, name='formas_pagamento_criar'),
    path('usuario/formas_pagamento/remover/<str:tipo_pagamento>/<int:id_pagamento>', views.formas_pagamento_remover, name="formas_pagamento_remover"),
    path('entrar/', views.entrar, name='entrar'),
    path('cadastrar/', views.cadastrar, name='cadastrar'),
    path('sair/', views.sair, name='sair'),
]
