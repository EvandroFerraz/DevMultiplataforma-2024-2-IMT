import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaPrevisao(),
    );
  }
}

class PaginaPrevisao extends StatefulWidget {
  @override
  _PaginaPrevisaoState createState() => _PaginaPrevisaoState();
}

class _PaginaPrevisaoState extends State<PaginaPrevisao> {
  String _nomeCidade = '';
  List _previsoes = [];

  Future<void> _buscarPrevisao() async {
    String chaveApi =
        '63f4dfbecdd91589320d92d318136114'; // Substitua com sua chave da API
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$_nomeCidade&appid=$chaveApi&units=metric&cnt=10';

    final resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      final dados = json.decode(resposta.body);
      setState(() {
        _previsoes = dados['list'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Informe a cidade'),
              onChanged: (valor) {
                _nomeCidade = valor;
              },
            ),
            ElevatedButton(
              onPressed: _buscarPrevisao,
              child: Text('Buscar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _previsoes.length,
                itemBuilder: (context, indice) {
                  final previsao = _previsoes[indice];
                  final tempMin = previsao['main']['temp_min'];
                  final tempMax = previsao['main']['temp_max'];
                  final descricao = previsao['weather'][0]['description'];
                  final icone = previsao['weather'][0]['icon'];
                  final urlIcone =
                      'http://openweathermap.org/img/wn/$icone@2x.png';

                  return ListTile(
                    leading: Image.network(urlIcone),
                    title: Text(descricao),
                    subtitle: Text('Min: $tempMin°C, Max: $tempMax°C'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
