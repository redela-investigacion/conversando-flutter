import 'package:conversando/commons.dart';
import 'package:conversando/context.dart';
import 'package:conversando/models.dart';
import 'package:conversando/scroll.dart';
import 'package:conversando/showDialog.dart';
import 'package:flutter/material.dart';

class CategoryManagerWidget extends StatelessWidget {
  const CategoryManagerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis frases'),
        actions: [
          ActionBarButtonWidget('AÑADIR', () {
            showCreateCategoryDialog(context).then((value) {
              if (value != null && value.isNotEmpty) {
                tc.addCategory(value);
              }
            });
          }),
        ],
      ),
      body: Column(
        children: [
          const ListTile(
              title: Text('Mis categorías',
                  style: TextStyle(fontSize: 18.0))),
          const Divider(),
          Expanded(
            child: ListViewWithScroll(
              children: tc.getCategories().map((category) {
                return _CategoryEditorWidget(category);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryEditorWidget extends StatelessWidget {
  final Category _category;

  const _CategoryEditorWidget(this._category);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(_category.text),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => _PhraseManagerWidget(_category)),
            ),
          ),
        ),
        _RemoveCategoryButton(_category),
        _EditCategoryButton(_category),
      ],
    );
  }
}

class _RemoveCategoryButton extends StatelessWidget {
  final Category _category;

  const _RemoveCategoryButton(this._category);

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    final canDelete = _category.getPhrases().isEmpty;
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red[300],
      disabledColor: Colors.grey,
      tooltip:
          canDelete ? 'Eliminar categoría' : 'La categoría tiene frases',
      onPressed: canDelete
          ? () {
              showRemoveConfirmationDialog(
                context,
                '¿Deseas eliminar la siguiente categoría?',
                _category.text,
              ).then((confirmed) {
                if (confirmed == true) tc.removeCategory(_category);
              });
            }
          : null,
    );
  }
}

class _EditCategoryButton extends StatelessWidget {
  final Category _category;

  const _EditCategoryButton(this._category);

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return IconButton(
      icon: const Icon(Icons.edit),
      color: Colors.black54,
      tooltip: 'Editar categoría',
      onPressed: () {
        showEditCategoryDialog(context, _category.text).then((value) {
          if (value != null && value.isNotEmpty) {
            tc.editCategory(_category, value);
          }
        });
      },
    );
  }
}

class _PhraseManagerWidget extends StatelessWidget {
  final Category _category;

  const _PhraseManagerWidget(this._category);

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.text),
        actions: [
          ActionBarButtonWidget('AÑADIR', () {
            showCreatePhraseDialog(context).then((value) {
              if (value != null && value.isNotEmpty) {
                tc.save(_category.id, value);
              }
            });
          }),
        ],
      ),
      body: ListView(
        children: _category.getPhrases().map((phrase) {
          return _PhraseEditorWidget(_category, phrase);
        }).toList(),
      ),
    );
  }
}

class _PhraseEditorWidget extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  const _PhraseEditorWidget(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(title: Text(_phrase.text)),
            ),
            _RemovePhraseButton(_category, _phrase),
            _EditPhraseButton(_category, _phrase),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class _RemovePhraseButton extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  const _RemovePhraseButton(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red[300],
      tooltip: 'Eliminar frase',
      onPressed: () {
        showRemoveConfirmationDialog(
          context,
          '¿Deseas eliminar la siguiente frase?',
          _phrase.text,
        ).then((confirmed) {
          if (confirmed == true) tc.removePhrase(_category, _phrase);
        });
      },
    );
  }
}

class _EditPhraseButton extends StatelessWidget {
  final Category _category;
  final Phrase _phrase;

  const _EditPhraseButton(this._category, this._phrase);

  @override
  Widget build(BuildContext context) {
    final tc = TextContextWidget.of(context);
    return IconButton(
      icon: const Icon(Icons.edit),
      color: Colors.black54,
      tooltip: 'Editar frase',
      onPressed: () {
        showEditPhraseDialog(context, _phrase.text).then((value) {
          if (value != null && value.isNotEmpty) {
            tc.editPhrase(_category, _phrase, value);
          }
        });
      },
    );
  }
}
