import 'package:flutter/material.dart';

Future showCreateCategoryDialog (context){
  return _showOneFieldDialog(
      context: context,
      dialogTitle: "AÑADIR CATEGORÍA",
      fieldLabel: "Nombre de la categoría",
      actionLabel: "AÑADIR"
  );
}

Future showEditCategoryDialog (context, oldCategoryText){
  return _showOneFieldDialog(
    context: context,
    dialogTitle: "EDITAR CATEGORÍA",
    fieldLabel: "Nuevo nombre de la categoría",
    actionLabel: "GUARDAR",
    oldValue: oldCategoryText
  );
}

Future showCreatePhraseDialog (context){
  return _showOneFieldDialog(
    context: context,
    dialogTitle: "AÑADIR FRASE",
    fieldLabel: "Nueva frase",
    actionLabel: "AÑADIR"
  );
}

Future showEditPhraseDialog (context, oldPhraseText){
  return _showOneFieldDialog(
    context: context,
    dialogTitle: "EDITAR FRASE",
    fieldLabel: "Nueva frase",
    actionLabel: "GUARDAR",
    oldValue: oldPhraseText
  );
}

Future _showOneFieldDialog ({context, String dialogTitle, String fieldLabel, String actionLabel, String oldValue = ""} ){
  TextEditingController newCategoryController = new TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
    // return object of type Dialog
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(dialogTitle, textAlign: TextAlign.left),
            Divider(),
            new Text(oldValue, textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0, color: Colors.black87)),
          ]
        ),
        content: new ConstrainedBox(
          constraints: new BoxConstraints.expand(height: 50.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new TextField(
                controller: newCategoryController,
                decoration: InputDecoration(hintText: fieldLabel, hintStyle: TextStyle(fontSize: 15.0, color: Colors.black38)),
              )
            ])
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("CANCELAR"),
            textColor: Colors.black87,
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
