import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() quadoReiniciarQuestionario;

  Resultado(this.pontuacao, this.quadoReiniciarQuestionario);

  String get mensagemResultado {
    if (pontuacao < 8) {
      return 'Parabéns (nota: ${pontuacao})';
    } else if (pontuacao < 12) {
      return 'Você é bom (nota: ${pontuacao})';
    } else if (pontuacao < 16) {
      return 'Impressionante (nota: ${pontuacao})';
    } else {
      return 'Nível Jedi (nota: ${pontuacao})';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            this.mensagemResultado,
            style: TextStyle(fontSize: 28),
          ),
        ),
        FlatButton(
          child: Text(
            'Reiniciar?',
            style: TextStyle(fontSize: 18),
          ),
          textColor: Colors.blue,
          onPressed: this.quadoReiniciarQuestionario,
        )
      ],
    );
  }
}
