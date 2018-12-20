import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class ExpansionPhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return ExpansionTile(
      //key: PageStorageKey<Entry>(root),
      title: Text("Categorías de frases"),
      children: tc.getCategories().map((Category category) {
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
      }).toList());
  }
}

class FullPagePhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return new Scaffold(
      appBar: new AppBar(title: Text("Mis frases")),
      body: Column(children: tc.getCategories().map((Category category) {
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
      }).toList()));
  }
}


class PhraseWidget extends StatelessWidget {
  String text;
  Function onTap;

  PhraseWidget({this.text, this.onTap});

  @override
  Widget build(context) {
    return ListTile(
      title: Text(text),
      onTap: () => onTap(text)
    );
  }
}
