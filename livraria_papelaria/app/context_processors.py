from .models import Categoria, Produto


def categorias_processor(request):
    categorias = Categoria.objects.all()
    categorias_livraria = categorias.filter(tipo='LIVRARIA')[:10]
    categorias_papelaria = categorias.filter(tipo='PAPELARIA')[:10]
    categorias = categorias[:10]

    return {
        'categorias': categorias,
        'categorias_livraria': categorias_livraria,
        'categorias_papelaria': categorias_papelaria
    }


def produtos_processor(request, produtos=Produto.objects.all()):
    for produto in produtos:
        produto.tem_promocao = False

        if produto.promocaoproduto_set.all():
            produto.tem_promocao = True
            produto.desconto = produto.promocaoproduto_set.all()[0].desconto
            produto.preco_com_desconto = round(produto.preco * (1 - produto.desconto), 2)
            produto.desconto = round(produto.desconto * 100)

        produto.nota = 'Sem avaliações'
        notas = []

        for compraproduto in produto.compraproduto_set.all():
            if hasattr(compraproduto, 'avaliacao'):
                notas.append(len(compraproduto.avaliacao.nota))

        if notas:
            nota_media = round(sum(notas) / len(notas))
            produto.nota = '⭐' * nota_media

    return {'produtos': produtos}
