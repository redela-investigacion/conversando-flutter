import 'package:flutter_test/flutter_test.dart';
import 'package:conversando/text_utils.dart';

void main() {
  group('tokenize', () {
    test('returns empty list for empty string', () {
      expect(tokenize(''), isEmpty);
    });

    test('handles single word', () {
      expect(tokenize('Hola'), ['Hola']);
    });

    test('splits words on single space', () {
      expect(tokenize('Hola mundo'), ['Hola', 'mundo']);
    });

    test('splits words on multiple spaces', () {
      expect(tokenize('Hola  mundo'), ['Hola', 'mundo']);
    });

    test('handles leading and trailing spaces', () {
      expect(tokenize('  Hola  '), ['Hola']);
    });

    test('splits a multi-word phrase', () {
      final result = tokenize('Por favor tráeme un vaso de agua');
      expect(result, hasLength(7));
      expect(result.first, 'Por');
      expect(result.last, 'agua');
    });

    test('separates standalone punctuation between spaces', () {
      expect(tokenize('hola , mundo'), ['hola', ',', 'mundo']);
    });

    test('keeps punctuation attached to a word as one token', () {
      // \S+ is greedy — attached punctuation stays with the word
      expect(tokenize('¡Hola!'), ['¡Hola!']);
    });

    test('handles Spanish accented characters', () {
      final result = tokenize('Cómo estás');
      expect(result, ['Cómo', 'estás']);
    });

    test('handles emoji as tokens', () {
      expect(tokenize('Saludos 😍'), ['Saludos', '😍']);
    });

    test('handles numbers', () {
      expect(tokenize('Tengo 3 gatos'), ['Tengo', '3', 'gatos']);
    });

    test('returns only whitespace tokens as empty', () {
      expect(tokenize('   '), isEmpty);
    });
  });
}
