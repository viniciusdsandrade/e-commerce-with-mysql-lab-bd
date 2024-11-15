from django.shortcuts import render

def index(request):
    return render(request, 'index.html')


def pesquisa(request):
    return render(request, 'pesquisa.html')


def categorias(request):
    return render(request, 'categorias.html')


def produto(request):
    return render(request, 'produto.html')