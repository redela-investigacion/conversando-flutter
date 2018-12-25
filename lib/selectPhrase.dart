import 'package:flutter/material.dart';
import 'package:Conversando/context.dart';

class ExpansionPhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Flexible(
      child:
        new Scrollbar(child:
          ListView(children: tc.getCategories().map((Category category) {
            return new ExpansionTile(
              title: Text(category.text),
              children: category.getPhrases().map((Phrase phrase){
                return new PhraseWidget(
                  text: phrase.getText(),
                  onTap: (text) {
                    tc.speak(text, context);
                  }
                );
              }).toList()
            );
          }).toList())
        )
    );
  }
}

class FullPagePhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Scaffold(
      appBar: new AppBar(title: Text("Mis frases")),
      body:
        new Scrollbar(child:
          ListView(children: tc.getCategories().map((Category category) {
            return ExpansionTile(
              title: Text(category.text),
              children: category.getPhrases().map((Phrase phrase){
                return new PhraseWidget(
                  text: phrase.getText(),
                  onTap: (text) {
                    tc.appendText(text);
                    Navigator.pop(context);
                  }
                );
              }).toList()
            );
          }).toList())
        )
      );
  }
}


class PhraseWidget extends StatelessWidget {
  final String text;
  final Function onTap;

  PhraseWidget({this.text, this.onTap});

  @override
  Widget build(context) {
    return ListTile(
      title: Text(text, style: new TextStyle(color: new Color(0xFF2A2A2A), fontFamily: 'Montserrat')),
      onTap: () => onTap(text)
    );
  }
}
