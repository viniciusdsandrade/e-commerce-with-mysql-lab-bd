from .models import Categoria

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