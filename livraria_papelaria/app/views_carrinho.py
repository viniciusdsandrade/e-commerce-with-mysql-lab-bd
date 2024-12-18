from django.shortcuts import render, redirect, get_object_or_404
from .models import Carrinho, Produto, CarrinhoProduto
from django.contrib.auth.decorators import login_required, user_passes_test
from django.http import HttpResponse
from .context_processors import produtos_processor


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def carrinho(request):
    carrinho = Carrinho.objects.get(usuario=request.user)

    produtos = [produto for produto in carrinho.produtos.all()]

    for produto in produtos:
        carrinhoproduto = CarrinhoProduto.objects.get(produto=produto, carrinho=carrinho)
        produto.quantidade = carrinhoproduto.quantidade

    produtos = produtos_processor(request, produtos)['produtos']
    quantidade_total = sum([produto.quantidade for produto in produtos])
    preco_total = sum([produto.preco * produto.quantidade for produto in produtos])

    return render(request, 'carrinho.html', {
        'produtos': produtos,
        'quantidade_total': quantidade_total,
        'preco_total': preco_total
    })


@login_required
@user_passes_test(usuario_comum)
def carrinho_adicionar(request, id_produto):
    carrinho = Carrinho.objects.get(usuario=request.user)
    produto = Produto.objects.get(id=id_produto)

    if not CarrinhoProduto.objects.filter(produto=produto, carrinho=carrinho).exists():
        carrinhoproduto = CarrinhoProduto.objects.create(carrinho=carrinho, produto=produto, quantidade=1)
        carrinhoproduto.save()

    return redirect('carrinho')


@login_required
@user_passes_test(usuario_comum)
def carrinho_remover(request, id_produto):
    carrinho = Carrinho.objects.get(usuario=request.user)
    produto = Produto.objects.get(id=id_produto)

    carrinho_produto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
    carrinho_produto.delete()
    return redirect('carrinho')


@login_required
@user_passes_test(usuario_comum)
def carrinho_esvaziar(request):
    carrinho = Carrinho.objects.get(usuario=request.user)

    carrinho.produtos.clear()
    return redirect('carrinho')


@login_required
@user_passes_test(usuario_comum)
def quantidade_produto(request, id_produto, id_carrinho, quantidade):
    carrinho = Carrinho.objects.get(usuario_id=id_carrinho)
    produto = Produto.objects.get(id=id_produto)

    carrinho_produto = CarrinhoProduto.objects.get(carrinho=carrinho, produto=produto)
    carrinho_produto.quantidade = quantidade
    carrinho_produto.save()

    carrinho = Carrinho.objects.get(usuario=request.user)

    produtos = [produto for produto in carrinho.produtos.all()]

    for produto in produtos:
        carrinhoproduto = CarrinhoProduto.objects.get(produto=produto, carrinho=carrinho)
        produto.quantidade = carrinhoproduto.quantidade

    produtos = produtos_processor(request, produtos)['produtos']
    quantidade_total = sum([produto.quantidade for produto in produtos])
    preco_total = sum([produto.preco * produto.quantidade for produto in produtos])

    resumo = f'''
    <div class="row row-cols-2 gy-2 align-items-center justify-content-between">
        <div class="fw-bold">Produtos ({ quantidade_total })</div>
            <div class="text-end">R${ preco_total }</div>
            <div class="fw-bold">Frete</div>
            <div class="text-end">a ser decidido</div>
            <div class="fw-bold">Cupons</div>
            <div class="text-end">a ser decidido</div>
        </div>

        <div class="row gx-3 mt-3">
            <div class="col">
                <a href="/comprar/carrinho" class="w-100 btn btn-primary">Continuar para compra</a>
            </div>
            <div class="col">
                <a href="/carrinho/esvaziar" class="w-100 btn btn-danger">Esvaziar carrinho</a>
            </div>                   
        </div>
    </div>'''

    return HttpResponse(resumo)
