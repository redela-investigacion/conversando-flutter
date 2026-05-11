import 'package:flutter/material.dart';
import 'package:conversando/context.dart';

class ComposerFieldWidget extends StatefulWidget {
  const ComposerFieldWidget({super.key});

  @override
  ComposerFieldState createState() => ComposerFieldState();
}

class ComposerFieldState extends State<ComposerFieldWidget> {
  final TextEditingController _textInputController = TextEditingController();

  Future<void> _showEditDialog(
      String word, int index, TextContextWidgetState tc) async {
    final controller = TextEditingController(text: word);
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        contentPadding: const EdgeInsets.all(20.0),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: 'Tu texto aquí'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () {
              tc.replaceWord(index, controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('GUARDAR'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChips(TextContextWidgetState tc) {
    final chips = <Widget>[];
    final words = tc.getWords();
    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      chips.add(
        InputChip(
          label: Text(word),
          deleteIconColor: const Color(0xFF767676),
          labelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
          onPressed: () => _showEditDialog(word, i, tc),
          onDeleted: () => tc.deleteWord(word),
        ),
      );
    }
    chips.add(
      TextField(
        maxLines: null,
        controller: _textInputController,
        decoration: const InputDecoration(hintText: 'Tu texto aquí'),
        onChanged: (value) {
          tc.onTextChange(value);
          if (tc.getText().isEmpty) {
            _textInputController.clear();
          }
        },
      ),
    );
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 1.0,
          children: _buildChips(tc),
        ),
      ),
    );
  }
}
