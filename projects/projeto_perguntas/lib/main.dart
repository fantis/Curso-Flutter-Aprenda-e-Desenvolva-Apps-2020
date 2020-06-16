import 'package:flutter/material.dart';
import 'package:projeto_perguntas/resultado.dart';
import './questionario.dart';

main() => runApp(new PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 5},
        {'texto': 'Vernelho', 'pontuacao': 7},
        {'texto': 'Verde', 'pontuacao': 10},
        {'texto': 'Branco', 'pontuacao': 4},
      ],
    },
    {
      'texto': 'Qual é seu animal favorito?',
      'respostas': [
        {'texto': 'Cobra', 'pontuacao': 1},
        {'texto': 'Elefante', 'pontuacao': 6},
        {'texto': 'Leão', 'pontuacao': 9},
        {'texto': 'Canarinho', 'pontuacao': 4},
        {'texto': 'Coelho', 'pontuacao': 7},
      ],
    },
    {
      'texto': 'Qual é seu instrutor favorito?',
      'respostas': [
        {'texto': 'Maria', 'pontuacao': 7},
        {'texto': 'João', 'pontuacao': 4},
        {'texto': 'José', 'pontuacao': 2},
        {'texto': 'Simone', 'pontuacao': 10},
      ],
    }
  ];

  // Questionario questionario;

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
    ;
    print('Pontuacao total: ${_pontuacaoTotal}');
  }

  void _reiniciarQuestionario() {
    setState(() {
      this._perguntaSelecionada = 0;
      this._pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    // this.questionario = new Questionario(_perguntaSelecionada, _responder);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Perguntas Rubens'),
          ),
          body: temPerguntaSelecionada
              ? Questionario(
                  perguntas: this._perguntas,
                  perguntaSelecionada: this._perguntaSelecionada,
                  quandoResponder: this._responder,
                )
              : Resultado(this._pontuacaoTotal, this._reiniciarQuestionario)),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return new _PerguntaAppState();
  }
}
