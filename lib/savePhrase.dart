import 'package:conversando/commons.dart';
import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/models.dart';
import 'package:conversando/showDialog.dart';

class SavePhrase extends StatefulWidget {
  const SavePhrase({super.key});

  @override
  State<SavePhrase> createState() => SavePhraseState();
}

class SavePhraseState extends State<SavePhrase> {
  String? selectedCategory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (selectedCategory == null) {
      final tc = TextContextWidget.of(context);
      if (tc.getCategories().isNotEmpty) {
        selectedCategory = tc.getCategories().first.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    final categories = tc.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir frase'),
        actions: [
          ActionBarButtonWidget('GUARDAR', () {
            if (selectedCategory != null) {
              tc.save(selectedCategory!, tc.getTextPhrase());
              Navigator.pop(context, tc.getTextPhrase());
            }
          }),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Frase a guardar'),
                const SizedBox(height: 12.0),
                Text(
                  tc.getTextPhrase(),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('En la categoría:'),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    hint: const Text('Elige una categoría'),
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedCategory = value);
                      }
                    },
                    items: categories.map((Category cat) {
                      return DropdownMenuItem<String>(
                        value: cat.id,
                        child: Text(cat.text),
                      );
                    }).toList(),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 12.0),
                  label: const Text('Añadir categoría',
                      semanticsLabel: 'Añade una categoría nueva'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    showCreateCategoryDialog(context).then((value) {
                      if (value != null && value.isNotEmpty) {
                        final cat = tc.addCategory(value);
                        setState(() => selectedCategory = cat.id);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
