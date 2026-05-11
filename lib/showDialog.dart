import 'package:flutter/material.dart';

Future<String?> showCreateCategoryDialog(BuildContext context) =>
    _showOneFieldDialog(
      context: context,
      dialogTitle: 'AÑADIR CATEGORÍA',
      fieldLabel: 'Nombre de la categoría',
      actionLabel: 'AÑADIR',
    );

Future<String?> showEditCategoryDialog(
        BuildContext context, String oldCategoryText) =>
    _showOneFieldDialog(
      context: context,
      dialogTitle: 'EDITAR CATEGORÍA',
      fieldLabel: 'Nuevo nombre de la categoría',
      actionLabel: 'GUARDAR',
      oldValue: oldCategoryText,
    );

Future<String?> showCreatePhraseDialog(BuildContext context) =>
    _showOneFieldDialog(
      context: context,
      dialogTitle: 'AÑADIR FRASE',
      fieldLabel: 'Nueva frase',
      actionLabel: 'AÑADIR',
    );

Future<String?> showEditPhraseDialog(
        BuildContext context, String oldPhraseText) =>
    _showOneFieldDialog(
      context: context,
      dialogTitle: 'EDITAR FRASE',
      fieldLabel: 'Nueva frase',
      actionLabel: 'GUARDAR',
      oldValue: oldPhraseText,
    );

Future<bool?> showRemoveConfirmationDialog(
        BuildContext context, String message, String value) =>
    _showConfirmationDialog(
      context: context,
      confirmationMessage: message,
      value: value,
      actionLabel: 'ELIMINAR',
    );

Future<String?> _showOneFieldDialog({
  required BuildContext context,
  required String dialogTitle,
  required String fieldLabel,
  required String actionLabel,
  String oldValue = '',
}) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dialogTitle),
          const Divider(),
          if (oldValue.isNotEmpty)
            Text(oldValue,
                style: const TextStyle(
                    fontSize: 15.0, color: Colors.black87)),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 50, maxHeight: 80),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: fieldLabel,
            hintStyle:
                const TextStyle(fontSize: 15.0, color: Colors.black38),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          style: TextButton.styleFrom(foregroundColor: Colors.black87),
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, controller.text),
          child: Text(actionLabel),
        ),
      ],
    ),
  );
}

Future<bool?> _showConfirmationDialog({
  required BuildContext context,
  required String confirmationMessage,
  required String actionLabel,
  required String value,
}) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(confirmationMessage),
          const Divider(),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 50, maxHeight: 80),
        child:
            Text(value, style: const TextStyle(color: Colors.black87)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          style: TextButton.styleFrom(foregroundColor: Colors.black87),
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text(actionLabel),
        ),
      ],
    ),
  );
}
