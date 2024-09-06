void main(List<String> arguments) {
  // Conjuntos de países onde se fala português e países da Europa
  var portugues = {
    'Brasil',
    'Portugal',
    'Angola',
    'Moçambique',
    'Cabo Verde',
    'Guiné-Bissau',
    'São Tomé e Príncipe',
    'Timor-Leste'
  };
  var europa = {
    'Alemanha',
    'Portugal',
    'Espanha',
    'França',
    'Itália',
    'Reino Unido',
    'Grécia'
  };

  // 1. Todos os países em que se fala português e todos os países da Europa (união)
  var todosPortuguesEuropa = portugues.union(europa);
  print(
      'Todos os países em que se fala português e todos os países da Europa:');
  print(todosPortuguesEuropa);

  // 2. Todos os países em que se fala português e que são europeus (interseção)
  var portuguesesEuropeus = portugues.intersection(europa);
  print('\nTodos os países em que se fala português e que são europeus:');
  print(portuguesesEuropeus);

  // 3. Todos os países em que se fala português e que não são europeus (diferença)
  var portuguesesNaoEuropeus = portugues.difference(europa);
  print('\nTodos os países em que se fala português e que não são europeus:');
  print(portuguesesNaoEuropeus);

  // 4. Todos os países exceto aqueles em que se fala português e que são europeus (complemento)
  var todosExcetoPortuguesesEuropeus =
      todosPortuguesEuropa.difference(portuguesesEuropeus);
  print(
      '\nTodos os países exceto aqueles em que se fala português e que são europeus:');
  print(todosExcetoPortuguesesEuropeus);
}
