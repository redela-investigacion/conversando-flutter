import 'package:conversando/commons.dart';
import 'package:conversando/context.dart';
import 'package:flutter/material.dart';
import 'package:conversando/createCategoryDialog.dart';

class PhraseEditorWidget extends StatelessWidget {
  @override
  Widget build(context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Mis frases"),
        actions: <Widget>[
          new ActionBarButtonWidget("AÑADIR", () {
            showCreateCategoryDialog(context).then((value) { // The value passed to Navigator.pop() or null.
              if (value != null) {
                tc.addCategory(value);
              }
            });
          })
        ]
      ),
      body:
      Column(
        children: [
          Text("Mis categorías"),
          Divider(),
          Expanded(
            child: ListView(
              children: tc.getCategories().map((Category category) {
                return ListTile(title: Text(category.text));
              }).toList()
            )
          )
          ]
    ));}
}
