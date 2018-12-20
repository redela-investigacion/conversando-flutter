import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class _TextContext extends InheritedWidget {
  _TextContext({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final TextContextWidgetState data;

  @override
  bool updateShouldNotify(_TextContext oldWidget) {
    return true;
  }
}

class TextContextWidget extends StatefulWidget {
  TextContextWidget({
    Key key,
    this.child,
  }): super(key: key);

  final Widget child;

  @override
  TextContextWidgetState createState() => new TextContextWidgetState();

  static TextContextWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_TextContext) as _TextContext).data;
  }
}

class TextContextWidgetState extends State<TextContextWidget>{
  final _tts = new FlutterTts();

  String _text = "";
  List<String> _words = [];

  void deleteWord(String word) {
    setState(() {
      _words .remove(word);
    });
  }

  String getText() {
    return _text;
  }

  List<String> getWords() {
    return _words;
  }

  String getTextPhrase() {
    return [_words.join(' '), _text].join(" ");
  }

  void onTextChange(String inputText) {
    setState(() {
      String word = inputText.substring(0, inputText.length -1).trim();
      String symbol = inputText.substring(inputText.length -1, inputText.length);

      // Space
      if (symbol == ' ') {
        _text = '';
        if (word != '') {
          _words.add(word);
        }
      }
      // Marks
      else if (['.', ',', ';', ':', '\'', '"'].contains(symbol)) {
        _text = '';
        if (word != '') {
          _words.add(word);
        }
        _words.add(symbol);
      }
      // default
      else {
        _text = inputText;
      }
    });
  }

  void speak(String text, BuildContext ctx) {
    _tts.speak(text);

    final snackBar = SnackBar(
      content: Text("Diciendo: ${text}"),
      action: SnackBarAction(
        label: 'Reproducir de nuevo',
        onPressed: () {
          _tts.speak(text);
        },
      ),
    );
    Scaffold.of(ctx).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context){
    return new _TextContext(
      data: this,
      child: widget.child,
    );
  }
}