from django.db import models
from django.contrib.auth.models import User


# Tabela de Papéis (Roles)
class Acesso(models.Model):
    nome = models.CharField(max_length=100, unique=True)  # Each role has a unique name
    pode_banir_usuario = models.BooleanField(default=False)
    pode_conversar_com_usuario = models.BooleanField(default=False)
    pode_visualizar_categorias = models.BooleanField(default=False)
    pode_criar_categorias = models.BooleanField(default=False)
    pode_editar_categorias = models.BooleanField(default=False)
    pode_remover_categorias = models.BooleanField(default=False)
    pode_visualizar_produtos = models.BooleanField(default=False)
    pode_criar_produtos = models.BooleanField(default=False)
    pode_editar_produtos = models.BooleanField(default=False)
    pode_remover_produtos = models.BooleanField(default=False)
    pode_visualizar_estoques = models.BooleanField(default=False)
    pode_criar_estoques = models.BooleanField(default=False)
    pode_editar_estoques = models.BooleanField(default=False)
    pode_remover_estoques = models.BooleanField(default=False)
    pode_visualizar_promocoes = models.BooleanField(default=False)
    pode_criar_promocoes = models.BooleanField(default=False)
    pode_editar_promocoes = models.BooleanField(default=False)
    pode_remover_promocoes = models.BooleanField(default=False)
    pode_criar_transportadora = models.BooleanField(default=False)
    pode_editar_transportadora = models.BooleanField(default=False)
    pode_remover_transportadora = models.BooleanField(default=False)
    pode_visualizar_avaliacoes = models.BooleanField(default=False)
    pode_remover_avaliacoes = models.BooleanField(default=False)
    pode_visualizar_cupons = models.BooleanField(default=False)
    pode_criar_cupons = models.BooleanField(default=False)
    pode_editar_cupons = models.BooleanField(default=False)
    pode_remover_cupons = models.BooleanField(default=False)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Acesso'


# Tabela base para armazenar os campos comuns entre Funcionários e Usuários
class Pessoa(models.Model):
    nome = models.CharField(max_length=100)
    data_nascimento = models.DateField(null=True, blank=True)
    cpf = models.CharField(max_length=20, unique=True)
    email = models.EmailField(max_length=100, unique=True)
    senha = models.CharField(max_length=255)
    telefone = models.CharField(max_length=20, null=True, blank=True)
    email_recuperacao = models.EmailField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Pessoa'


# Tabela para armazenar os dados específicos de Funcionários
class Funcionario(Pessoa):
    acesso = models.ForeignKey(Acesso, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.nome} - {self.acesso.nome}"

    class Meta:
        verbose_name = verbose_name_plural = 'Funcionario'



# Tabela para armazenar as Transportadoras
class Transportadora(models.Model):
    nome = models.CharField(max_length=100)
    cnpj = models.CharField(max_length=20, unique=True)
    inscricao_estadual = models.CharField(max_length=100, unique=True)
    telefone = models.CharField(max_length=20)
    email = models.EmailField(max_length=100, unique=True)
    preco_km = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    endereco = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Transportadora'


# Tabela de Chamados
class Chamado(models.Model):
    class EstadoChoices(models.TextChoices):
        ABERTO = 'ABERTO', 'Aberto'
        EM_ANDAMENTO = 'EM_ANDAMENTO', 'Em Andamento'
        RESOLVIDO = 'RESOLVIDO', 'Resolvido'
        CANCELADO = 'CANCELADO', 'Cancelado'

    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    funcionario = models.ForeignKey(Funcionario, on_delete=models.CASCADE)
    titulo = models.CharField(max_length=50)
    descricao = models.TextField()
    estado = models.CharField(
        max_length=15,
        choices=EstadoChoices.choices,
        default=EstadoChoices.ABERTO
    )
    data_criacao = models.DateTimeField(auto_now_add=True)
    data_finalizacao = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.titulo

    class Meta:
        verbose_name = verbose_name_plural = 'Chamado'


# Tabela para registrar mensagens em chamados
class Mensagem(models.Model):
    chamado = models.ForeignKey(Chamado, on_delete=models.CASCADE)
    remetente = models.ForeignKey(Pessoa, on_delete=models.CASCADE)
    texto = models.TextField()
    data_envio = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Mensagem de {self.remetente.nome} em {self.data_envio}"

    class Meta:
        verbose_name = verbose_name_plural = 'Mensagem'


