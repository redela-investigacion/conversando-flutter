import 'package:flutter/material.dart';

class ComposerFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  ComposerFieldWidget(this.controller) ;

  @override
  ComposerFieldState createState() => new ComposerFieldState(this.controller);
}

class ComposerFieldState extends State<ComposerFieldWidget> {
  TextEditingController controller;

  String _text = "";
  List<String> _words = [];
  TextEditingController _textInputController = new TextEditingController();

  ComposerFieldState(this.controller) ;

  String _getTextPhrase() {
    return [_words.join(' '), _text].join(" ");
  }

  void onChange(String text) {
    setState(() {
      String word = text.substring(0, text.length -1).trim();
      String symbol = text.substring(text.length -1, text.length);

      // Space
      if (symbol == ' ') {
        _text = '';
        _textInputController.clear();

        String word = text.trim();

        if (word != '') {
          _words.add(word);
        }

      }
      // Marks
      else if (['.', ',', ';', ':', '\'', '"'].contains(symbol)) {
        _text = '';
        _textInputController.clear();

        if (word != '') {
          _words.add(word);
        }
        _words.add(symbol);
      }
      // default
      else {
        _text = text;
      }

      controller.text = _getTextPhrase();
    });
  }

  List<Widget> _getTextWidgets () {
    List<Widget> widgets = [];

    _words.forEach((word) {
      widgets.add(
          new InputChip(
              label: Text(word),
              onDeleted: () {
                setState(() {
                  _words.remove(word);
                  controller.text = _getTextPhrase();
                });
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
            onChange(value);
          },
        )
    );

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: new Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 1.0, // gap between lines
          children: _getTextWidgets(),
        )
      )
    );
  }
}