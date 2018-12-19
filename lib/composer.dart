import 'package:conversando/phraseSelector.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class ComposerWidget extends StatelessWidget {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextContext tc = TextContext.of(context);

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
                tc.speak(this._textController.text, context);
                //this.notify(this._textController.text);
              },
            ),
          )
        ]),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              icon: Icon(Icons.keyboard),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ])
        ]),
        new PhraseSelectorWidget(),
      ]),
    );
  }
}
