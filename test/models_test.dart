import 'package:flutter_test/flutter_test.dart';
import 'package:conversando/models.dart';

void main() {
  group('Phrase', () {
    test('stores id and text', () {
      final phrase = Phrase('id-1', 'Hola');
      expect(phrase.id, 'id-1');
      expect(phrase.text, 'Hola');
    });

    test('text is mutable', () {
      final phrase = Phrase('id-1', 'Hola');
      phrase.text = 'Adiós';
      expect(phrase.text, 'Adiós');
    });
  });

  group('Category', () {
    test('starts with no phrases', () {
      final cat = Category('cat-1', 'Saludos');
      expect(cat.getPhrases(), isEmpty);
    });

    test('addPhrase creates phrase with generated id', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      final phrases = cat.getPhrases();
      expect(phrases, hasLength(1));
      expect(phrases.first.text, 'Hola');
      expect(phrases.first.id, isNotEmpty);
    });

    test('addPhrase creates unique ids for multiple phrases', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      cat.addPhrase('Adiós');
      final ids = cat.getPhrases().map((p) => p.id).toSet();
      expect(ids, hasLength(2));
    });

    test('addPhraseWithId preserves the given id', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhraseWithId('fixed-id', 'Hola');
      expect(cat.getPhrases().first.id, 'fixed-id');
    });

    test('removePhrase deletes phrase by id', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      final phraseId = cat.getPhrases().first.id;
      cat.removePhrase(phraseId);
      expect(cat.getPhrases(), isEmpty);
    });

    test('removePhrase ignores unknown id', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      cat.removePhrase('nonexistent-id');
      expect(cat.getPhrases(), hasLength(1));
    });

    test('editPhrase updates text', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      final phraseId = cat.getPhrases().first.id;
      cat.editPhrase(phraseId, 'Buenos días');
      expect(cat.getPhrases().first.text, 'Buenos días');
    });

    test('editPhrase ignores unknown id', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhrase('Hola');
      cat.editPhrase('nonexistent-id', 'Nuevo texto');
      expect(cat.getPhrases().first.text, 'Hola');
    });

    test('toJson serializes id, text and phrases', () {
      final cat = Category('cat-1', 'Saludos');
      cat.addPhraseWithId('p-1', 'Hola');
      final json = cat.toJson();
      expect(json['id'], 'cat-1');
      expect(json['text'], 'Saludos');
      final phrases = json['phrases'] as List;
      expect(phrases, hasLength(1));
      expect(phrases.first['id'], 'p-1');
      expect(phrases.first['text'], 'Hola');
    });

    test('fromJson round-trips correctly', () {
      final original = Category('cat-1', 'Saludos');
      original.addPhraseWithId('p-1', 'Hola');
      final restored = Category.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.text, original.text);
      expect(restored.getPhrases().first.text, 'Hola');
      expect(restored.getPhrases().first.id, 'p-1');
    });

    test('fromJson handles empty phrases list', () {
      final json = {'id': 'cat-1', 'text': 'Vacía', 'phrases': []};
      final cat = Category.fromJson(json);
      expect(cat.getPhrases(), isEmpty);
    });
  });

  group('AppSettings', () {
    test('has correct defaults', () {
      const settings = AppSettings();
      expect(settings.speechRate, 0.5);
      expect(settings.speechPitch, 1.0);
      expect(settings.speechLanguage, 'es-ES');
      expect(settings.fontSize, 16.0);
    });

    test('copyWith overrides only specified fields', () {
      const original = AppSettings();
      final modified = original.copyWith(speechRate: 0.8);
      expect(modified.speechRate, 0.8);
      expect(modified.speechPitch, original.speechPitch);
      expect(modified.speechLanguage, original.speechLanguage);
      expect(modified.fontSize, original.fontSize);
    });

    test('copyWith with no arguments returns equal value', () {
      const original = AppSettings(speechRate: 0.7, fontSize: 20.0);
      final copy = original.copyWith();
      expect(copy, equals(original));
    });

    test('copyWith all fields', () {
      const original = AppSettings();
      final modified = original.copyWith(
        speechRate: 0.3,
        speechPitch: 1.5,
        speechLanguage: 'es-MX',
        fontSize: 24.0,
      );
      expect(modified.speechRate, 0.3);
      expect(modified.speechPitch, 1.5);
      expect(modified.speechLanguage, 'es-MX');
      expect(modified.fontSize, 24.0);
    });

    test('toJson produces correct map', () {
      const settings =
          AppSettings(speechRate: 0.3, speechLanguage: 'es-MX');
      final json = settings.toJson();
      expect(json['speechRate'], 0.3);
      expect(json['speechLanguage'], 'es-MX');
      expect(json['speechPitch'], 1.0);
      expect(json['fontSize'], 16.0);
    });

    test('fromJson restores values', () {
      const original =
          AppSettings(speechRate: 0.3, speechLanguage: 'ca-ES');
      final restored = AppSettings.fromJson(original.toJson());
      expect(restored, equals(original));
    });

    test('fromJson uses defaults for missing keys', () {
      final settings = AppSettings.fromJson({});
      expect(settings, equals(const AppSettings()));
    });

    test('equality holds for same values', () {
      const a = AppSettings(speechRate: 0.5);
      const b = AppSettings(speechRate: 0.5);
      expect(a, equals(b));
    });

    test('inequality for different values', () {
      const a = AppSettings(speechRate: 0.5);
      const b = AppSettings(speechRate: 0.8);
      expect(a, isNot(equals(b)));
    });

    test('hashCode is consistent with equality', () {
      const a = AppSettings(speechRate: 0.5, speechLanguage: 'es-ES');
      const b = AppSettings(speechRate: 0.5, speechLanguage: 'es-ES');
      expect(a.hashCode, equals(b.hashCode));
    });
  });
}
