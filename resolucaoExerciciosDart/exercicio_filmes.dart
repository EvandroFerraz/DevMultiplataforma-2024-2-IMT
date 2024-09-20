import 'dart:io';

void main(List<String> arguments) {
  // Lista de filmes, onde cada filme é representado por um mapa
  var filmes = <Map<String, dynamic>>[];

  while (true) {
    print("\nMenu:");
    print("1. Adicionar filme");
    print("2. Remover filme");
    print("3. Visualizar filmes");
    print("4. Atualizar filme");
    print("5. Ver média de avaliações");
    print("6. Adicionar avaliação");
    print("0. Sair");
    print("Escolha uma opção:");

    String? escolha = stdin.readLineSync();

    switch (escolha) {
      case '1':
        adicionarFilme(filmes);
        break;
      case '2':
        removerFilme(filmes);
        break;
      case '3':
        visualizarFilmes(filmes);
        break;
      case '4':
        atualizarFilme(filmes);
        break;
      case '5':
        verMediaAvaliacoes(filmes);
        break;
      case '6':
        adicionarAvaliacao(filmes);
        break;
      case '0':
        print("Saindo...");
        return;
      default:
        print("Opção inválida.");
    }
  }
}

void adicionarFilme(List<Map<String, dynamic>> filmes) {
  print("Título do filme:");
  String? titulo = stdin.readLineSync();

  // Verifica se o título já existe na lista de filmes
  var filmeExistente = filmes.any((filme) => filme['titulo'] == titulo);

  if (filmeExistente) {
    print("Um filme com esse título já existe. Escolha um título diferente.");
    return; // Sai da função sem adicionar o filme
  }

  print("Gênero do filme:");
  String? genero = stdin.readLineSync();
  
  // Inicializa a lista de avaliações como uma lista vazia e explicitamente do tipo correto
  filmes.add({'titulo': titulo, 'genero': genero, 'avaliacoes': <Map<String, dynamic>>[]});
  print("Filme adicionado com sucesso!");
}

void removerFilme(List<Map<String, dynamic>> filmes) {
  print("Informe o título do filme a ser removido:");
  String? titulo = stdin.readLineSync();

  filmes.removeWhere((filme) => filme['titulo'] == titulo);
  print("Filme removido com sucesso!");
}

void visualizarFilmes(List<Map<String, dynamic>> filmes) {
  if (filmes.isEmpty) {
    print("Nenhum filme cadastrado.");
    return;
  }

  for (var filme in filmes) {
    print("Título: ${filme['titulo']}, Gênero: ${filme['genero']}");
    if ((filme['avaliacoes'] as List).isEmpty) {
      print("Nenhuma avaliação registrada.");
    } else {
      print("Avaliações:");
      for (var avaliacao in filme['avaliacoes']) {
        print("- ${avaliacao['nome']}: Nota ${avaliacao['nota']}");
      }
    }
  }
}

void atualizarFilme(List<Map<String, dynamic>> filmes) {
  print("Informe o título do filme a ser atualizado:");
  String? titulo = stdin.readLineSync();

  var filme = filmes.firstWhere((filme) => filme['titulo'] == titulo, orElse: () => {});
  if (filme.isEmpty) {
    print("Filme não encontrado.");
    return;
  }

  print("Novo título (pressione Enter para manter o atual):");
  String? novoTitulo = stdin.readLineSync();
  print("Novo gênero (pressione Enter para manter o atual):");
  String? novoGenero = stdin.readLineSync();

  if (novoTitulo != null && novoTitulo.isNotEmpty) {
    filme['titulo'] = novoTitulo;
  }
  if (novoGenero != null && novoGenero.isNotEmpty) {
    filme['genero'] = novoGenero;
  }

  print("Filme atualizado com sucesso!");
}

void verMediaAvaliacoes(List<Map<String, dynamic>> filmes) {
  print("Informe o título do filme para ver a média de avaliações:");
  String? titulo = stdin.readLineSync();

  var filme = filmes.firstWhere((filme) => filme['titulo'] == titulo, orElse: () => {});
  if (filme.isEmpty) {
    print("Filme não encontrado.");
    return;
  }

  var avaliacoes = filme['avaliacoes'] as List<Map<String, dynamic>>;
  if (avaliacoes.isEmpty) {
    print("Nenhuma avaliação registrada.");
    return;
  }

  double media = avaliacoes.fold(0.0, (soma, avaliacao) => soma + (avaliacao['nota'] as num)) / avaliacoes.length;
  print("Média de avaliações para '$titulo': ${media.toStringAsFixed(2)}");
}

void adicionarAvaliacao(List<Map<String, dynamic>> filmes) {
  print("Informe o título do filme para adicionar uma avaliação:");
  String? titulo = stdin.readLineSync();

  var filme = filmes.firstWhere((filme) => filme['titulo'] == titulo, orElse: () => {});
  if (filme.isEmpty) {
    print("Filme não encontrado.");
    return;
  }

  // Aqui garantimos que 'avaliacoes' seja tratada como uma lista de mapas do tipo correto
  var avaliacoes = filme['avaliacoes'] as List<Map<String, dynamic>>;

  print("Informe seu nome:");
  String? nome = stdin.readLineSync();
  
  // Verifica se o nome já foi utilizado
  if (avaliacoes.any((avaliacao) => avaliacao['nome'] == nome)) {
    print("Já existe uma avaliação feita por '$nome'.");
    return;
  }

  print("Informe sua nota (0 a 10):");
  double? nota = double.tryParse(stdin.readLineSync() ?? '');

  if (nota == null || nota < 0 || nota > 10) {
    print("Nota inválida. A avaliação deve ser entre 0 e 10.");
    return;
  }

  // Adiciona a nova avaliação com o nome e a nota
  avaliacoes.add({'nome': nome, 'nota': nota});
  print("Avaliação adicionada com sucesso!");
}
