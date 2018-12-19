import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class PhraseSelectorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TextContext tc = TextContext.of(context);
    return ExpansionTile(
      //key: PageStorageKey<Entry>(root),
      title: Text('Categorías de frases'),
      children: [
        ExpansionTile(
          title: Text('😍 Saludos'),
          children: [
            new PhraseWidget('Hola'),
            new PhraseWidget('¿Qué pasa?'),
          ],
        ),
        ExpansionTile(
          title: Text('🌎 En casa'),
          children: [
            new PhraseWidget('¿Puedes subir el volumen de la televisión?'),
            new PhraseWidget('Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?'),
            new PhraseWidget('Por favor, traeme un vaso de agua')
          ],
        ),
        ExpansionTile(
          title: Text('😙 Cosas que me gustan'),
          children: [],
        ),
        ExpansionTile(
          title: Text('🌐 Preguntas'),
          children: [],
        ),
      ],
    );
  }
}

class PhraseWidget extends StatelessWidget {
  String _text;

  PhraseWidget(this._text);

  @override
  Widget build(context) {
    final TextContext tc = TextContext.of(context);
    return new ListTile(
        title: Text(this._text),
        onTap: () {
          tc.speak(this._text, context);
        });
  }
}
