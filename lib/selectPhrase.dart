import 'package:flutter/material.dart';
import 'package:Conversando/context.dart';
import 'package:Conversando/scroll.dart';

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

class PhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextContextWidgetState tc = TextContextWidget.of(context);

    return  new ListViewWithScroll(
      children: tc.getCategories().map((Category category) {
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
      }).toList()
    );
  }
}

class FullPagePhraseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Mis frases")),
      body: new PhraseSelector()
    );
  }
}