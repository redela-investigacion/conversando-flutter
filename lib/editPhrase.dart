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
          ListTile(title: Text("Mis categorías")),
          Divider(),
          Expanded(
            child: ListView(
              children: tc.getCategories().map((Category category) {
                return CategoryEditorWidget(category);
              }).toList()
            )
          )
          ]
    ));}
}

class CategoryEditorWidget extends StatelessWidget {
  final Category _category;

  CategoryEditorWidget(this._category);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return RemoveCategoryWidget(this._category);
  }
}

class RemoveCategoryWidget extends StatelessWidget {
  final Category _category;

  RemoveCategoryWidget(this._category);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    final bool emptyCategory = this._category.getPhrases().length == 0;

    return ListTile(
      title: Text(this._category.text),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: emptyCategory ? Colors.red[300] : Colors.grey,
        onPressed: emptyCategory ? () {tc.removeCategory(this._category.text);} : null
      ),
    );
  }
}
