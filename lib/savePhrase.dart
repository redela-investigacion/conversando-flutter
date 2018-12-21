import 'package:conversando/commons.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/showDialog.dart';

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
    return ListTile (
      title: Text(this.title),
      subtitle: this.subtitle != null ? Text(this.subtitle) : null ,
      leading: Icon(this.icon, color: Theme.of(context).primaryColorLight, size: 24.0),
    );
  }

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
            Navigator.pop(context, tc.getTextPhrase());
          });
        }),
        ]
      ),

      body: new ListView(
        children: [
          new SavePhraseWidget (
            title: "Frase a guardar",
            subtitle: tc.getTextPhrase(),
            icon: Icons.save,
          ),
          Divider(),
          new Column(
            children: <Widget>[
              new SavePhraseWidget(title: "En categoría:"),
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
              Divider(),
              FlatButton.icon(
                label: const Text ('AÑADIR CATEGORÍA', semanticsLabel: 'Añade una categoría nueva'),
                icon: const Icon(Icons.add, size:12.0),
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
        ],
      )
    );
  }
}
