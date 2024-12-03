from django.shortcuts import render, redirect, get_object_or_404
from .models import Produto, Compra, CompraProduto, Carrinho, CarrinhoProduto, Endereco, ListaDesejos
from .forms import EnderecoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def comprar_agora(request, id_produto):
    try:
        endereco = request.user.endereco_set.get(is_principal=True)
    except Endereco.DoesNotExist:
        messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
        return redirect('enderecos')

    compra = Compra.objects.create(usuario=request.user, endereco=endereco)
    compra.save()

    produto = Produto.objects.get(id=id_produto)

    if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
        compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=1)
        compraproduto.save()

    return redirect('enderecos')


@login_required
@user_passes_test(usuario_comum)
def comprar_agora_carrinho(request, id_produto, id_carrinho):
    try:
        endereco = request.user.endereco_set.get(is_principal=True)
    except Endereco.DoesNotExist:
        messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
        return redirect('enderecos')

    compra = Compra.objects.create(usuario=request.user, endereco=endereco)
    compra.save()

    carrinho = Carrinho.objects.get(id=id_carrinho)
    produto = Produto.objects.get(id=id_produto)

    if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
        carrinhoproduto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
        carrinho.produtos.remove(produto)
        compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=carrinhoproduto.quantidade)
        compraproduto.save()

    return redirect('enderecos')


@login_required
@user_passes_test(usuario_comum)
def comprar_agora_listadesejos(request, id_produto):
    try:
        endereco = request.user.endereco_set.get(is_principal=True)
    except Endereco.DoesNotExist:
        messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
        return redirect('enderecos')

    compra = Compra.objects.create(usuario=request.user, endereco=endereco)
    compra.save()

    listadesejos = ListaDesejos.objects.get(id=id_carrinho)
    produto = Produto.objects.get(id=id_produto)

    if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
        listadesejos.produtos.remove(produto)
        compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=1)
        compraproduto.save()

    return redirect('enderecos')


@login_required
@user_passes_test(usuario_comum)
def comprar_carrinho(request, id_carrinho):
    try:
        endereco = request.user.endereco_set.get(is_principal=True)
    except Endereco.DoesNotExist:
        messages.warning(request, ('Voce precisa de um endereço para fazer uma compra.'))
        return redirect('enderecos')

    compra = Compra.objects.create(usuario=request.user, endereco=endereco)
    compra.save()

    carrinho = Carrinho.objects.get(id=id_carrinho)

    for produto in carrinho.produtos.all():
        if not CompraProduto.objects.filter(compra=compra, produto=produto).exists():
            carrinhoproduto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
            compraproduto = CompraProduto.objects.create(compra=compra, produto=produto, quantidade=carrinhoproduto.quantidade)
            compraproduto.save()

    carrinho.produtos.clear()
    return redirect('enderecos')
