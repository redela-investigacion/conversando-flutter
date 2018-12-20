import 'package:conversando/commons.dart';
import 'package:conversando/context.dart';
import 'package:flutter/material.dart';

class PhraseEditorWidget extends StatelessWidget {
  @override
  Widget build(context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Mis frases"),
        actions: <Widget>[
          new ActionBarButtonWidget("AÑADIR", () { Navigator.pop(context);})
        ]
      ),
      body:
      Column(
        children: [
//          Expanded(child: Text("Mis categorías")),
          ListView(
            children: tc.getCategories().map((Category category) {
              return ListTile(title: Text(category.text));
            }).toList()
        )]
    ));}
}
