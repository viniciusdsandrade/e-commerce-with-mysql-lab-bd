from django.shortcuts import render

def index(request):
    return render(request, 'index.html')


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