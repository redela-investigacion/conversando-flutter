import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PhraseSelectorWidget extends StatelessWidget {
  FlutterTts _tts;

  PhraseSelectorWidget(this._tts);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      //key: PageStorageKey<Entry>(root),
      title: Text('Categorías de frases'),
      children: [
        ExpansionTile(
          title: Text('😍 Saludos'),
          children: [
            new PhraseWidget(this._tts, 'Hola'),
            new PhraseWidget(this._tts, '¿Qué pasa?'),
          ],
        ),
        ExpansionTile(
          title: Text('🌎 En casa'),
          children: [
            new PhraseWidget(
                this._tts, '¿Puedes subir el volumen de la televisión?'),
            new PhraseWidget(this._tts,
                'Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?'),
            new PhraseWidget(this._tts, 'Por favor, traeme un vaso de agua')
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
  FlutterTts _tts;

  PhraseWidget(this._tts, this._text);

  @override
  Widget build(context) {
    return new ListTile(
        title: Text(this._text),
        onTap: () {
          this._tts.speak(this._text);
        });
  }
}
