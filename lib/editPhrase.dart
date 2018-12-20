import 'package:conversando/commons.dart';
import 'package:flutter/material.dart';

class PhraseEditorWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Mis frases"),
        actions: <Widget>[
          new ActionBarButtonWidget("AÑADIR", () { Navigator.pop(context);})
    ]),
      body: Column(children: [])
    );
  }
}
