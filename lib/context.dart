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
  final List<String> _punctuationSymbols = const ['.', ',', ';', ':', '?', '¿', '!', '¡', '\'', '\\', '-'];
  final RegExp _tokenizerRegExp = RegExp(r"\w+|[.,;:?¿!¡'\-]", caseSensitive: false);

  final _tts = new FlutterTts();
  String _text = "";
  List<String> _words = [];
  Map<String, Category> _categories = Map();

  TextContextWidgetState(){
    Category tmpCat1 = new Category('😍 Saludos');
    tmpCat1.addPhrase('Hola');
    tmpCat1.addPhrase('¿Qué pasa?');

    Category tmpCat2 = new Category('🌎 En casa');
    tmpCat2.addPhrase('¿Puedes subir el volumen de la televisión?');
    tmpCat2.addPhrase('Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?');
    tmpCat2.addPhrase('Por favor, traeme un vaso de agua');

    Category tmpCat3 = new Category('😙 Cosas que me gustan');

    Category tmpCat4 = new Category('🌐 Preguntas');
    _categories[tmpCat1.text] = tmpCat1;
    _categories[tmpCat2.text] = tmpCat2;
    _categories[tmpCat3.text] = tmpCat3;
    _categories[tmpCat4.text] = tmpCat4;
  }

  List<String> _tokenizer(String text) {
    return _tokenizerRegExp.allMatches(text).map((m) => m.group(0)).toList();
  }

  void deleteWord(String word) {
    setState(() {
      _words.remove(word);
    });
  }

  void replaceWord(int index, String text) {
    List<String> newWords = _tokenizer(text);
    _words.replaceRange(index, index+1, newWords);
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

  void addCategory(String c) {
    _categories[c] = new Category(c);
  }

  List<Category> getCategories() {
    return _categories.values.toList();
  }

  void clearText(){
    setState(() {
      _words = [];
      _text = "";
    });
  }

  void save(String category, String phrase){
    setState(() {
      Category cat = _categories[category];
      cat.addPhrase(phrase);
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
      else if (_punctuationSymbols.contains(symbol)) {
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
      content: Text("Diciendo: $text"),
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