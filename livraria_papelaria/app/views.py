from django.shortcuts import render
from .models import Endereco
from django.db.models import ForeignKey
from .forms import EnderecoForm

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


def enderecos(request):
    campos = [
        campo for campo in Endereco._meta.fields
        if not isinstance(campo, ForeignKey)
    ]
    return render(request, 'enderecos.html', {'campos': campos})


def enderecos_editar(request):
    if request.method == 'POST':
        formulario = EnderecoForm(request.POST)
        if formulario.is_valid():
            formulario.save()
    else:
        formulario = EnderecoForm()

    return render(request, 'enderecos_editar.html', {'formulario': formulario})