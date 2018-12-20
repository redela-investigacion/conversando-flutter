import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class ExpansionPhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    return ExpansionTile(
      //key: PageStorageKey<Entry>(root),
        title: Text('Categorías de frases'),
        children: tc.getCategories().map((Category category) {
          return new ExpansionTile(
              title: Text(category.text),
              children: category.getPhrases().map((Phrase phrase){
                return new PhraseWidget(phrase.getText());
              }).toList()
          );
        }).toList());
  }
}

class FullPagePhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);
    return new Scaffold(
        appBar:
        new AppBar(backgroundColor: Colors.cyan, title: Text('Mis frases')),
        body: Column(children: tc.getCategories().map((Category category) {
          return ExpansionTile(
              title: Text(category.text),
              children: category.getPhrases().map((Phrase phrase){
                return new PhraseWidget(phrase.getText());
              }).toList()
          );
        }).toList()));
  }
}


class PhraseWidget extends StatelessWidget {
  String _text;

  PhraseWidget(this._text);

  @override
  Widget build(context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return ListTile(
        title: Text(this._text),
        onTap: () {
          tc.speak(this._text, context);
        });
  }
}
