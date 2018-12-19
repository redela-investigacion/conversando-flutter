import 'package:conversando/phraseSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:conversando/context.dart';

class SpeakerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContext tc = TextContext.of(context);
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
                  tc.speak("Sí", context);
                }),
            new RaisedButton(
                child: new Text("No"),
                onPressed: () {
                  tc.speak("No", context);
                }),
            new RaisedButton(
                child: new Text("Hola"),
                onPressed: () {
                  tc.speak("Hola", context);
                }),
            new RaisedButton(
                child: new Text("¿Cómo estás?"),
                onPressed: () {
                  tc.speak("¿Cómo estás?", context);
                }),
            new RaisedButton(
                child: new Text("Bien"),
                onPressed: () {
                  tc.speak("Bien", context);
                }),
            new RaisedButton(
                child: new Text("Gracias"),
                onPressed: () {
                  tc.speak("Gracias", context);
                }),
            // 4 Text Fields here
          ])),
      new PhraseSelectorWidget(),
    ]);
  }
}
