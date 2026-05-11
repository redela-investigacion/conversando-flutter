import 'package:conversando/selectPhrase.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/composerField.dart';
import 'package:conversando/savePhrase.dart';
import 'package:share_plus/share_plus.dart';

class ComposerWidget extends StatelessWidget {
  const ComposerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                padding: const EdgeInsets.only(
                    top: 10.0, right: 10.0, bottom: 100.0, left: 10.0),
                child: const ComposerFieldWidget(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Semantics(
                        label: 'Borrar texto',
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                          disabledColor: const Color(0xFFD2D2D2),
                          onPressed: tc.getWords().isEmpty
                              ? null
                              : () {
                                  tc.clearText();
                                  tc.clearWords();
                                },
                        ),
                      ),
                      Semantics(
                        label: 'Compartir texto',
                        child: IconButton(
                          icon: const Icon(Icons.share),
                          color: Colors.grey,
                          disabledColor: const Color(0xFFD2D2D2),
                          onPressed: tc.getWords().isEmpty
                              ? null
                              : () => Share.share(tc.getTextPhrase()),
                        ),
                      ),
                      Semantics(
                        label: 'Guardar frase',
                        child: IconButton(
                          icon: const Icon(Icons.save),
                          color: Theme.of(context).colorScheme.primary,
                          disabledColor: const Color(0xFFD2D2D2),
                          onPressed: tc.getTextPhrase().isEmpty
                              ? null
                              : () => _navigateToSave(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  heroTag: 'listPhrasesButton',
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  tooltip: 'Ver frases guardadas',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FullPagePhraseSelector()),
                  ),
                  child: const Icon(Icons.apps),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: FloatingActionButton(
                  heroTag: 'speakButton',
                  backgroundColor: tc.getTextPhrase().isNotEmpty
                      ? const Color(0xFFFDA05D)
                      : const Color(0xFFD2D2D2),
                  tooltip: 'Hablar',
                  onPressed: tc.getTextPhrase().isEmpty
                      ? null
                      : () { tc.speak(tc.getTextPhrase()); },
                  child: const Icon(Icons.volume_up),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _navigateToSave(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const SavePhrase()),
    );
    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Guardado: $result')));
    }
  }
}
