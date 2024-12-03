from .models import Categoria, Produto


def categorias_processor(request):
    categorias = Categoria.objects.all()
    categorias_livraria = categorias.filter(tipo='LIVRARIA')
    categorias_papelaria = categorias.filter(tipo='PAPELARIA')
    categorias = categorias[:10]

    return {
        'categorias': categorias,
        'categorias_livraria': categorias_livraria,
        'categorias_papelaria': categorias_papelaria
    }

def produtos_processor(request, produtos=None):
    if produtos is None:
        produtos = Produto.objects.all()

    for produto in produtos:
        produto.tem_promocao = False

        if produto.promocaoproduto_set.all():
            produto.tem_promocao = True
            produto.desconto = produto.promocaoproduto_set.all()[0].desconto
            produto.preco_sem_desconto = produto.preco
            produto.preco = round(produto.preco * (1 - produto.desconto), 2)
            produto.desconto = round(produto.desconto * 100)

        produto.nota = 'Sem avaliações'
        notas = []
        produto.avaliacoes = []

        for compraproduto in produto.compraproduto_set.all():
            if hasattr(compraproduto, 'avaliacao'):
                notas.append(len(compraproduto.avaliacao.nota))
                produto.avaliacoes.append(compraproduto.avaliacao)

        if notas:
            nota_media = round(sum(notas) / len(notas))
            produto.nota = '⭐' * nota_media

        produto.categorias = produto.categoria_set.all()

    return {'produtos': produtos}
