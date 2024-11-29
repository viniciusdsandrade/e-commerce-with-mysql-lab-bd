# Generated by Django 5.1.1 on 2024-11-29 20:44

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='CompraProduto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantidade', models.PositiveIntegerField()),
            ],
            options={
                'verbose_name': 'CompraProduto',
                'verbose_name_plural': 'CompraProduto',
            },
        ),
        migrations.CreateModel(
            name='Carrinho',
            fields=[
                ('usuario', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Carrinho',
                'verbose_name_plural': 'Carrinho',
            },
        ),
        migrations.CreateModel(
            name='FormaPagamento',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'FormaPagamento',
                'verbose_name_plural': 'FormaPagamento',
            },
        ),
        migrations.CreateModel(
            name='Categoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(max_length=50)),
                ('tipo', models.CharField(choices=[('LIVRARIA', 'Livraria'), ('PAPELARIA', 'Papelaria')], max_length=15, null=True)),
            ],
            options={
                'verbose_name': 'Categoria',
                'verbose_name_plural': 'Categoria',
            },
        ),
        migrations.CreateModel(
            name='Compra',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('data_realizada', models.DateTimeField(auto_now_add=True)),
                ('usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Compra',
                'verbose_name_plural': 'Compra',
            },
        ),
        migrations.CreateModel(
            name='Cupom',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(blank=True, max_length=100, null=True)),
                ('desconto', models.DecimalField(decimal_places=2, max_digits=10)),
                ('data_inicio', models.DateTimeField()),
                ('data_fim', models.DateTimeField()),
            ],
            options={
                'verbose_name': 'Cupom',
                'verbose_name_plural': 'Cupom',
            },
        ),
        migrations.CreateModel(
            name='Produto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(max_length=50)),
                ('preco', models.DecimalField(decimal_places=2, max_digits=10)),
                ('descricao', models.TextField(blank=True, null=True)),
                ('is_ativo', models.BooleanField(default=True)),
            ],
            options={
                'verbose_name': 'Produto',
                'verbose_name_plural': 'Produto',
            },
        ),
        migrations.CreateModel(
            name='Promocao',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(blank=True, max_length=100, null=True)),
                ('data_inicio', models.DateTimeField()),
                ('data_fim', models.DateTimeField()),
            ],
            options={
                'verbose_name': 'Promocao',
                'verbose_name_plural': 'Promocao',
            },
        ),
        migrations.CreateModel(
            name='Transportadora',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(max_length=100)),
                ('cnpj', models.CharField(max_length=20, unique=True)),
                ('inscricao_estadual', models.CharField(max_length=100, unique=True)),
                ('telefone', models.CharField(max_length=20)),
                ('email', models.EmailField(max_length=100, unique=True)),
                ('preco_km', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('endereco', models.CharField(blank=True, max_length=100, null=True)),
            ],
            options={
                'verbose_name': 'Transportadora',
                'verbose_name_plural': 'Transportadora',
            },
        ),
        migrations.CreateModel(
            name='Avaliacao',
            fields=[
                ('compra_produto', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.compraproduto')),
                ('nota', models.CharField(blank=True, choices=[('⭐', '⭐'), ('⭐⭐', '⭐⭐'), ('⭐⭐⭐', '⭐⭐⭐'), ('⭐⭐⭐⭐', '⭐⭐⭐⭐'), ('⭐⭐⭐⭐⭐', '⭐⭐⭐⭐⭐')], max_length=5, null=True)),
                ('comentario', models.TextField(blank=True, null=True)),
            ],
            options={
                'verbose_name': 'Avaliacao',
                'verbose_name_plural': 'Avaliacao',
            },
        ),
        migrations.CreateModel(
            name='Cartao',
            fields=[
                ('forma_pagamento', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.formapagamento')),
                ('numero', models.CharField(max_length=20)),
                ('validade', models.DateField()),
                ('codigo_seguranca', models.CharField(max_length=10)),
                ('nome_dono', models.CharField(max_length=100)),
                ('tipo', models.CharField(choices=[('DEBITO', 'Débito'), ('CREDITO', 'Crédito')], max_length=7)),
            ],
            options={
                'verbose_name': 'Cartao',
                'verbose_name_plural': 'Cartao',
            },
        ),
        migrations.CreateModel(
            name='Pix',
            fields=[
                ('forma_pagamento', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.formapagamento')),
                ('chave', models.CharField(max_length=100)),
            ],
            options={
                'verbose_name': 'Pix',
                'verbose_name_plural': 'Pix',
            },
        ),
        migrations.AddField(
            model_name='compraproduto',
            name='compra',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.compra'),
        ),
        migrations.CreateModel(
            name='CupomCompra',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('compra', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.compra')),
                ('cupom', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.cupom')),
            ],
            options={
                'verbose_name': 'CupomCompra',
                'verbose_name_plural': 'CupomCompra',
            },
        ),
        migrations.AddField(
            model_name='compra',
            name='cupons',
            field=models.ManyToManyField(through='app.CupomCompra', to='app.cupom'),
        ),
        migrations.CreateModel(
            name='Endereco',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nome', models.CharField(max_length=20, null=True)),
                ('rua', models.CharField(max_length=100, null=True)),
                ('numero', models.CharField(max_length=8, null=True)),
                ('bairro', models.CharField(max_length=100, null=True)),
                ('cidade', models.CharField(max_length=100, null=True)),
                ('estado', models.CharField(max_length=100, null=True)),
                ('cep', models.CharField(max_length=20, null=True)),
                ('complemento', models.CharField(blank=True, max_length=50, null=True)),
                ('is_principal', models.BooleanField(default=False)),
                ('usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Endereco',
                'verbose_name_plural': 'Endereco',
            },
        ),
        migrations.AddField(
            model_name='compra',
            name='endereco',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.endereco'),
        ),
        migrations.CreateModel(
            name='ListaDesejos',
            fields=[
                ('usuario', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('produtos', models.ManyToManyField(to='app.produto')),
            ],
            options={
                'verbose_name': 'ListaDesejos',
                'verbose_name_plural': 'ListaDesejos',
            },
        ),
        migrations.CreateModel(
            name='Estoque',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantidade', models.PositiveIntegerField()),
                ('localizacao', models.CharField(blank=True, max_length=70, null=True)),
                ('produto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.produto')),
            ],
            options={
                'verbose_name': 'Estoque',
                'verbose_name_plural': 'Estoque',
            },
        ),
        migrations.AddField(
            model_name='compraproduto',
            name='produto',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.produto'),
        ),
        migrations.CreateModel(
            name='CarrinhoProduto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantidade', models.PositiveIntegerField()),
                ('carrinho', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.carrinho')),
                ('produto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.produto')),
            ],
            options={
                'verbose_name': 'CarrinhoProduto',
                'verbose_name_plural': 'CarrinhoProduto',
            },
        ),
        migrations.AddField(
            model_name='carrinho',
            name='produtos',
            field=models.ManyToManyField(through='app.CarrinhoProduto', to='app.produto'),
        ),
        migrations.CreateModel(
            name='ProdutoCategoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('categoria', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.categoria')),
                ('produto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.produto')),
            ],
            options={
                'verbose_name': 'ProdutoCategoria',
                'verbose_name_plural': 'ProdutoCategoria',
            },
        ),
        migrations.AddField(
            model_name='produto',
            name='categorias',
            field=models.ManyToManyField(through='app.ProdutoCategoria', to='app.categoria'),
        ),
        migrations.CreateModel(
            name='PromocaoProduto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('desconto', models.DecimalField(decimal_places=2, max_digits=10)),
                ('produto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.produto')),
                ('promocao', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.promocao')),
            ],
            options={
                'verbose_name': 'PromocaoProduto',
                'verbose_name_plural': 'PromocaoProduto',
                'unique_together': {('produto', 'promocao')},
            },
        ),
        migrations.AddField(
            model_name='promocao',
            name='produtos',
            field=models.ManyToManyField(through='app.PromocaoProduto', to='app.produto'),
        ),
        migrations.CreateModel(
            name='Entrega',
            fields=[
                ('compra_produto', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='app.compraproduto')),
                ('codigo_rastreio', models.CharField(blank=True, max_length=100, null=True)),
                ('data_postado', models.DateTimeField(blank=True, null=True)),
                ('data_transito', models.DateTimeField(blank=True, null=True)),
                ('data_recebido', models.DateTimeField(blank=True, null=True)),
                ('data_devolucao_transito', models.DateTimeField(blank=True, null=True)),
                ('data_devolucao_recebido', models.DateTimeField(blank=True, null=True)),
                ('estado', models.CharField(blank=True, choices=[('AGUARDANDO_PAGAMENTO_COMPRA', 'Aguardando Pagamento da Compra'), ('EM_PREPARO', 'Em Preparo'), ('POSTADO', 'Postado'), ('EM_TRANSITO', 'Em Trânsito'), ('ENTREGUE', 'Entregue'), ('NAO_ENTREGUE', 'Não Entregue'), ('D_AGUARDANDO_TRANSPORTADORA', 'Devolução Aguardando Transportadora'), ('D_EM_TRANSITO', 'Devolução em Trânsito'), ('DEVOLVIDO', 'Devolvido')], max_length=30, null=True)),
                ('finalizada', models.BooleanField(default=False)),
                ('transportadora', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.transportadora')),
            ],
            options={
                'verbose_name': 'Entrega',
                'verbose_name_plural': 'Entrega',
            },
        ),
        migrations.AlterUniqueTogether(
            name='compraproduto',
            unique_together={('compra', 'produto')},
        ),
    ]
