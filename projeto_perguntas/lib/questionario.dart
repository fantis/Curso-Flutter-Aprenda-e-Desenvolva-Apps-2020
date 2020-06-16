import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int pontuacao) quandoResponder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.quandoResponder,
  });

  bool temPerguntaSelecionada() {
    return this.perguntaSelecionada < this.perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada()
        ? perguntas[this.perguntaSelecionada]['respostas']
        : null;

    return Column(
      children: <Widget>[
        Questao(perguntas[this.perguntaSelecionada]['texto']),
        ...respostas.map((resp) {
          return Resposta(
              resp['texto'], () => this.quandoResponder(resp['pontuacao']));
        }).toList(),
      ],
    );
  }
}
