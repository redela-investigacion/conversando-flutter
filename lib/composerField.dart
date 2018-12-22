import 'package:flutter/material.dart';
import 'package:Conversando/context.dart';

class ComposerFieldWidget extends StatefulWidget {
  ComposerFieldWidget();

  @override
  ComposerFieldState createState() => new ComposerFieldState();
}

class ComposerFieldState extends State<ComposerFieldWidget> {
  TextEditingController _textInputController = new TextEditingController();

  ComposerFieldState();

  _showDialog(String word, int index, TextContextWidgetState tc) async {
    TextEditingController editorTextInputController = new TextEditingController();
    editorTextInputController.text = word;
    
    await showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: const EdgeInsets.all(20.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: editorTextInputController,
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
                  Navigator.pop(context);
                });
              }
            ),
            new FlatButton(
              child: const Text('GUARDAR'),
              onPressed: () {
                setState(() {
                  tc.replaceWord(index, editorTextInputController.text);
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
          deleteIconColor: Color(0XFF767676),
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
          onPressed: () {
            _showDialog(word, index, tc);
          },
          onDeleted: () {
            tc.deleteWord(word);
          }
        )
      );
    });

    widgets.add(
      new TextField(
        maxLines: null,
        controller: _textInputController,
        decoration: InputDecoration(
          hintText: 'Tu texto aquí'
        ),
        onChanged: (String value) {
          tc.onTextChange(value);
          if (tc.getText() == '') {
            _textInputController.clear();
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