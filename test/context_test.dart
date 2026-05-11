import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:conversando/context.dart';
import 'package:conversando/storage_service.dart';
import 'package:conversando/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    storage = StorageService(prefs);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (_) async => null,
    );
  });

  Widget wrap(Widget child) => MaterialApp(
        home: TextContextWidget(storage: storage, child: child),
      );

  testWidgets('loads 4 default categories on first launch', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    expect(tc.getCategories(), hasLength(4));
  });

  testWidgets('loads persisted categories from storage', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final preloaded = StorageService(prefs);
    await preloaded.saveCategories([
      {'id': 'cat-x', 'text': 'Guardada', 'phrases': []},
    ]);

    late TextContextWidgetState tc;
    await tester.pumpWidget(MaterialApp(
      home: TextContextWidget(
        storage: preloaded,
        child: Builder(builder: (ctx) {
          tc = TextContextWidget.of(ctx);
          return const SizedBox.shrink();
        }),
      ),
    ));
    await tester.pump();
    expect(tc.getCategories(), hasLength(1));
    expect(tc.getCategories().first.text, 'Guardada');
  });

  testWidgets('getTextPhrase is empty initially', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    expect(tc.getTextPhrase(), isEmpty);
  });

  testWidgets('appendText adds tokenized words', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.appendText('Hola mundo');
    await tester.pump();
    expect(tc.getWords(), ['Hola', 'mundo']);
  });

  testWidgets('getTextPhrase joins words with spaces', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.appendText('Hola mundo');
    await tester.pump();
    expect(tc.getTextPhrase(), 'Hola mundo');
  });

  testWidgets('deleteWord removes first matching word', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.appendText('Hola mundo');
    await tester.pump();
    tc.deleteWord('Hola');
    await tester.pump();
    expect(tc.getWords(), ['mundo']);
  });

  testWidgets('clearWords empties the word list', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.appendText('Hola mundo');
    await tester.pump();
    tc.clearWords();
    await tester.pump();
    expect(tc.getWords(), isEmpty);
    expect(tc.getTextPhrase(), isEmpty);
  });

  testWidgets('replaceWord substitutes a word at given index', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.appendText('Hola mundo');
    await tester.pump();
    tc.replaceWord(0, 'Buenos días');
    await tester.pump();
    expect(tc.getWords(), ['Buenos', 'días', 'mundo']);
  });

  testWidgets('onTextChange commits word when space typed', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.onTextChange('Hola ');
    await tester.pump();
    expect(tc.getWords(), ['Hola']);
    expect(tc.getText(), isEmpty);
  });

  testWidgets('onTextChange commits word and punctuation on period',
      (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.onTextChange('Hola.');
    await tester.pump();
    expect(tc.getWords(), ['Hola', '.']);
    expect(tc.getText(), isEmpty);
  });

  testWidgets('onTextChange keeps partial word in text buffer', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    tc.onTextChange('Hol');
    await tester.pump();
    expect(tc.getText(), 'Hol');
    expect(tc.getWords(), isEmpty);
  });

  testWidgets('addCategory creates a new category', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final initial = tc.getCategories().length;
    final cat = tc.addCategory('Nueva');
    await tester.pump();
    expect(tc.getCategories(), hasLength(initial + 1));
    expect(cat.text, 'Nueva');
    expect(cat.id, isNotEmpty);
  });

  testWidgets('editCategory updates its text', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final cat = tc.addCategory('Original');
    await tester.pump();
    tc.editCategory(cat, 'Modificada');
    await tester.pump();
    expect(
      tc.getCategories().firstWhere((c) => c.id == cat.id).text,
      'Modificada',
    );
  });

  testWidgets('removeCategory deletes it', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final cat = tc.addCategory('Para borrar');
    await tester.pump();
    final countBefore = tc.getCategories().length;
    tc.removeCategory(cat);
    await tester.pump();
    expect(tc.getCategories(), hasLength(countBefore - 1));
    expect(tc.getCategories().where((c) => c.id == cat.id), isEmpty);
  });

  testWidgets('save adds a phrase to the correct category', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final cat = tc.addCategory('Test');
    await tester.pump();
    tc.save(cat.id, 'Nueva frase');
    await tester.pump();
    expect(cat.getPhrases(), hasLength(1));
    expect(cat.getPhrases().first.text, 'Nueva frase');
  });

  testWidgets('editPhrase updates phrase text', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final cat = tc.addCategory('Test');
    await tester.pump();
    tc.save(cat.id, 'Original');
    await tester.pump();
    final phrase = cat.getPhrases().first;
    tc.editPhrase(cat, phrase, 'Editada');
    await tester.pump();
    expect(cat.getPhrases().first.text, 'Editada');
  });

  testWidgets('removePhrase deletes it from the category', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    final cat = tc.addCategory('Test');
    await tester.pump();
    tc.save(cat.id, 'Para borrar');
    await tester.pump();
    final phrase = cat.getPhrases().first;
    tc.removePhrase(cat, phrase);
    await tester.pump();
    expect(cat.getPhrases(), isEmpty);
  });

  testWidgets('updateSettings persists new settings', (tester) async {
    late TextContextWidgetState tc;
    await tester.pumpWidget(wrap(Builder(builder: (ctx) {
      tc = TextContextWidget.of(ctx);
      return const SizedBox.shrink();
    })));
    await tester.pump();
    const newSettings = AppSettings(speechRate: 0.9, fontSize: 24.0);
    await tc.updateSettings(newSettings);
    await tester.pump();
    expect(tc.getAppSettings(), equals(newSettings));
  });
}
