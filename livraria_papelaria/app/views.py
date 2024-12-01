from django.shortcuts import render, redirect, get_object_or_404
from .models import Endereco, Pix, Cartao, Categoria, ListaDesejos, Produto
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
def lista_de_desejos(request):
    listadesejos = ListaDesejos.objects.get(usuario=request.user)
    produtos = listadesejos.produtos.all()
    return render(request, 'lista_de_desejos.html', {'produtos': produtos})


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos_adicionar(request, id_produto):
    listadesejos = ListaDesejos(usuario=request.user)
    listadesejos.save()

    produto = Produto.objects.get(id=id_produto)

    listadesejos.produtos.add(produto)
    listadesejos.save()

    return redirect('lista_de_desejos')


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos_remover(request, id_produto):
    listadesejos = ListaDesejos(usuario=request.user)

    produto = Produto.objects.get(id=id_produto)
    listadesejos.produtos.remove(produto)
    listadesejos.save()

    return redirect('lista_de_desejos')


@login_required
@user_passes_test(usuario_comum)
def carrinho(request):
    return render(request, 'carrinho.html')


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


@login_required
@user_passes_test(usuario_comum)
def enderecos(request):
    enderecos = request.user.endereco_set.all().order_by('-is_principal')
    return render(request, 'enderecos.html', {'enderecos': enderecos})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento(request):
    pix = Pix.objects.filter(usuario_id=request.user.id)
    cartoes = Cartao.objects.filter(usuario_id=request.user.id)
    return render(request, 'formas_pagamento.html', {'pix': pix, 'cartoes': cartoes})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento_criar(request, tipo_pagamento):
    if request.method == 'POST':
        if tipo_pagamento == 'pix':
            formulario = PixForm(request.POST)
        elif tipo_pagamento == 'cartao':
            formulario = CartaoForm(request.POST)
        else:
            return redirect('formas_pagamento')

        if formulario.is_valid():
            pagamento = formulario.save(commit=False)
            pagamento.usuario = request.user
            pagamento.save()

        return redirect('formas_pagamento')

    if tipo_pagamento == 'pix':
        formulario = PixForm()
        tipo_pagamento = 'Pix'
    elif tipo_pagamento == 'cartao':
        tipo_pagamento = 'Cartão'
        formulario = CartaoForm()
    else:
        return redirect('formas_pagamento')

    return render(request, 'formas_pagamento_criar.html', {'formulario': formulario, 'tipo_pagamento': tipo_pagamento})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento_remover(request, tipo_pagamento, id_pagamento):
    if tipo_pagamento == 'pix':
        pagamento = get_object_or_404(Pix, id=id_pagamento)
    elif tipo_pagamento == 'cartao':
        pagamento = get_object_or_404(Cartao, id=id_pagamento)
    else:
        return redirect('formas_pagamento')

    pagamento.delete()
    return redirect('formas_pagamento')


@login_required
@user_passes_test(usuario_comum)
def enderecos_criar(request):
    if request.method == 'POST':
        formulario = EnderecoForm(request.POST)

        if formulario.is_valid():
            endereco = formulario.save(commit=False)
            endereco.usuario = request.user
            endereco.save()

        return redirect('enderecos')

    formulario = EnderecoForm()
    return render(request, 'enderecos_criar.html', {'formulario': formulario})


@login_required
@user_passes_test(usuario_comum)
def enderecos_editar(request, id_endereco):
    endereco = get_object_or_404(Endereco, id=id_endereco)

    if request.method == 'POST':
        form = EnderecoForm(request.POST, instance=endereco)
        if form.is_valid():
            form.save()
            return redirect('enderecos')

    formulario = EnderecoForm(instance=endereco)
    return render(request, 'enderecos_editar.html', {'formulario': formulario})


@login_required
@user_passes_test(usuario_comum)
def enderecos_remover(request, id_endereco):
    endereco = get_object_or_404(Endereco, id=id_endereco)
    endereco.delete()
    return redirect('enderecos')


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

        User.objects.create_user(username=username, password=password1)
        ListaDesejos.objects.create()

        messages.success(request, ('Cadastro realizado com sucesso.'))
        return redirect('entrar')

    return render(request, 'cadastrar.html')


@user_passes_test(usuario_comum)
def sair(request):
    logout(request)
    messages.success(request, ('Você saiu da sua conta.'))
    return redirect('home')
