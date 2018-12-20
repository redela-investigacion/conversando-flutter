import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {
  Function _action;

  SaveButtonWidget(this._action);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: new Text('GUARDAR'),
      textColor: Colors.white,
      onPressed: () {
        this._action();
      });
  }
}
