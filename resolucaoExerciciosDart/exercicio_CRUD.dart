import 'dart:io';

void main() {
  // Mapa para armazenar os contatos
  Map<String, String> contatos = {};

  while (true) {
    // Menu do programa
    print('\n--- Lista de Contatos ---');
    print('1 - Adicionar contato');
    print('2 - Exibir contato');
    print('3 - Atualizar contato');
    print('4 - Remover contato');
    print('5 - Sair');
    stdout.write('Escolha uma opção: ');
    String? escolha = stdin.readLineSync();

    switch (escolha) {
      case '1': // Create
        adicionarContato(contatos);
        break;
      case '2': // Read
        exibirContato(contatos);
        break;
      case '3': // Update
        atualizarContato(contatos);
        break;
      case '4': // Delete
        removerContato(contatos);
        break;
      case '5': // Sair
        print('Encerrando o programa.');
        return;
      default:
        print('Opção inválida. Tente novamente.');
    }
  }
}

// Função para adicionar um contato (Create)
void adicionarContato(Map<String, String> contatos) {
  stdout.write('Digite o nome do contato: ');
  String? nome = stdin.readLineSync();

  if (contatos.containsKey(nome)) {
    print('Contato já existe.');
    return;
  }

  stdout.write('Digite o número de telefone: ');
  String? telefone = stdin.readLineSync();
  contatos[nome!] = telefone!;
  print('Contato adicionado com sucesso.');
}

// Função para exibir um contato (Read)
void exibirContato(Map<String, String> contatos) {
  stdout.write('Digite o nome do contato para exibir: ');
  String? nome = stdin.readLineSync();

  if (contatos.containsKey(nome)) {
    print('Nome: $nome, Telefone: ${contatos[nome]}');
  } else {
    print('Contato não encontrado.');
  }
}

// Função para atualizar um contato (Update)
void atualizarContato(Map<String, String> contatos) {
  stdout.write('Digite o nome do contato para atualizar: ');
  String? nome = stdin.readLineSync();

  if (contatos.containsKey(nome)) {
    stdout.write('Digite o novo número de telefone: ');
    String? novoTelefone = stdin.readLineSync();
    contatos[nome!] = novoTelefone!;
    print('Contato atualizado com sucesso.');
  } else {
    print('Contato não encontrado.');
  }
}

// Função para remover um contato (Delete)
void removerContato(Map<String, String> contatos) {
  stdout.write('Digite o nome do contato para remover: ');
  String? nome = stdin.readLineSync();

  if (contatos.containsKey(nome)) {
    contatos.remove(nome);
    print('Contato removido com sucesso.');
  } else {
    print('Contato não encontrado.');
  }
}
