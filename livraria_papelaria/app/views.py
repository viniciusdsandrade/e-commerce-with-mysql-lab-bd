from django.shortcuts import render

def index(request):
    return render(request, 'index.html')

def categorias(request):
    context = {
        'categorias': [ # Aqui tem que fazer uma query no banco de dados
            'Aventura',
            'Romance',
            'Terror',
            'Ficção Científica',
            'Fantasia',
            'Suspense',
            'Drama',
            'Biografia',
            'História',
            'Infantil',
            'Autoajuda',
            'Religião',
            'Quadrinhos',
            'Mangá',
            'Culinária',
            'Arte',
            'Esporte',
            'Música',
            'Cinema',
            'Moda',
            'Arquitetura',
            'Design',
            'Ciência',
            'Tecnologia',
            'Negócios',
        ]
    }

    return render(request, 'categorias.html', context)