import 'package:conversando/phraseSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakerWidget extends StatelessWidget {
  FlutterTts _tts;

  SpeakerWidget(this._tts);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              children: <Widget>[
            new RaisedButton(
                child: new Text("Sí"),
                onPressed: () {
                  _tts.speak("Sí");
                }),
            new RaisedButton(
                child: new Text("No"),
                onPressed: () {
                  _tts.speak("No");
                }),
            new RaisedButton(
                child: new Text("Hola"),
                onPressed: () {
                  _tts.speak("Hola");
                }),
            new RaisedButton(
                child: new Text("¿Cómo estás?"),
                onPressed: () {
                  _tts.speak("¿Cómo estás?");
                }),
            new RaisedButton(
                child: new Text("Bien"),
                onPressed: () {
                  _tts.speak("Bien");
                }),
            new RaisedButton(
                child: new Text("Gracias"),
                onPressed: () {
                  _tts.speak("Gracias");
                }),
            // 4 Text Fields here
          ])),
      new PhraseSelectorWidget(this._tts),
    ]);
  }
}
