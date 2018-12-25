import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:uuid/uuid.dart';

var uuid = new Uuid();

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
  String _id;
  String _text;

  Phrase(this._id, this._text);

  String getText() {
    return _text;
  }
}

class Category {
  String id;
  String text;
  Map<String, Phrase> _phrases = new Map();

  Category(this.id, this.text);

  void addPhrase(String text) {
    String phraseId = uuid.v4();
    _phrases[phraseId] = new Phrase(phraseId, text);
  }

  List<Phrase> getPhrases() {
    return _phrases.values.toList();
  }

  void removePhrase(String phraseId) {
    _phrases.remove(phraseId);
  }

}

class TextContextWidgetState extends State<TextContextWidget>{
  final List<String> _whiteSpaceSymbols = const [' ']; // TODO: [bug] this should works with [' ', '\r', '\n', '\t', '\f', '\v'] too
  final List<String> _punctuationSymbols = const ['.', ',', ';', ':', '?', '¿', '!', '¡', '\'', '\\', '-'];
  final RegExp _tokenizerRegExp = RegExp(r"\S+|[.,;:?¿!¡'\-]", caseSensitive: false);
  final _tts = new FlutterTts();
  final LocalStorage storage = new LocalStorage('Conversando_app');
  bool initialized = false;

  String _text = "";
  List<String> _words = [];
  Map<String, Category> _categories = Map();

  _saveToStorage() {
    List<dynamic> data = new List();
    _categories.forEach((String id, Category category) {
      data.add({
        'id': id,
        'text': category.text,
        'phrases': category.getPhrases().map((Phrase p) {
          return {
            'id': p._id,
            'text': p._text
          };
        }).toList()
      });
    });
    storage.setItem('categories', data);
  }

  _loadFromStorage() {
    dynamic categories = storage.getItem('categories');

    if (categories != null) {
      (categories as List).forEach((category) {
        String id = category['id'];
        _categories[id] = new Category(id, category['text']);
        (category['phrases'] as List).forEach((phrase) {
          _categories[id].addPhrase(phrase['text']);
        });
      });
    }
    else {
      String tmpCat1Id = uuid.v4();
      Category tmpCat1 = new Category(tmpCat1Id, '😍 Saludos');
      tmpCat1.addPhrase('Hola');
      tmpCat1.addPhrase('¿Qué pasa?');

      String tmpCat2Id = uuid.v4();
      Category tmpCat2 = new Category(tmpCat2Id, '🌎 En casa');
      tmpCat2.addPhrase('¿Puedes subir el volumen de la televisión?');
      tmpCat2.addPhrase('Esta es una frase mucho más larga para que Andrés vea como queda. ¿Cómo de largas queremos las frases?');
      tmpCat2.addPhrase('Por favor, traeme un vaso de agua');

      String tmpCat3Id = uuid.v4();
      Category tmpCat3 = new Category(tmpCat3Id, '😙 Cosas que me gustan');

      String tmpCat4Id = uuid.v4();
      Category tmpCat4 = new Category(tmpCat4Id, '🌐 Preguntas');
      _categories[tmpCat1.id] = tmpCat1;
      _categories[tmpCat2.id] = tmpCat2;
      _categories[tmpCat3.id] = tmpCat3;
      _categories[tmpCat4.id] = tmpCat4;
    }

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

  void appendText( String text) {
    List<String> newWords = _tokenizer(text);
    _words.addAll(newWords);
  }

  String getText() {
    return _text;
  }

  List<String> getWords() {
    return _words;
  }

  String getTextPhrase() {
    String text = [_words.join(' '), _text].join(" ");
    if (text == " ") {
      return "";
    }
    return text;
  }

  Category addCategory(String c) {
    String id = uuid.v4();
    _categories[id] = new Category(id, c);
    _saveToStorage();
    return _categories[id];
  }

  List<Category> getCategories() {
    return _categories.values.toList();
  }

  void editCategory(Category cat, String text) {
    setState(() {
      var category = _categories[cat.id];
      category.text = text;
//      cat.text = text;
    });
    _saveToStorage();
  }

  void removeCategory(Category cat) {
    setState(() {
      _categories.remove(cat.id);
    });
    _saveToStorage();
  }

  void editPhrase(Category cat, Phrase p, String text) {
    setState(() {
      Category category = _categories[cat.id];
      Phrase phrase = category._phrases[p._id];
      phrase._text = text;
    });
    _saveToStorage();
  }

  void removePhrase(Category cat, Phrase p) {
    setState(() {
      Category category = _categories[cat.id];
      category.removePhrase(p._id);
    });
    _saveToStorage();
  }

  void clearWords() {
    setState(() {
      _words = [];
    });
  }

  void clearText(){
    setState(() {
      _text = "";
    });
  }

  void save(String category, String phrase){
    setState(() {
      Category cat = _categories[category];
      cat.addPhrase(phrase);
    });
    _saveToStorage();
  }

  void onTextChange(String inputText) {
    setState(() {
      if (inputText.length == 0) {
        _text = inputText;
      }
      else {
        String word = inputText.substring(0, inputText.length -1).trim();
        String symbol = inputText.substring(inputText.length -1, inputText.length);

        // White Space symbols
        if (_whiteSpaceSymbols.contains(symbol)) {
          _text = '';
          if (word != '') {
            _words.add(word);
          }
        }
        // Punctuation Symbols
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
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!initialized) {
          _loadFromStorage();
          initialized = true;
        }

        return new _TextContext(
          data: this,
          child: widget.child,
        );
      }
    );
  }
}
