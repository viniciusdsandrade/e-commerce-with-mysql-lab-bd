from django.shortcuts import render, redirect, get_object_or_404
from .models import Endereco, Pix, Cartao, Categoria
from django.db.models import ForeignKey
from .forms import EnderecoForm, PixForm, CartaoForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.contrib.auth.models import User

def usuario_comum(user):
    return not user.is_staff


@user_passes_test(usuario_comum)
def home(request):
    return render(request, 'home.html')


@user_passes_test(usuario_comum)
def pesquisa(request):
    return render(request, 'pesquisa.html')


@user_passes_test(usuario_comum)
def categorias(request):
    return render(request, 'categorias.html')


@user_passes_test(usuario_comum)
def produto(request):
    return render(request, 'produto.html')


@login_required
@user_passes_test(usuario_comum)
def conta(request):
    return render(request, 'conta.html')


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos(request):
    return render(request, 'lista_de_desejos.html')


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
    campos_pix = [
        campo for campo in Pix._meta.fields
        if not isinstance(campo, ForeignKey)
    ]

    campos_cartao = [
        campo for campo in Cartao._meta.fields
        if not isinstance(campo, ForeignKey)
    ]

    return render(request, 'formas_pagamento.html', {'campos_pix': campos_pix, 'campos_cartao': campos_cartao})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento_criar(request):
    if request.method == 'POST':
        # formulario = EnderecoForm(request.POST)
        # if formulario.is_valid():
        #     formulario.save()
        return redirect('formas_pagamento')
    
    formulario_cartao = CartaoForm()
    formulario_pix = PixForm()
    return render(request, 'formas_pagamento_criar.html', {'formulario_cartao': formulario_cartao, 'formulario_pix': formulario_pix})


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
        form = EnderecoForm(request.POST, instance=endereco)  # Passa a instância existente
        if form.is_valid():
            form.save()  # Salva as alterações
            return redirect('enderecos')  # Redireciona após salvar

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
            messages.success(request, ('Houve um erro ao realizar o login.'))
            return redirect('entrar')
        
        if user.is_staff:
            messages.success(request, ('Este usuário é um administrador e só tem acesso ao painel de administração.'))
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
            messages.success(request, ('Este nome de usuário já está sendo usado.'))
            return redirect('cadastrar')

        User.objects.create_user(username=username, password=password1)

        messages.success(request, ('Cadastro realizado com sucesso.'))
        return redirect('entrar')

    return render(request, 'cadastrar.html')


@user_passes_test(usuario_comum)
def sair(request):
    logout(request)
    messages.success(request, ('Você saiu da sua conta.'))
    return redirect('home')