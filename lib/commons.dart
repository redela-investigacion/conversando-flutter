import 'package:flutter/material.dart';

class ActionBarButtonWidget extends StatelessWidget {
  String _label;
  Function _action;

  ActionBarButtonWidget(this._label, this._action);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: new Text(this._label, style: TextStyle(fontSize: 14.0),),
      textColor: Colors.white,
      onPressed: () {
        this._action();
      });
  }
}
