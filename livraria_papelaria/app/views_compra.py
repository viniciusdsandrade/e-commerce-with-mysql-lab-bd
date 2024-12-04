from django.shortcuts import render, redirect, get_object_or_404
from .models import Produto, Compra, CompraProduto, Carrinho, CarrinhoProduto, Endereco, Transportadora, Entrega, Cupom
from .forms import EnderecoForm, PixForm, CartaoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from .context_processors import produtos_processor


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
    compra = get_object_or_404(Compra, id=id_compra)
    formulario_pix = PixForm()
    formulario_cartao = CartaoForm()
    return render(request, 'compra_pagamento.html', {'compra': compra, 'formulario_pix': formulario_pix, 'formulario_cartao': formulario_cartao})


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
