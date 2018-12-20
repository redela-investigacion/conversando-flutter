import 'package:conversando/phrases.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/composerField.dart';
import 'package:conversando/savePhrase.dart';

class ComposerWidget extends StatelessWidget {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return Stack(children: [
      Container(
        child: Column(children: [
          // TextEditor
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 100.0, left: 10.0),
              child: new ComposerFieldWidget(controller: this._textController))
          ),
          // Actions bar
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
                child: Row(children: [
              IconButton(
                icon: Icon(Icons.close),
                color: Colors.red,
                onPressed: tc.clearText,
              ),
              IconButton(
                icon: Icon(Icons.undo),
                color: Colors.black54,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                color: Colors.black54,
                onPressed: () {
                },
              ),
              IconButton(
                icon: Icon(Icons.save),
                color: Colors.black54,
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) => SavePhrase());
                  Navigator.push(context, route);
                },
              )
            ])),
          ])
      ])),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          // Phrases list button
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: 'listPhrasesButton',
              child: Icon(Icons.apps),
              backgroundColor: Colors.cyan,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => FullPagePhraseSelector());
                Navigator.push(context, route);
              },
            ),
          ),
          // Speak button
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: 'speakButton',
              child: Icon(Icons.volume_up),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                tc.speak(tc.getTextPhrase(), context);
              },
            ),
          )
        ])
      ]),
    ]);
//        new PhraseSelectorWidget(this._tts),
  }
}
