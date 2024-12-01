from django.shortcuts import render, redirect
from .models import Carrinho, Produto, CarrinhoProduto
from django.contrib.auth.decorators import login_required, user_passes_test


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def carrinho(request):
    produtos = []
    return render(request, 'carrinho.html', {'produtos': produtos})


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
