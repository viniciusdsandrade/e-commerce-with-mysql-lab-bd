from django.shortcuts import render, redirect, get_object_or_404

from .models import Produto, Compra, CompraProduto, Carrinho, CarrinhoProduto, \
Endereco, Transportadora, Entrega, Cupom, FormaPagamento

from .forms import EnderecoForm, PixForm, CartaoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from .context_processors import produtos_processor
from random import choice


from django.utils import timezone


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def compra_endereco(request, id_compra):
    compra = get_object_or_404(Compra, id=id_compra)

    if request.method == 'POST':
        endereco = None

        if request.POST['Tipo'] == 'Existente':
            endereco = Endereco.objects.get(id=request.POST['Endereco'])

        elif request.POST['Tipo'] == 'Novo':
            formulario = EnderecoForm(request.POST)

            if formulario.is_valid():
                endereco = formulario.save(commit=False)
                endereco.usuario = request.user
                endereco.save()


        compra.endereco = endereco
        compra.save()
        return redirect('compra_transportadoras', id_compra=id_compra)

    formulario = EnderecoForm()
    enderecos = request.user.endereco_set.all()
    return render(request, 'compra_endereco.html', {
        'enderecos': enderecos,
        'formulario': formulario,
        'compra': compra
    })


@login_required
@user_passes_test(usuario_comum)
def compra_transportadoras(request, id_compra):
    compra = get_object_or_404(Compra, id=id_compra)
    compra_produtos = CompraProduto.objects.filter(compra=compra)

    if request.method == 'POST':
        for compra_produto in compra_produtos:
            transportadora = Transportadora.objects.get(id=request.POST[f'Transportadora{compra_produto.id}'])
            entrega = Entrega.objects.get(compra_produto=compra_produto)
            entrega.transportadora = transportadora
            entrega.save()

        return redirect('compra_cupons', id_compra=id_compra)

    transportadoras = Transportadora.objects.all()
    return render(request, 'compra_transportadoras.html', {'compra': compra, 'compra_produtos': compra_produtos, 'transportadoras': transportadoras})


@login_required
@user_passes_test(usuario_comum)
def compra_cupons(request, id_compra):
    compra = get_object_or_404(Compra, id=id_compra)

    if request.method == 'POST':
        cupons = request.POST.getlist('cupons')
        compra.cupom_set.set(cupons)
        return redirect('compra_pagamento', id_compra=id_compra)

    cupons = [cupom for cupom in Cupom.objects.all() if cupom.is_valido(request.user)]
    return render(request, 'compra_cupons.html', {'compra': compra, 'cupons': cupons})


@login_required
@user_passes_test(usuario_comum)
def compra_pagamento(request, id_compra):
    if request.method == 'POST':
        if choice([True]):
            compra = Compra.objects.get(id=id_compra)
            compra_produtos = compra.compraproduto_set.all()

            forma_pagamento = None

            for compra_produto in compra_produtos:
                compra_produto.entrega.estado = 'EM_PREPARO'
                compra_produto.entrega.save()

            if request.POST['FormaPagamento'] == 'Existente':
                forma_pagamento = FormaPagamento.objects.get(id=request.POST['FormaId'])
            
            elif request.POST['FormaPagamento'] == 'PixNovo':
                formulario = PixForm(request.POST)

                if formulario.is_valid():
                    forma_pagamento = formulario.save(commit=False)
                    forma_pagamento.usuario = request.user
                    forma_pagamento.save()
                else:
                    messages.warning(request, ('Erro no formulário da forma de pagamento. Tente novamente.'))
                    return redirect('compra_pagamento', id_compra=id_compra)

            elif request.POST['FormaPagamento'] == 'CartaoNovo':
                formulario = CartaoForm(request.POST)

                if formulario.is_valid():
                    forma_pagamento = formulario.save(commit=False)
                    forma_pagamento.usuario = request.user
                    forma_pagamento.save()
                else:
                    messages.warning(request, ('Erro no formulário da forma de pagamento. Tente novamente.'))
                    return redirect('compra_pagamento', id_compra=id_compra)

            compra.forma_pagamento = forma_pagamento
            compra.save()
            messages.success(request, ('Compra realizada com sucesso!'))
            return redirect('historico_compras')
        
        messages.warning(request, ('Erro ao efetuar pagamento. Tente novamente.'))

    compra = get_object_or_404(Compra, id=id_compra)
    formulario_pix = PixForm()
    formulario_cartao = CartaoForm()
    cartoes = [forma.cartao for forma in request.user.formapagamento_set.all() if hasattr(forma, 'cartao')]
    pix = [forma.pix for forma in request.user.formapagamento_set.all() if hasattr(forma, 'pix')]
    
    for cartao in cartoes:
        cartao.ultimos_digitos = cartao.numero[-4:]

    return render(request, 'compra_pagamento.html', {
        'compra': compra,
        'formulario_pix': formulario_pix,
        'formulario_cartao': formulario_cartao,
        'cartoes': cartoes,
        'pix': pix,
    })


# def comprar_agora_listadesejos(request, id_produto):
#     try:
#         endereco = request.user.endereco_set.get(is_principal=True)
#     except Endereco.DoesNotExist:
#         messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
#         return redirect('enderecos')

#     compra = Compra.objects.create(usuario=request.user, endereco=endereco)
#     compra.save()

#     listadesejos = ListaDesejos.objects.get(id=id_carrinho)
#     produto = Produto.objects.get(id=id_produto)

#     if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
#         listadesejos.produtos.remove(produto)
#         compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=1)
#         compraproduto.save()

#     return redirect('enderecos')


@login_required
@user_passes_test(usuario_comum)
def comprar_produto(request, id_produto):
    produto = get_object_or_404(Produto, id=id_produto)
    compra = Compra.objects.create(usuario=request.user)
    CompraProduto.objects.create(compra=compra, produto=produto, quantidade=1)
    return redirect('compra_endereco', id_compra=compra.id)


@login_required
@user_passes_test(usuario_comum)
def comprar_carrinho(request):
    carrinho = get_object_or_404(Carrinho, usuario_id=request.user.id)
    compra = Compra.objects.create(usuario=request.user)
    carrinho_produtos = CarrinhoProduto.objects.filter(carrinho=carrinho)

    if not carrinho_produtos:
        messages.warning(request, ('Seu carrinho está vazio.'))
        return redirect('carrinho')

    for carrinho_produto in carrinho_produtos:
        CompraProduto.objects.create(compra=compra, produto=carrinho_produto.produto, quantidade=carrinho_produto.quantidade)
    
    carrinho.produtos.clear()

    return redirect('compra_endereco', id_compra=compra.id)


# @login_required
# @user_passes_test(usuario_comum)
# def comprar_agora_carrinho(request, id_produto, id_carrinho):
#     try:
#         endereco = request.user.endereco_set.get(is_principal=True)
#     except Endereco.DoesNotExist:
#         messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
#         return redirect('enderecos')

#     compra = Compra.objects.create(usuario=request.user, endereco=endereco)
#     compra.save()

#     carrinho = Carrinho.objects.get(id=id_carrinho)
#     produto = Produto.objects.get(id=id_produto)

#     if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
#         carrinhoproduto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
#         carrinho.produtos.remove(produto)
#         compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=carrinhoproduto.quantidade)
#         compraproduto.save()

#     return redirect('enderecos')
