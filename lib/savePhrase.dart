import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

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
        backgroundColor: Colors.cyan,
        title: Text('Añadir frase'),
        actions: <Widget>[
          // action button
          FlatButton(
            child: new Text(
              'GUARDAR',
            ),
            onPressed: () {
              tc.save(selectedCategory, tc.getTextPhrase());
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
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
            ],
          ),
        ],
      )
    );
  }
}