import 'package:conversando/selectPhrase.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class SpeakerWidget extends StatelessWidget {
  const SpeakerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            shrinkWrap: true,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            children: const [
              QuickSpeakWidget('Sí'),
              QuickSpeakWidget('No'),
              QuickSpeakWidget('Perdona'),
              QuickSpeakWidget('Hola'),
              QuickSpeakWidget('Bien'),
              QuickSpeakWidget('Gracias'),
            ],
          ),
        ),
        const Expanded(child: PhraseSelector()),
      ],
    );
  }
}

class QuickSpeakWidget extends StatelessWidget {
  final String _label;

  const QuickSpeakWidget(this._label, {super.key});

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return Semantics(
      button: true,
      label: 'Decir: $_label',
      child: SizedBox.expand(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            minimumSize: const Size(double.infinity, 56),
          ),
          onPressed: () { tc.speak(_label); },
          child: Text(_label),
        ),
      ),
    );
  }
}
