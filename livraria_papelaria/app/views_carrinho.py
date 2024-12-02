from django.shortcuts import render, redirect
from .models import Carrinho, Produto, CarrinhoProduto
from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import HttpResponse


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def carrinho(request):
    carrinho = Carrinho.objects.get(usuario=request.user)

    produtos = []
    for produto in carrinho.produtos.all():
        carrinhoproduto = CarrinhoProduto.objects.get(produto=produto, carrinho=carrinho)
        produto.quantidade = carrinhoproduto.quantidade
        produto.tem_promocao = False

        if produto.promocaoproduto_set.all():
            produto.tem_promocao = True
            produto.desconto = produto.promocaoproduto_set.all()[0].desconto
            produto.preco_com_desconto = round(produto.preco * (1 - produto.desconto), 2)
            produto.desconto = round(produto.desconto * 100)

        produtos.append(produto)

    return render(request, 'carrinho.html', {'produtos': produtos, 'id_carrinho': request.user.id})


@login_required
@user_passes_test(usuario_comum)
def carrinho_adicionar(request, id_produto):
    carrinho = Carrinho.objects.get(usuario=request.user)
    produto = Produto.objects.get(id=id_produto)

    carrinho_produto = CarrinhoProduto.objects.create(carrinho=carrinho, produto=produto, quantidade=1)
    carrinho_produto.save()
    return redirect('carrinho')


@login_required
@user_passes_test(usuario_comum)
def carrinho_remover(request, id_produto):
    carrinho = Carrinho.objects.get(usuario=request.user)
    produto = Produto.objects.get(id=id_produto)

    carrinho_produto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
    carrinho_produto.delete()
    return redirect('carrinho')


# ISSO È GAMBI MONSTRA!! Não imitar!!!!
def quantidade_produto(request, id_produto, id_carrinho, quantidade):
    carrinho = Carrinho.objects.get(usuario_id=id_carrinho)
    produto = Produto.objects.get(id=id_produto)

    carrinho_produto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
    carrinho_produto.quantidade = quantidade
    carrinho_produto.save()
    return HttpResponse('')
