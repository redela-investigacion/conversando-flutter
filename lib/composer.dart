import 'package:conversando/phraseSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:conversando/composerField.dart';

class ComposerWidget extends StatefulWidget {
  final FlutterTts _tts;

  ComposerWidget(this._tts);

  @override
  ComposerState createState() => new ComposerState(this._tts);
}

class ComposerState extends State<ComposerWidget> {
  var _textController = new TextEditingController();
  FlutterTts _tts;

  ComposerState(this._tts);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Column(children: [
        Expanded(
          child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
            child: new ComposerFieldWidget(
              this._textController
            )
          )
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: Row(children: [
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.red,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.undo),
              color: Colors.black54,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.black54,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.black26,
              onPressed: () {},
            )
          ])),
        ])
      ])),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              child: Icon(Icons.apps),
              backgroundColor: Colors.cyan,
              onPressed: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              child: Icon(Icons.volume_up),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                this._tts.speak(this._textController.text);
              },
            ),
          )
        ])
      ]),
    ]);
//        new PhraseSelectorWidget(this._tts),
  }
}
