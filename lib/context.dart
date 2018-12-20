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

class Phrase {
  String _text;
  Phrase(this._text);

  String getText() {
    return _text;
  }
}

class Category {
  String text;
  List<Phrase> _phrases = [];
  Category(this.text);

  void addPhrase(String text) {
    _phrases.add(new Phrase(text));
  }

  List<Phrase> getPhrases() {
    return _phrases;
  }
}

class TextContextWidgetState extends State<TextContextWidget>{
  final _tts = new FlutterTts();

  String _text = "";
  List<String> _words = [];
  List<String> _phrases = [];

  List<Category> _categories = [];

  void deleteWord(String word) {
    setState(() {
      _words.remove(word);
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

  List<Category> getCategories() {
    return _categories;
  }

  void clearText(){
    setState(() {
      _words = [];
      _text = "";
    });
  }

  void save(){
    setState(() {
      _phrases.add(getTextPhrase());
      print("SAVE: ${getTextPhrase()}");
    });
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

    Category tmpCat1 = new Category('😍 Saludos');
    tmpCat1.addPhrase('Hola');
    tmpCat1.addPhrase('¿Qué pasa?');

    Category tmpCat2 = new Category('🌎 En casa');
    tmpCat2.addPhrase('¿Puedes subir el volumen de la televisión?');
    tmpCat2.addPhrase('Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?');
    tmpCat2.addPhrase('Por favor, traeme un vaso de agua');

    Category tmpCat3 = new Category('😙 Cosas que me gustan');

    Category tmpCat4 = new Category('🌐 Preguntas');
    _categories = [
      tmpCat1,
      tmpCat2,
      tmpCat3,
      tmpCat4
    ];

    return new _TextContext(
      data: this,
      child: widget.child,
    );
  }
}