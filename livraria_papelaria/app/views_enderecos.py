from django.shortcuts import render, redirect, get_object_or_404
from .models import Endereco
from .forms import EnderecoForm
from django.contrib.auth.decorators import login_required, user_passes_test


def usuario_comum(user):
    return not user.is_staff


@login_required
@user_passes_test(usuario_comum)
def enderecos(request):
    enderecos = request.user.endereco_set.all().order_by('-is_principal')
    return render(request, 'enderecos.html', {'enderecos': enderecos})


@login_required
@user_passes_test(usuario_comum)
def enderecos_criar(request):
    if request.method == 'POST':
        formulario = EnderecoForm(request.POST)

        if formulario.is_valid():
            endereco = formulario.save(commit=False)
            endereco.usuario = request.user
            endereco.save()

        return redirect('enderecos')

    formulario = EnderecoForm()
    return render(request, 'enderecos_criar.html', {'formulario': formulario})


@login_required
@user_passes_test(usuario_comum)
def enderecos_editar(request, id_endereco):
    endereco = get_object_or_404(Endereco, id=id_endereco)

    if request.method == 'POST':
        form = EnderecoForm(request.POST, instance=endereco)
        if form.is_valid():
            form.save()
            return redirect('enderecos')

    formulario = EnderecoForm(instance=endereco)
    return render(request, 'enderecos_editar.html', {'formulario': formulario})


@login_required
@user_passes_test(usuario_comum)
def enderecos_remover(request, id_endereco):
    endereco = get_object_or_404(Endereco, id=id_endereco)
    endereco.delete()
    return redirect('enderecos')
