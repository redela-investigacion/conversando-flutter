import 'package:conversando/phraseSelector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ComposerWidget extends StatefulWidget {
  FlutterTts _tts;

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
    return Container(
      child: Column(children: [
        Expanded(
          child: TextField(
            maxLines: null,
            controller: this._textController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Tu texto aquí'),
            onChanged: (String value) {
              this._textController.text = value;
            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              child: Icon(Icons.volume_up),
              backgroundColor: Colors.pink,
              onPressed: () {
                this._tts.speak(this._textController.text);
              },
            ),
          )
        ]),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            ),
          ])
        ]),
        new PhraseSelectorWidget(this._tts),
      ]),
    );
  }
}
