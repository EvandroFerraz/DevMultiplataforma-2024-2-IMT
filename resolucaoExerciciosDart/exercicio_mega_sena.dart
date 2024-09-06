import 'dart:io';
import 'dart:math';

void main() {
  // Função para gerar um número aleatório
  int gerarNumeroAleatorio() {
    return Random().nextInt(60) + 1; // Gera um número entre 1 e 60
  }

  // Função para ler os números escolhidos pelo usuário
  List<int> obterJogoUsuario() {
    List<int> jogoUsuario = [];
    print('Digite 6 números da Mega-Sena (entre 1 e 60):');

    while (jogoUsuario.length < 6) {
      int numero = int.parse(stdin.readLineSync()!);
      if (numero < 1 || numero > 60) {
        print('Número inválido. Por favor, insira um número entre 1 e 60.');
      } else if (jogoUsuario.contains(numero)) {
        print('Número repetido. Por favor, insira um número diferente.');
      } else {
        jogoUsuario.add(numero);
      }
    }

    return jogoUsuario;
  }

  // Função para gerar o jogo da Mega-Sena aleatoriamente
  List<int> gerarJogoAleatorio() {
    List<int> jogoAleatorio = [];
    while (jogoAleatorio.length < 6) {
      int numero = gerarNumeroAleatorio();
      if (!jogoAleatorio.contains(numero)) {
        jogoAleatorio.add(numero);
      }
    }
    return jogoAleatorio;
  }

  // Obter jogo do usuário
  List<int> jogoUsuario = obterJogoUsuario();

  // Gerar jogo aleatório
  List<int> jogoAleatorio = gerarJogoAleatorio();

  // Ordenar os jogos
  jogoUsuario.sort();
  jogoAleatorio.sort();

  // Mostrar os jogos lado a lado
  print('\nSeu jogo: $jogoUsuario');
  print('Jogo gerado: $jogoAleatorio');

  // Encontrar os números acertados
  List<int> acertos =
      jogoUsuario.where((numero) => jogoAleatorio.contains(numero)).toList();

  // Mostrar os números acertados
  if (acertos.isNotEmpty) {
    print('Você acertou os seguintes números: $acertos');
  } else {
    print('Você não acertou nenhum número.');
  }
}
