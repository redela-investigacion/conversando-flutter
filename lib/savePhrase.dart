import 'package:conversando/commons.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/categoryDialog.dart';

class SavePhrase extends StatefulWidget {
  State createState() => new SavePhraseState();
}

class SavePhraseState extends State<SavePhrase> {
  String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    return new Scaffold(
      appBar:
      new AppBar(
        title: Text('Añadir frase'),
        actions: <Widget>[
        new ActionBarButtonWidget("GUARDAR", () {
          tc.save(selectedCategory, tc.getTextPhrase());
          setState(() {
            Navigator.pop(context);
          });
        }),
        ]
      ),

      body: new ListView(
        children: [
          new Column(
            children: <Widget>[
              Text('Frase a guardar:'),
              Text(tc.getTextPhrase()),
              Divider(),
              Text('En categoría:'),
              new DropdownButton(
                value: selectedCategory,
                hint: new Text("Elige una categoría"),
                onChanged: (String newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: tc.getCategories().map((Category cat){
                  return new DropdownMenuItem<String>(
                    value: cat.text,
                    child: new Text(cat.text),
                  );
                }).toList()
              ),
              RaisedButton(
                child: new Text(
                  'AÑADIR CATEGORÍA',
                ),
                onPressed: () {
                  showCreateCategoryDialog(context).then((value) { // The value passed to Navigator.pop() or null.
                    if (value != null) {
                      tc.addCategory(value);
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  });
                }
              )
            ],
          ),
        ],
      )
    );
  }
}
