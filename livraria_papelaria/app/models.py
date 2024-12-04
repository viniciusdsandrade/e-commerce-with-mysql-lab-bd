from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone



# Tabela para armazenar as Transportadoras
class Transportadora(models.Model):
    nome = models.CharField(max_length=100)
    cnpj = models.CharField(max_length=20, unique=True)
    inscricao_estadual = models.CharField(max_length=100, unique=True)
    preco = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Transportadora'



# Tabela para armazenar formas de pagamento
class FormaPagamento(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        verbose_name = verbose_name_plural = 'FormaPagamento'


# Tabela para armazenar detalhes específicos do PIX
class Pix(FormaPagamento):
    chave = models.CharField(max_length=100)

    class Meta:
        verbose_name = verbose_name_plural = 'Pix'


# Tabela para armazenar detalhes específicos do Cartão de Crédito
class Cartao(FormaPagamento):
    class TipoChoices(models.TextChoices):
        DEBITO = 'DEBITO', 'Débito'
        CREDITO = 'CREDITO', 'Crédito'

    numero = models.CharField(max_length=20)
    validade = models.DateField()
    codigo_seguranca = models.CharField(max_length=10)
    nome_dono = models.CharField(max_length=100)
    tipo = models.CharField(
        max_length=7,
        choices=TipoChoices.choices,
    )

    def ultimos_digitos(self):
        return self.numero[-4:]

    class Meta:
        verbose_name = verbose_name_plural = 'Cartao'


# Tabela para armazenar endereços dos usuários
class Endereco(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    nome = models.CharField(max_length=20, null=True, blank=False)
    rua = models.CharField(max_length=100, null=True, blank=False)
    numero = models.CharField(max_length=8, null=True, blank=False)
    bairro = models.CharField(max_length=100, null=True, blank=False)
    cidade = models.CharField(max_length=100, null=True, blank=False)
    estado = models.CharField(max_length=100, null=True, blank=False)
    cep = models.CharField(max_length=20, null=True, blank=False)
    complemento = models.CharField(max_length=50, null=True, blank=True)
    is_principal = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.rua}, {self.numero} - {self.cidade}"

    class Meta:
        verbose_name = verbose_name_plural = 'Endereco'


# Tabela para armazenar os Produtos
class Produto(models.Model):
    nome = models.CharField(max_length=50)
    preco = models.DecimalField(max_digits=10, decimal_places=2)
    descricao = models.TextField(null=True, blank=True)
    is_ativo = models.BooleanField(default=True)

    def __str__(self):
        return self.nome
    
    def preco_atual(self):
        promocao = self.promocao_set.last()

        if promocao:
            promocao_produto = promocao.promocaoproduto_set.get(produto=self)
            return self.preco * (1 - promocao_produto.desconto)
        
        return self.preco

    class Meta:
        verbose_name = verbose_name_plural = 'Produto'


# Tabela para armazenar o Estoque dos Produtos
class Estoque(models.Model):
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()
    localizacao = models.CharField(max_length=70, null=True, blank=True)

    class Meta:
        verbose_name = verbose_name_plural = 'Estoque'


# Tabela para armazenar as Categorias
class Categoria(models.Model):
    class TipoChoices(models.TextChoices):
        LIVRARIA = 'LIVRARIA', 'Livraria'
        PAPELARIA = 'PAPELARIA', 'Papelaria'

    nome = models.CharField(max_length=50)
    produtos = models.ManyToManyField(Produto)

    tipo = models.CharField(
        max_length=15,
        choices=TipoChoices.choices,
        null=True,
    )

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Categoria'


# Tabela para armazenar as Listas de Desejos
class ListaDesejos(models.Model):
    usuario = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    produtos = models.ManyToManyField(Produto)

    class Meta:
        verbose_name = verbose_name_plural = 'ListaDesejos'


# Tabela para armazenar os Carrinhos de Compras de cada Usuário
class Carrinho(models.Model):
    usuario = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    produtos = models.ManyToManyField(Produto, through='CarrinhoProduto')

    class Meta:
        verbose_name = verbose_name_plural = 'Carrinho'

    def __str__(self):
        return f"{self.__dict__}"


# Tabela de associação N:N entre Carrinhos e Produtos
class CarrinhoProduto(models.Model):
    carrinho = models.ForeignKey(Carrinho, on_delete=models.CASCADE)
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()

    class Meta:
        verbose_name = verbose_name_plural = 'CarrinhoProduto'

    def __str__(self):
        return f"{self.__dict__}"


# Tabela para armazenar as Compras
class Compra(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    forma_pagamento = models.ForeignKey(FormaPagamento, on_delete=models.CASCADE, null=True, blank=True)
    endereco = models.ForeignKey(Endereco, on_delete=models.CASCADE, null=True, blank=True)
    data_realizada = models.DateTimeField(auto_now_add=True)
    produtos = models.ManyToManyField(Produto, through='CompraProduto')

    def __str__(self):
        return f"Compra #{self.id} - {self.usuario.username}"
    
    def quantidade_produtos(self):
        return sum([compra_produto.quantidade for compra_produto in self.compraproduto_set.all()])

    def preco_produtos(self):
        return sum([compra_produto.produto.preco_atual() * compra_produto.quantidade for compra_produto in self.compraproduto_set.all()])

    def preco_frete(self):
        soma = 0

        for compra_produto in self.compraproduto_set.all():
            transportadora = compra_produto.entrega_associada().transportadora
            soma += transportadora.preco if transportadora is not None else 0

        return soma

    def desconto_cupons(self):
        soma = 0

        for cupom in self.cupom_set.all():
            soma += cupom.desconto

        return soma

    def preco_total(self):
        return max(0, self.preco_produtos() + self.preco_frete() - self.desconto_cupons())

    class Meta:
        verbose_name = verbose_name_plural = 'Compra'


# Tabela para armazenar os produtos comprados em cada compra
class CompraProduto(models.Model):
    compra = models.ForeignKey(Compra, on_delete=models.CASCADE)
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()

    def entrega_associada(self):
        try:
            entrega = Entrega.objects.get(compra_produto=self)
        except Entrega.DoesNotExist:
            entrega = Entrega(compra_produto=self)
            entrega.save()

        return entrega

    def foi_avaliado(self):
        return hasattr(self, 'avaliacao')

    class Meta:
        unique_together = ('compra', 'produto')
        verbose_name = verbose_name_plural = 'CompraProduto'


# Tabela para armazenar as avaliações dos produtos comprados
class Avaliacao(models.Model):
    class NotaChoices(models.TextChoices):
        UMA = '⭐', '⭐'
        DUAS = '⭐⭐', '⭐⭐'
        TRES = '⭐⭐⭐', '⭐⭐⭐'
        QUATRO = '⭐⭐⭐⭐', '⭐⭐⭐⭐'
        CINCO = '⭐⭐⭐⭐⭐', '⭐⭐⭐⭐⭐'

    compra_produto = models.OneToOneField(CompraProduto, on_delete=models.CASCADE, primary_key=True)
    nota = models.CharField(
        max_length=5,
        choices=NotaChoices.choices,
        null=True,
        blank=True
    )
    comentario = models.TextField(null=True, blank=True)

    class Meta:
        verbose_name = verbose_name_plural = 'Avaliacao'


# Tabela de Cupons
class Cupom(models.Model):
    nome = models.CharField(max_length=100, null=True, blank=True)
    desconto = models.DecimalField(max_digits=10, decimal_places=2)
    data_inicio = models.DateTimeField()
    data_fim = models.DateTimeField()
    compras = models.ManyToManyField(Compra, blank=True)

    def __str__(self):
        return self.nome

    def is_valido(self, usuario):
        dentro_do_tempo = self.data_inicio <= timezone.now() <= self.data_fim
        usuario_nao_usou = not self.compras.filter(usuario=usuario).exists()

        return dentro_do_tempo and usuario_nao_usou

    class Meta:
        verbose_name = verbose_name_plural = 'Cupom'


# Tabela de rastreamento de compras, com relação 1:1 com tb_compra_produto
class Entrega(models.Model):
    class EstadoChoices(models.TextChoices):
        AGUARDANDO_PAGAMENTO_COMPRA = 'AGUARDANDO_PAGAMENTO_COMPRA', 'Aguardando Pagamento da Compra'
        EM_PREPARO = 'EM_PREPARO', 'Em Preparo'
        POSTADO = 'POSTADO', 'Postado'
        EM_TRANSITO = 'EM_TRANSITO', 'Em Trânsito'
        ENTREGUE = 'ENTREGUE', 'Entregue'

    compra_produto = models.OneToOneField(CompraProduto, on_delete=models.CASCADE, primary_key=True)
    transportadora = models.ForeignKey(Transportadora, on_delete=models.CASCADE, null=True, blank=True)
    codigo_rastreio = models.CharField(max_length=100, null=True, blank=True)
    data_postado = models.DateTimeField(null=True, blank=True)
    data_transito = models.DateTimeField(null=True, blank=True)
    data_recebido = models.DateTimeField(null=True, blank=True)
    estado = models.CharField(
        max_length=30,
        choices=EstadoChoices.choices,
        default=EstadoChoices.AGUARDANDO_PAGAMENTO_COMPRA,
    )

    class Meta:
        verbose_name = verbose_name_plural = 'Entrega'


# Tabela de Promoções
class Promocao(models.Model):
    nome = models.CharField(max_length=100, null=True, blank=True)
    data_inicio = models.DateTimeField()
    data_fim = models.DateTimeField()
    produtos = models.ManyToManyField(Produto, through='PromocaoProduto')

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Promocao'


# Tabela de associação N:N entre Promoções e Produtos
class PromocaoProduto(models.Model):
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    promocao = models.ForeignKey(Promocao, on_delete=models.CASCADE)
    desconto = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        unique_together = ('produto', 'promocao')
        verbose_name = verbose_name_plural = 'PromocaoProduto'