# Tabela para armazenar formas de pagamento
class FormaPagamento(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        verbose_name = verbose_name_plural = 'FormaPagamento'


# Tabela para armazenar detalhes específicos do PIX
class Pix(models.Model):
    forma_pagamento = models.OneToOneField(FormaPagamento, on_delete=models.CASCADE, primary_key=True)
    chave = models.CharField(max_length=100)

    class Meta:
        verbose_name = verbose_name_plural = 'Pix'


# Tabela para armazenar detalhes específicos do Cartão de Crédito
class Cartao(models.Model):
    class TipoChoices(models.TextChoices):
        DEBITO = 'DEBITO', 'Débito'
        CREDITO = 'CREDITO', 'Crédito'

    forma_pagamento = models.OneToOneField(FormaPagamento, on_delete=models.CASCADE, primary_key=True)
    numero = models.CharField(max_length=20)
    validade = models.DateField()
    codigo_seguranca = models.CharField(max_length=10)
    nome_dono = models.CharField(max_length=100)
    tipo = models.CharField(
        max_length=7,
        choices=TipoChoices.choices,
    )

    class Meta:
        verbose_name = verbose_name_plural = 'Cartao'


# Tabela para armazenar endereços dos usuários
class Endereco(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    rua = models.CharField(max_length=100, null=True, blank=True)
    numero = models.CharField(max_length=8, null=True, blank=True)
    bairro = models.CharField(max_length=100, null=True, blank=True)
    cidade = models.CharField(max_length=100, null=True, blank=True)
    estado = models.CharField(max_length=100, null=True, blank=True)
    cep = models.CharField(max_length=20, null=True, blank=True)
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
    categorias = models.ManyToManyField('Categoria', through='ProdutoCategoria')

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Produto'


# Tabela para armazenar o Estoque dos Produtos
class Estoque(models.Model):
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()
    localizacao = models.CharField(max_length=70, null=True, blank=True)

    class Meta:
        verbose_name = verbose_name_plural = 'Endereco'


# Tabela para armazenar as Categorias
class Categoria(models.Model):
    nome = models.CharField(max_length=50)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Categoria'


# Tabela de associação N:N entre Produtos e Categorias
class ProdutoCategoria(models.Model):
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)

    class Meta:
        verbose_name = verbose_name_plural = 'ProdutoCategoria'

# Tabela para armazenar as Listas de Desejos
class ListaDesejos(models.Model):
    usuario = models.OneToOneField(Usuario, on_delete=models.CASCADE, primary_key=True)
    produtos = models.ManyToManyField(Produto)

    class Meta:
        verbose_name = verbose_name_plural = 'ListaDesejos'


# Tabela para armazenar os Carrinhos de Compras de cada Usuário
class Carrinho(models.Model):
    usuario = models.OneToOneField(Usuario, on_delete=models.CASCADE, primary_key=True)
    produtos = models.ManyToManyField(Produto, through='CarrinhoProduto')

    class Meta:
        verbose_name = verbose_name_plural = 'Carrinho'

# Tabela de associação N:N entre Carrinhos e Produtos
class CarrinhoProduto(models.Model):
    carrinho = models.ForeignKey(Carrinho, on_delete=models.CASCADE)
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()

    class Meta:
        verbose_name = verbose_name_plural = 'CarrinhoProduto'


# Tabela para armazenar as Compras
class Compra(models.Model):
    usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    endereco = models.ForeignKey(Endereco, on_delete=models.CASCADE)
    data_realizada = models.DateTimeField(auto_now_add=True)
    cupons = models.ManyToManyField('Cupom', through='CupomCompra')

    def __str__(self):
        return f"Compra #{self.id} - {self.usuario.nome}"

    class Meta:
        verbose_name = verbose_name_plural = 'Compra'


# Tabela para armazenar os produtos comprados em cada compra
class CompraProduto(models.Model):
    compra = models.ForeignKey(Compra, on_delete=models.CASCADE)
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE)
    quantidade = models.PositiveIntegerField()

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


# Tabela de rastreamento de compras, com relação 1:1 com tb_compra_produto
class Entrega(models.Model):
    class EstadoChoices(models.TextChoices):
        AGUARDANDO_PAGAMENTO_COMPRA = 'AGUARDANDO_PAGAMENTO_COMPRA', 'Aguardando Pagamento da Compra'
        EM_PREPARO = 'EM_PREPARO', 'Em Preparo'
        POSTADO = 'POSTADO', 'Postado'
        EM_TRANSITO = 'EM_TRANSITO', 'Em Trânsito'
        ENTREGUE = 'ENTREGUE', 'Entregue'
        NAO_ENTREGUE = 'NAO_ENTREGUE', 'Não Entregue'
        D_AGUARDANDO_TRANSPORTADORA = 'D_AGUARDANDO_TRANSPORTADORA', 'Devolução Aguardando Transportadora'
        D_EM_TRANSITO = 'D_EM_TRANSITO', 'Devolução em Trânsito'
        DEVOLVIDO = 'DEVOLVIDO', 'Devolvido'

    compra_produto = models.OneToOneField(CompraProduto, on_delete=models.CASCADE, primary_key=True)
    transportadora = models.ForeignKey(Transportadora, on_delete=models.CASCADE)
    codigo_rastreio = models.CharField(max_length=100, null=True, blank=True)
    data_postado = models.DateTimeField(null=True, blank=True)
    data_transito = models.DateTimeField(null=True, blank=True)
    data_recebido = models.DateTimeField(null=True, blank=True)
    data_devolucao_transito = models.DateTimeField(null=True, blank=True)
    data_devolucao_recebido = models.DateTimeField(null=True, blank=True)
    estado = models.CharField(
        max_length=30,
        choices=EstadoChoices.choices,
        null=True,
        blank=True
    )
    finalizada = models.BooleanField(default=False)

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


# Tabela de Cupons
class Cupom(models.Model):
    nome = models.CharField(max_length=100, null=True, blank=True)
    desconto = models.DecimalField(max_digits=10, decimal_places=2)
    data_inicio = models.DateTimeField()
    data_fim = models.DateTimeField()

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = verbose_name_plural = 'Cupom'


# Tabela de associação N:N entre Cupons e Compras
class CupomCompra(models.Model):
    compra = models.ForeignKey(Compra, on_delete=models.CASCADE)
    cupom = models.ForeignKey(Cupom, on_delete=models.CASCADE)

    class Meta:
        verbose_name = verbose_name_plural = 'CupomCompra'
