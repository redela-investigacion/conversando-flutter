import 'package:conversando/commons.dart';
import 'package:flutter/material.dart';

class PhraseEditorWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Mis frases"),
        actions: <Widget>[
          new SaveButtonWidget(() { Navigator.pop(context);})
    ]),
      body: Column(children: [])
    );
  }
}
