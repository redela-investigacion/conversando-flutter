import 'package:flutter/material.dart';

Future showCreateCategoryDialog (context){
  return _showOneFieldDialog(
      context: context,
      dialogTitle: "AÑADIR CATEGORÍA",
      fieldLabel: "Nombre de la categoría",
      actionLabel: "AÑADIR"
  );
}

Future showEditCategoryDialog (context){
  return _showOneFieldDialog(
    context: context,
    dialogTitle: "EDITAR CATEGORÍA",
    fieldLabel: "Nombre de la categoría",
    actionLabel: "GUARDAR"
  );
}

Future _showOneFieldDialog ({context, String dialogTitle, String fieldLabel, String actionLabel} ){
  TextEditingController newCategoryController = new TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
    // return object of type Dialog
      return AlertDialog(
        title: new Text(dialogTitle),
        content: new ConstrainedBox(
          constraints: new BoxConstraints.expand(height: 100.0),
          child: new Column(children: [
            new Text(fieldLabel),
            new TextField(
              controller: newCategoryController,
              decoration: InputDecoration(
                hintText: fieldLabel
              ),
            )
          ])
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("CANCELAR"),
            textColor: Colors.black54,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: new Text(actionLabel),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context, newCategoryController.text);
            },
          ),
        ]);
      });
}
