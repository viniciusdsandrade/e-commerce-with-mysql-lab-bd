from django.shortcuts import render, redirect, get_object_or_404
from .models import Produto, Compra, CompraProduto, Carrinho, CarrinhoProduto, Endereco
from .forms import EnderecoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from .forms import EnderecoForm, PixForm, CartaoForm


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def compra_endereco(request, id_compra):
    formulario = EnderecoForm()
    enderecos = request.user.endereco_set.all()
    return render(request, 'compra_endereco.html', {'enderecos': enderecos, 'formulario': formulario})


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
