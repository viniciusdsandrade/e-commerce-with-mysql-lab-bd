from django.shortcuts import render, redirect, get_object_or_404
from .models import Pix, Cartao
from .forms import PixForm, CartaoForm
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento(request):
    pix = Pix.objects.filter(usuario_id=request.user.id)
    cartoes = Cartao.objects.filter(usuario_id=request.user.id)
    return render(request, 'formas_pagamento.html', {'pix': pix, 'cartoes': cartoes})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento_criar(request, tipo_pagamento):
    if request.method == 'POST':
        if tipo_pagamento == 'cartao':
            formulario = CartaoForm(request.POST)
        elif tipo_pagamento == 'pix':
            formulario = PixForm(request.POST)
        else:
            return redirect('formas_pagamento')

        if formulario.is_valid():
            pagamento = formulario.save(commit=False)
            pagamento.usuario = request.user
            pagamento.save()
            return redirect('formas_pagamento')
        else:
            messages.warning(request, ('Houve um erro ao salvar o pagamento. Pode ser que a validade não esteja no formato certo (AAAA-MM-DD).'))
            return redirect('formas_pagamento_criar', tipo_pagamento=tipo_pagamento)
    if tipo_pagamento == 'pix':
        formulario = PixForm()
        tipo_pagamento = 'Pix'
    elif tipo_pagamento == 'cartao':
        tipo_pagamento = 'Cartão'
        formulario = CartaoForm()
    else:
        return redirect('formas_pagamento')

    return render(request, 'formas_pagamento_criar.html', {'formulario': formulario, 'tipo_pagamento': tipo_pagamento})


@login_required
@user_passes_test(usuario_comum)
def formas_pagamento_remover(request, tipo_pagamento, id_pagamento):
    if tipo_pagamento == 'pix':
        pagamento = get_object_or_404(Pix, id=id_pagamento)
    elif tipo_pagamento == 'cartao':
        pagamento = get_object_or_404(Cartao, id=id_pagamento)
    else:
        return redirect('formas_pagamento')

    pagamento.delete()
    return redirect('formas_pagamento')
