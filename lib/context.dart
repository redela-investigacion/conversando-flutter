import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:conversando/models.dart';
import 'package:conversando/storage_service.dart';
import 'package:conversando/text_utils.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class _TextContext extends InheritedWidget {
  const _TextContext({required super.child, required this.data});

  final TextContextWidgetState data;

  @override
  bool updateShouldNotify(_TextContext oldWidget) => true;
}

class TextContextWidget extends StatefulWidget {
  const TextContextWidget({
    super.key,
    required this.child,
    required this.storage,
  });

  final Widget child;
  final StorageService storage;

  @override
  TextContextWidgetState createState() => TextContextWidgetState();

  static TextContextWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_TextContext>()!.data;
  }
}

class TextContextWidgetState extends State<TextContextWidget> {
  static const List<String> _whiteSpaceSymbols = [' '];
  static const List<String> _punctuationSymbols = [
    '.', ',', ';', ':', '?', '¿', '!', '¡', "'", '\\', '-',
  ];

  final FlutterTts _tts = FlutterTts();

  String _text = '';
  List<String> _words = [];
  final Map<String, Category> _categories = {};
  AppSettings _appSettings = const AppSettings();

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
    _applyTtsSettings();
  }

  Future<void> _applyTtsSettings() async {
    await _tts.setLanguage(_appSettings.speechLanguage);
    await _tts.setSpeechRate(_appSettings.speechRate);
    await _tts.setPitch(_appSettings.speechPitch);
  }

  void _loadFromStorage() {
    final settingsJson = widget.storage.getAppSettings();
    if (settingsJson != null) {
      _appSettings = AppSettings.fromJson(settingsJson);
    }

    final rawCategories = widget.storage.getCategories();
    if (rawCategories != null) {
      for (final json in rawCategories) {
        final cat = Category.fromJson(json as Map<String, dynamic>);
        _categories[cat.id] = cat;
      }
    } else {
      _addDefaultCategories();
      _persistCategories();
    }
  }

  void _addDefaultCategories() {
    final cat1 = Category(_uuid.v4(), '😍 Saludos')
      ..addPhrase('Hola')
      ..addPhrase('¿Qué pasa?');
    final cat2 = Category(_uuid.v4(), '🌎 En casa')
      ..addPhrase('¿Puedes subir el volumen de la televisión?')
      ..addPhrase('Por favor, tráeme un vaso de agua');
    final cat3 = Category(_uuid.v4(), '😙 Cosas que me gustan');
    final cat4 = Category(_uuid.v4(), '🌐 Preguntas');
    for (final cat in [cat1, cat2, cat3, cat4]) {
      _categories[cat.id] = cat;
    }
  }

  Future<void> _persistCategories() async {
    await widget.storage.saveCategories(
      _categories.values.map((c) => c.toJson()).toList(),
    );
  }

  void onTextChange(String inputText) {
    setState(() {
      if (inputText.isEmpty) {
        _text = '';
        return;
      }
      final word = inputText.substring(0, inputText.length - 1).trim();
      final symbol = inputText[inputText.length - 1];
      if (_whiteSpaceSymbols.contains(symbol)) {
        _text = '';
        if (word.isNotEmpty) _words.add(word);
      } else if (_punctuationSymbols.contains(symbol)) {
        _text = '';
        if (word.isNotEmpty) _words.add(word);
        _words.add(symbol);
      } else {
        _text = inputText;
      }
    });
  }

  void deleteWord(String word) => setState(() => _words.remove(word));

  void replaceWord(int index, String text) {
    setState(() => _words.replaceRange(index, index + 1, tokenize(text)));
  }

  void appendText(String text) =>
      setState(() => _words.addAll(tokenize(text)));

  String getText() => _text;
  List<String> getWords() => List.unmodifiable(_words);

  String getTextPhrase() {
    final parts = [..._words, if (_text.isNotEmpty) _text];
    return parts.join(' ');
  }

  void clearWords() => setState(() => _words = []);
  void clearText() => setState(() => _text = '');

  Category addCategory(String categoryText) {
    final id = _uuid.v4();
    final cat = Category(id, categoryText);
    setState(() => _categories[id] = cat);
    _persistCategories();
    return cat;
  }

  List<Category> getCategories() => _categories.values.toList();

  void editCategory(Category cat, String text) {
    setState(() => _categories[cat.id]!.text = text);
    _persistCategories();
  }

  void removeCategory(Category cat) {
    setState(() => _categories.remove(cat.id));
    _persistCategories();
  }

  void save(String categoryId, String phrase) {
    setState(() => _categories[categoryId]!.addPhrase(phrase));
    _persistCategories();
  }

  void editPhrase(Category cat, Phrase p, String text) {
    setState(() => _categories[cat.id]!.editPhrase(p.id, text));
    _persistCategories();
  }

  void removePhrase(Category cat, Phrase p) {
    setState(() => _categories[cat.id]!.removePhrase(p.id));
    _persistCategories();
  }

  AppSettings getAppSettings() => _appSettings;

  Future<void> updateSettings(AppSettings settings) async {
    setState(() => _appSettings = settings);
    await _applyTtsSettings();
    await widget.storage.saveAppSettings(settings.toJson());
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _TextContext(data: this, child: widget.child);
}
