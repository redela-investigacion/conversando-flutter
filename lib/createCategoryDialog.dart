import 'package:flutter/material.dart';

Future showCreateCategoryDialog (context){
  TextEditingController newCategoryController = new TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("AÑADIR CATEGORÍA"),
          content: new Column(children: [
            new Text("Nombre de la categoría"),
            new TextField(
              controller: newCategoryController,
              decoration: InputDecoration(
                  hintText: 'Nombre de la categoría'
              ),
            )
          ]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("CANCELAR"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("AÑADIR"),
              onPressed: () {
                Navigator.pop(context, newCategoryController.text);
              },
            ),
          ],
        );
      }
  );
}