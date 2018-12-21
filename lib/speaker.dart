import 'package:conversando/selectPhrase.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class SpeakerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    return Column(children: [
      Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              children: <Widget>[
                new QuickSpeakWidget("Sí"),
                new QuickSpeakWidget("No"),
                new QuickSpeakWidget("Perdona"),
                new QuickSpeakWidget("Hola"),
                new QuickSpeakWidget("Bien"),
                new QuickSpeakWidget("Gracias")
            // 4 Text Fields here
          ])),
      new ExpansionPhraseSelector(),
    ]);
  }
}
s
class QuickSpeakWidget extends StatelessWidget {
  final String _label;

  QuickSpeakWidget(this._label);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new OutlineButton(
        child: new Text(
          this._label,
          style: new TextStyle(color: new Color(0xFF2A2A2A))
        ),
        onPressed: () {
          tc.speak(this._label, context);
        });
  }
}
