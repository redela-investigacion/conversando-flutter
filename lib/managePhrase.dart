import 'package:conversando/commons.dart';
import 'package:conversando/context.dart';
import 'package:conversando/showDialog.dart';
import 'package:flutter/material.dart';

class CategoryManagerWidget extends StatelessWidget {
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
          ListTile(title: Text("Mis categorías", style: TextStyle(fontSize: 18.0),)),
          Divider(),
          Expanded(
            child: ListView(
              children: tc.getCategories().map((Category category) {
                return new CategoryEditorWidget(category);
              }).toList()
            )
          )
        ]
    ));
  }
}

class CategoryEditorWidget extends StatelessWidget {
  final Category _category;

  CategoryEditorWidget(this._category);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child:
          ListTile(
            title: Text(this._category.text),
            onTap: () {
              Route route = MaterialPageRoute(
                builder: (context) => new PhraseManagerWidget(this._category));
              Navigator.push(context, route);
            },
          )
        ),
        new RemoveCategoryWidget(this._category),
        new EditCategoryWidget(this._category)
    ]);
  }
}

class RemoveCategoryWidget extends StatelessWidget {
  final Category _category;

  RemoveCategoryWidget(this._category);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    final bool emptyCategory = this._category.getPhrases().length == 0;

    return IconButton(
      icon: Icon(Icons.delete),
      color: Colors.red[300],
      disabledColor: Colors.grey,
      onPressed: emptyCategory ? () {
        String message = "¿Deseas eliminar la siguiente categoría?";
        showRemoveConfirmationDialog(context, message, this._category.text).then((
          value) { // The value passed to Navigator.pop() or null.
          if (value == true) {
            tc.removeCategory(this._category.text);
          }
        });
      } : null
    );
  }
}

class EditCategoryWidget extends StatelessWidget {
  final Category _category;

  EditCategoryWidget(this._category);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return IconButton(
      icon: Icon(Icons.edit),
      color: Colors.black54,
      onPressed: () {
        showEditCategoryDialog(context, this._category.text).then((
          value) { // The value passed to Navigator.pop() or null.
          if (value != null) {
            tc.editCategory(this._category.text, value);
          }
        });
      }
    );
  }
}

class PhraseManagerWidget extends StatelessWidget {
  final Category _category;

  PhraseManagerWidget(this._category);

  @override
  Widget build(context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: Text(this._category.text),
        actions: <Widget>[
          new ActionBarButtonWidget("AÑADIR", () {
            showCreatePhraseDialog(context).then((value) { // The value passed to Navigator.pop() or null.
              if (value != null) {
                tc.save(this._category.text, value);
              }
            });
          })
        ]
      ),
      body: ListView(
        children: this._category.getPhrases().map((Phrase phrase) {
          return new PhraseEditorWidget(this._category, phrase);
        }).toList()
      )
    );
  }
}

class PhraseEditorWidget extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  PhraseEditorWidget(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(child: ListTile(
            title: Text(this._phrase.getText()),
          )
        ),
        new RemovePhraseWidget(this._category, this._phrase),
        new EditPhraseWidget(this._category, this._phrase)
      ]),
      Divider()
    ]);
  }
}

class RemovePhraseWidget extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  RemovePhraseWidget(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return IconButton(
      icon: Icon(Icons.delete),
      color: Colors.red[300],
      onPressed: () {
        String message = "¿Deseas eliminar la siguiente frase?";
        showRemoveConfirmationDialog(context, message, this._phrase.getText()).then((
          value) { // The value passed to Navigator.pop() or null.
          if (value == true) {
            tc.removePhrase(this._category.text, this._phrase.getText());
          }
        });
      }
    );
  }
}

class EditPhraseWidget extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  EditPhraseWidget(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return IconButton(
      icon: Icon(Icons.edit),
      color: Colors.black54,
      onPressed: () {
        showEditPhraseDialog(context, this._phrase.getText()).then((value) { // The value passed to Navigator.pop() or null.
          if (value != null) {
            tc.editPhrase(this._category.text, this._phrase.getText(), value);
          }
        });
      }
    );
  }
}


