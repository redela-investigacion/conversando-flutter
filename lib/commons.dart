import 'package:flutter/material.dart';

class ActionBarButtonWidget extends StatelessWidget {
  final String _label;
  final VoidCallback _action;

  const ActionBarButtonWidget(this._label, this._action, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      onPressed: _action,
      child: Text(_label, style: const TextStyle(fontSize: 14.0)),
    );
  }
}
