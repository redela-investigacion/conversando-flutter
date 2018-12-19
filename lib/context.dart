import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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