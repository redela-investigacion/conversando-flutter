import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class ComposerFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  ComposerFieldWidget(this.controller) ;

  @override
  ComposerFieldState createState() => new ComposerFieldState(this.controller);
}

class ComposerFieldState extends State<ComposerFieldWidget> {
   TextEditingController controller;

   TextEditingController _textInputController = new TextEditingController();

  ComposerFieldState(this.controller) ;

  initialValue(val) {
    return TextEditingController(text: val);
  }

  List<Widget> _getTextWidgets (TextContextWidgetState tc) {
    List<Widget> widgets = [];

    tc.getWords().forEach((word) {
      widgets.add(
          new InputChip(
              label: Text(word),
              onDeleted: () {
                tc.deleteWord(word);
                controller.text = tc.getText();
              }
          )
      );
    });

    widgets.add(
        new TextField(
          maxLines: null,
          controller: _textInputController,
          decoration: InputDecoration(
              hintText: 'Tu texto aquí'
          ),
          onChanged: (String value) {
            tc.onTextChange(value);
            if (tc.getText() == '') {
              _textInputController.text = '';
            }
          }
        )
    );

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: new Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 1.0, // gap between lines
          children: _getTextWidgets(tc),
        )
      )
    );
  }
}