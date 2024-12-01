from django import forms
from .models import Endereco, Pix, Cartao


class EnderecoForm(forms.ModelForm):
    class Meta:
        model = Endereco
        fields = ['nome', 'rua', 'numero', 'complemento', 'bairro', 'cidade', 'estado', 'cep', 'is_principal']


class PixForm(forms.ModelForm):
    class Meta:
        model = Pix
        fields = ['chave']


class CartaoForm(forms.ModelForm):
    class Meta:
        model = Cartao
        fields = ['nome_dono', 'numero', 'validade', 'codigo_seguranca', 'tipo']
