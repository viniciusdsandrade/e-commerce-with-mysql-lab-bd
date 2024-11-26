# Generated by Django 5.1.1 on 2024-11-26 00:37

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name='chamado',
            name='usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='compra',
            name='usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='formapagamento',
            name='usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='carrinho',
            name='usuario',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='listadesejos',
            name='usuario',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='endereco',
            name='usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterModelOptions(
            name='acesso',
            options={'verbose_name': 'Acesso', 'verbose_name_plural': 'Acesso'},
        ),
        migrations.AlterModelOptions(
            name='avaliacao',
            options={'verbose_name': 'Avaliacao', 'verbose_name_plural': 'Avaliacao'},
        ),
        migrations.AlterModelOptions(
            name='carrinho',
            options={'verbose_name': 'Carrinho', 'verbose_name_plural': 'Carrinho'},
        ),
        migrations.AlterModelOptions(
            name='carrinhoproduto',
            options={'verbose_name': 'CarrinhoProduto', 'verbose_name_plural': 'CarrinhoProduto'},
        ),
        migrations.AlterModelOptions(
            name='cartao',
            options={'verbose_name': 'Cartao', 'verbose_name_plural': 'Cartao'},
        ),
        migrations.AlterModelOptions(
            name='categoria',
            options={'verbose_name': 'Categoria', 'verbose_name_plural': 'Categoria'},
        ),
        migrations.AlterModelOptions(
            name='chamado',
            options={'verbose_name': 'Chamado', 'verbose_name_plural': 'Chamado'},
        ),
        migrations.AlterModelOptions(
            name='compra',
            options={'verbose_name': 'Compra', 'verbose_name_plural': 'Compra'},
        ),
        migrations.AlterModelOptions(
            name='compraproduto',
            options={'verbose_name': 'CompraProduto', 'verbose_name_plural': 'CompraProduto'},
        ),
        migrations.AlterModelOptions(
            name='cupom',
            options={'verbose_name': 'Cupom', 'verbose_name_plural': 'Cupom'},
        ),
        migrations.AlterModelOptions(
            name='cupomcompra',
            options={'verbose_name': 'CupomCompra', 'verbose_name_plural': 'CupomCompra'},
        ),
        migrations.AlterModelOptions(
            name='endereco',
            options={'verbose_name': 'Endereco', 'verbose_name_plural': 'Endereco'},
        ),
        migrations.AlterModelOptions(
            name='entrega',
            options={'verbose_name': 'Entrega', 'verbose_name_plural': 'Entrega'},
        ),
        migrations.AlterModelOptions(
            name='estoque',
            options={'verbose_name': 'Estoque', 'verbose_name_plural': 'Estoque'},
        ),
        migrations.AlterModelOptions(
            name='formapagamento',
            options={'verbose_name': 'FormaPagamento', 'verbose_name_plural': 'FormaPagamento'},
        ),
        migrations.AlterModelOptions(
            name='funcionario',
            options={'verbose_name': 'Funcionario', 'verbose_name_plural': 'Funcionario'},
        ),
        migrations.AlterModelOptions(
            name='listadesejos',
            options={'verbose_name': 'ListaDesejos', 'verbose_name_plural': 'ListaDesejos'},
        ),
        migrations.AlterModelOptions(
            name='mensagem',
            options={'verbose_name': 'Mensagem', 'verbose_name_plural': 'Mensagem'},
        ),
        migrations.AlterModelOptions(
            name='pessoa',
            options={'verbose_name': 'Pessoa', 'verbose_name_plural': 'Pessoa'},
        ),
        migrations.AlterModelOptions(
            name='pix',
            options={'verbose_name': 'Pix', 'verbose_name_plural': 'Pix'},
        ),
        migrations.AlterModelOptions(
            name='produto',
            options={'verbose_name': 'Produto', 'verbose_name_plural': 'Produto'},
        ),
        migrations.AlterModelOptions(
            name='produtocategoria',
            options={'verbose_name': 'ProdutoCategoria', 'verbose_name_plural': 'ProdutoCategoria'},
        ),
        migrations.AlterModelOptions(
            name='promocao',
            options={'verbose_name': 'Promocao', 'verbose_name_plural': 'Promocao'},
        ),
        migrations.AlterModelOptions(
            name='promocaoproduto',
            options={'verbose_name': 'PromocaoProduto', 'verbose_name_plural': 'PromocaoProduto'},
        ),
        migrations.AlterModelOptions(
            name='transportadora',
            options={'verbose_name': 'Transportadora', 'verbose_name_plural': 'Transportadora'},
        ),
        migrations.DeleteModel(
            name='Usuario',
        ),
    ]
