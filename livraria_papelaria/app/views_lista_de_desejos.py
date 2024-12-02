from django.shortcuts import render, redirect
from .models import ListaDesejos, Produto
from .context_processors import produtos_processor
from django.contrib.auth.decorators import login_required, user_passes_test


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos(request):
    listadesejos = ListaDesejos.objects.get(usuario=request.user)
    produtos = produtos_processor(request, listadesejos.produtos.all())['produtos']
    return render(request, 'lista_de_desejos.html', {'produtos': produtos})


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos_adicionar(request, id_produto):
    listadesejos = ListaDesejos.objects.get(usuario=request.user)

    produto = Produto.objects.get(id=id_produto)

    listadesejos.produtos.add(produto)
    listadesejos.save()

    return redirect('lista_de_desejos')


@login_required
@user_passes_test(usuario_comum)
def lista_de_desejos_remover(request, id_produto):
    listadesejos = ListaDesejos.objects.get(usuario=request.user)

    produto = Produto.objects.get(id=id_produto)
    listadesejos.produtos.remove(produto)
    listadesejos.save()

    return redirect('lista_de_desejos')
