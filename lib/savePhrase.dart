import 'package:Conversando/commons.dart';
import 'package:flutter/material.dart';
import 'package:Conversando/context.dart';
import 'package:Conversando/showDialog.dart';

class SavePhrase extends StatefulWidget {
  State createState() => new SavePhraseState();
}

class SavePhraseWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  SavePhraseWidget({this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(


    );
  }

}

class SavePhraseState extends State<SavePhrase> {
  String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    if (tc.getCategories().length > 0){
      selectedCategory = tc.getCategories()[0].text;
    }
    return new Scaffold(
      appBar:
      new AppBar(
        title: Text('Añadir frase'),
        actions: <Widget>[
        new ActionBarButtonWidget("GUARDAR", () {
          tc.save(selectedCategory, tc.getTextPhrase());
          setState(() {
            Navigator.pop(context, tc.getTextPhrase());
          });
        }),
        ]
      ),

      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            margin: EdgeInsets.all(24),
            child: new Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Frase a guardar"),
                new SizedBox(height: 12.0),
                Text(
                  tc.getTextPhrase(),
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                  )
                )
              ]
            )
          ),
          Divider(),
          new Container(
            margin: EdgeInsets.all(24),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("En la categoría:"),
                new Container(
                  width: double.infinity,
                  child: new DropdownButton(
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
                ),
                FlatButton.icon(
                  label: const Text ('Añadir categoría', semanticsLabel: 'Añade una categoría nueva'),
                  icon: const Icon(Icons.add, size:12.0),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    showCreateCategoryDialog(context).then((
                        value) { // The value passed to Navigator.pop() or null.
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
          )
        ],
      )
    );
  }
}
