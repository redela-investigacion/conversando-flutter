import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/scroll.dart';

class PhraseWidget extends StatelessWidget {
  final String text;
  final void Function(String) onTap;

  const PhraseWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      title: Text(
        text,
        style: const TextStyle(
            color: Color(0xFF2A2A2A),
            fontFamily: 'Montserrat',
            fontSize: 16),
      ),
      onTap: () => onTap(text),
    );
  }
}

class PhraseSelector extends StatelessWidget {
  const PhraseSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return ListViewWithScroll(
      children: tc.getCategories().map((category) {
        return ExpansionTile(
          title: Text(category.text,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          children: category.getPhrases().map((phrase) {
            return PhraseWidget(
              text: phrase.text,
              onTap: (text) {
                tc.appendText(text);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

class FullPagePhraseSelector extends StatelessWidget {
  const FullPagePhraseSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis frases')),
      body: const PhraseSelector(),
    );
  }
}
