import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

final RegExp tokenizerRegExp = RegExp(r"\w+|[.,;:?¿!¡'\-]", caseSensitive: false);

List<String> tokenizer(String text) {
  return tokenizerRegExp.allMatches(text).map((m) => m.group(0)).toList();
}

class ComposerFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool autofocus;

  ComposerFieldWidget({this.controller, this.autofocus: false}):
        assert(controller != null);

  @override
  ComposerFieldState createState() => new ComposerFieldState(this.controller, this.autofocus);
}

class ComposerFieldState extends State<ComposerFieldWidget> {
  TextEditingController controller;
  bool autofocus;

  TextEditingController _textInputController = new TextEditingController();
  TextEditingController _editorTextInputController = new TextEditingController();

  ComposerFieldState(this.controller, this.autofocus);

  _showDialog(String word, int index, TextContextWidgetState tc) async {
    await showDialog<String>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(20.0),
            title: Text('Modifica \"$word\" por...'),
            content: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                          controller: _editorTextInputController,
                          autofocus: true,
                          decoration: new InputDecoration(
                              hintText: 'Tu texto aquí'
                          )
                      )
                  )
                ]
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    setState(() {
                      _editorTextInputController.clear();
                      Navigator.pop(context);
                    });
                  }
              ),
              new FlatButton(
                  child: const Text('GUARDAR'),
                  onPressed: () {
                    setState(() {
                      List<String> newWords = tokenizer(_editorTextInputController.text);
                      tc.replaceWords(index, newWords);
                      controller.text = tc.getText();

                      _editorTextInputController.clear();
                      Navigator.pop(context);
                    });
                  }
              )
            ],
          );
        }
    );
  }

  List<Widget> _getTextWidgets (TextContextWidgetState tc) {
    List<Widget> widgets = [];

    tc.getWords().asMap().forEach((index, word) {
        widgets.add(
            new InputChip(
                label: Text(word),
                onPressed: () {
                  _editorTextInputController.text = word;
                  _showDialog(word, index, tc);
                },
                onDeleted: () {
                  tc.deleteWord(word);
                  controller.text = tc.getText();
                }
            )
        );
      });

      widgets.add(
        new TextField(
          maxLines: null,
          autofocus: autofocus,
          controller: _textInputController,
          decoration: InputDecoration(
            hintText: 'Tu texto aquí'
          ),
          onChanged: (String value) {
            tc.onTextChange(value);
            if (tc.getText() == '') {
              _textInputController.text = '';
            }
          }
        )
      );

      return widgets;
    }

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: new Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 1.0, // gap between lines
              children: _getTextWidgets(tc),
            )
        )
    );
  }
}