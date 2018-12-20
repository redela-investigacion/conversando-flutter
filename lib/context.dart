import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/*
class TextContext extends InheritedWidget {
  //final FlutterTts tts;
  final Function(String text, BuildContext context) speak;

  const TextContext({
    Key key,
    @required this.speak,
    @required Widget child,
  })  : assert(speak != null),
        assert(child != null),
        super(key: key, child: child);

  static TextContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TextContext);
  }

  @override
  bool updateShouldNotify(TextContext old) {
    //return color != old.color;
    return false;
  }
}
*/

class Item {
  String reference;

  Item(this.reference);
}

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

  /// List of Items
  List<Item> _items = <Item>[];

  /// Getter (number of items)
  int get itemsCount => _items.length;

  /// Helper method to add an Item
  void addItem(String reference){
    setState((){
      _items.add(new Item(reference));
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