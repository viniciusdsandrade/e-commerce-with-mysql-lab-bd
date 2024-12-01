from django.shortcuts import render, redirect
from .models import ListaDesejos, Produto, Carrinho
from .forms import EnderecoForm, PixForm, CartaoForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.contrib.auth.models import User


def usuario_comum(user):
    return not user.is_staff


@user_passes_test(usuario_comum)
def home(request):
    produtos = Produto.objects.all()
    return render(request, 'home.html', {'produtos': produtos})


@user_passes_test(usuario_comum)
def pesquisa(request):
    return render(request, 'pesquisa.html')


@user_passes_test(usuario_comum)
def categorias(request):
    return render(request, 'categorias.html')


@user_passes_test(usuario_comum)
def produto(request):
    produtos = Produto.objects.all()
    return render(request, 'produto.html', {'produtos': produtos})


@login_required
@user_passes_test(usuario_comum)
def conta(request):
    return render(request, 'conta.html')


@login_required
@user_passes_test(usuario_comum)
def cupons(request):
    return render(request, 'cupons.html')


@login_required
@user_passes_test(usuario_comum)
def compra_endereco(request):
    formulario = EnderecoForm()
    return render(request, 'compra_endereco.html', {'formulario': formulario})


@login_required
@user_passes_test(usuario_comum)
def compra_transportadora(request):
    return render(request, 'compra_transportadora.html')


@login_required
@user_passes_test(usuario_comum)
def compra_pagamento(request):
    formulario_pix = PixForm()
    formulario_cartao = CartaoForm()
    return render(request, 'compra_pagamento.html', {'formulario_pix': formulario_pix, 'formulario_cartao': formulario_cartao})


@login_required
@user_passes_test(usuario_comum)
def historico_compras(request):
    return render(request, 'historico_compras.html')


def entrar(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)

        if user is None:
            messages.warning(request, ('Houve um erro ao realizar o login.'))
            return redirect('entrar')

        if user.is_staff:
            messages.warning(request, ('Este usuário é um administrador e só tem acesso ao painel de administração.'))
            return redirect('entrar')

        login(request, user)
        messages.success(request, ('Login realizado com sucesso.'))
        return redirect('home')

    return render(request, 'entrar.html')


def cadastrar(request):
    if request.method == 'POST':
        username = request.POST['username']
        password1 = request.POST['password1']
        password2 = request.POST['password2']

        if password1 != password2:
            messages.success(request, ('As senhas não coincidem.'))
            return redirect('cadastrar')

        if User.objects.filter(username=username).first():
            messages.warning(request, ('Este nome de usuário já está sendo usado.'))
            return redirect('cadastrar')

        usuario = User.objects.create_user(username=username, password=password1)
        ListaDesejos.objects.create(usuario=usuario)
        Carrinho.objects.create(usuario=usuario)

        messages.success(request, ('Cadastro realizado com sucesso.'))
        return redirect('entrar')

    return render(request, 'cadastrar.html')


@user_passes_test(usuario_comum)
def sair(request):
    logout(request)
    messages.success(request, ('Você saiu da sua conta.'))
    return redirect('home')
