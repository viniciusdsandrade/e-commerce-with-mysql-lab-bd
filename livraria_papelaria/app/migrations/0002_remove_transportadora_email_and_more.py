# Generated by Django 5.1.1 on 2024-12-04 14:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='transportadora',
            name='email',
        ),
        migrations.RemoveField(
            model_name='transportadora',
            name='endereco',
        ),
        migrations.RemoveField(
            model_name='transportadora',
            name='telefone',
        ),
    ]
