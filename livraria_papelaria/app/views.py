from django.shortcuts import render, redirect
from .models import Endereco, Pix, Cartao
from django.db.models import ForeignKey
from .forms import EnderecoForm, PixForm, CartaoForm

def home(request):
    return render(request, 'home.html')


def pesquisa(request):
    return render(request, 'pesquisa.html')


def categorias(request):
    return render(request, 'categorias.html')


def produto(request):
    return render(request, 'produto.html')


def conta(request):
    return render(request, 'conta.html')


def lista_de_desejos(request):
    return render(request, 'lista_de_desejos.html')


def carrinho(request):
    return render(request, 'carrinho.html')


def cupons(request):
    return render(request, 'cupons.html')


def compra_endereco(request):
    formulario = EnderecoForm()
    return render(request, 'compra_endereco.html', {'formulario': formulario})


def compra_transportadora(request):
    return render(request, 'compra_transportadora.html')


def compra_pagamento(request):
    formulario_pix = PixForm()
    formulario_cartao = CartaoForm()
    return render(request, 'compra_pagamento.html', {'formulario_pix': formulario_pix, 'formulario_cartao': formulario_cartao})


def historico_compras(request):
    return render(request, 'historico_compras.html')


def enderecos(request):
    campos = [
        campo for campo in Endereco._meta.fields
        if not isinstance(campo, ForeignKey)
    ]
    return render(request, 'enderecos.html', {'campos': campos})


def formas_pagamento(request):
    campos_pix = [
        campo for campo in Pix._meta.fields
        if not isinstance(campo, ForeignKey)
    ]

    campos_cartao = [
        campo for campo in Cartao._meta.fields
        if not isinstance(campo, ForeignKey)
    ]

    return render(request, 'formas_pagamento.html', {'campos_pix': campos_pix, 'campos_cartao': campos_cartao})


def formas_pagamento_criar(request):
    if request.method == 'POST':
        # formulario = EnderecoForm(request.POST)
        # if formulario.is_valid():
        #     formulario.save()
        return redirect('formas_pagamento')
    
    formulario_cartao = CartaoForm()
    formulario_pix = PixForm()
    return render(request, 'formas_pagamento_criar.html', {'formulario_cartao': formulario_cartao, 'formulario_pix': formulario_pix})


def enderecos_criar(request):
    if request.method == 'POST':
        # formulario = EnderecoForm(request.POST)
        # if formulario.is_valid():
        #     formulario.save()
        return redirect('enderecos')
    
    formulario = EnderecoForm()
    return render(request, 'enderecos_criar.html', {'formulario': formulario})


def enderecos_editar(request):
    if request.method == 'POST':
        # formulario = EnderecoForm(request.POST)
        # if formulario.is_valid():
        #     formulario.save()
        return redirect('enderecos')
    
    formulario = EnderecoForm()
    return render(request, 'enderecos_editar.html', {'formulario': formulario})