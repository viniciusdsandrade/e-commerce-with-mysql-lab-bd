from django.shortcuts import render, redirect
from .models import ListaDesejos, Produto, Carrinho, Cupom
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from django.contrib.auth.models import User
from .context_processors import produtos_processor


def usuario_comum(user):
    return not user.is_staff


@user_passes_test(usuario_comum)
def home(request):
    return render(request, 'home.html')


@user_passes_test(usuario_comum)
def pesquisa(request):
    filtros = request.GET.copy()

    def existe(chave):
        return chave in filtros.keys() and filtros[chave] != ''
    

    # Filtros padrão

    if not existe('OrdemPreco'):
        filtros['OrdemPreco'] = 'Qualquer'

    if not existe('Categoria'):
        filtros['Categoria'] = 'Qualquer'

    if not existe('Promocao'):
        filtros['Promocao'] = 'Desconsiderar'

    if not existe('Busca'):
        filtros['Busca'] = ''



    produtos = Produto.objects.all()


    # Aplicar filtros

    produtos = produtos.filter(nome__icontains=filtros['Busca'])

    if filtros['Categoria'] != 'Qualquer':
        produtos = produtos.filter(categoria=filtros['Categoria'])
        filtros['Categoria'] = int(filtros['Categoria'])


    produtos = produtos_processor(request, produtos)['produtos']


    if filtros['Promocao'] != 'Desconsiderar':
        produtos = [produto for produto in produtos if produto.tem_promocao]

        if filtros['Promocao'] != 'Qualquer desconto':
            produtos = [
                produto for produto in produtos
                if produto.desconto / 100 >= float(filtros['Promocao'])
            ]

    if existe('Minimo'):
        produtos = [produto for produto in produtos if produto.preco >= float(filtros['Minimo'])]
    if existe('Maximo'):
        produtos = [produto for produto in produtos if produto.preco <= float(filtros['Maximo'])]

    if filtros['OrdemPreco'] != 'Qualquer':
        if filtros['OrdemPreco'] == 'Asc':
            reverse = False
        elif filtros['OrdemPreco'] == 'Desc':
            reverse = True

        produtos = sorted(produtos, key=lambda produto: produto.preco, reverse=reverse)

    return render(request, 'pesquisa.html', {'produtos': produtos, 'filtros': filtros})


@user_passes_test(usuario_comum)
def categorias(request):
    return render(request, 'categorias.html')


@user_passes_test(usuario_comum)
def produto(request, id_produto):
    produto = produtos_processor(request, Produto.objects.filter(id=id_produto))['produtos'][0]
    return render(request, 'produto.html', {'produto': produto})


@login_required
@user_passes_test(usuario_comum)
def conta(request):
    return render(request, 'conta.html')


@login_required
@user_passes_test(usuario_comum)
def cupons(request):
    cupons = [cupom for cupom in Cupom.objects.all() if cupom.is_valido(request.user)]
    return render(request, 'cupons.html', {'cupons': cupons})


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
            messages.warning(request, ('As senhas não coincidem.'))
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
