import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:conversando/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    storage = StorageService(prefs);
  });

  group('StorageService — categories', () {
    test('getCategories returns null when nothing stored', () {
      expect(storage.getCategories(), isNull);
    });

    test('saveCategories then getCategories round-trips data', () async {
      final data = [
        {
          'id': 'cat-1',
          'text': 'Saludos',
          'phrases': [
            {'id': 'p-1', 'text': 'Hola'}
          ]
        }
      ];
      await storage.saveCategories(data);
      final result = storage.getCategories();
      expect(result, isNotNull);
      expect(result!, hasLength(1));
      expect(result.first['id'], 'cat-1');
      expect(result.first['text'], 'Saludos');
      final phrases = result.first['phrases'] as List;
      expect(phrases.first['text'], 'Hola');
    });

    test('saveCategories overwrites previous data', () async {
      await storage.saveCategories([
        {'id': 'cat-1', 'text': 'Vieja', 'phrases': []}
      ]);
      await storage.saveCategories([
        {'id': 'cat-2', 'text': 'Nueva', 'phrases': []}
      ]);
      final result = storage.getCategories()!;
      expect(result, hasLength(1));
      expect(result.first['text'], 'Nueva');
    });

    test('saveCategories handles empty list', () async {
      await storage.saveCategories([]);
      final result = storage.getCategories();
      expect(result, isNotNull);
      expect(result!, isEmpty);
    });

    test('saveCategories preserves multiple categories', () async {
      final data = [
        {'id': 'cat-1', 'text': 'A', 'phrases': []},
        {'id': 'cat-2', 'text': 'B', 'phrases': []},
        {'id': 'cat-3', 'text': 'C', 'phrases': []},
      ];
      await storage.saveCategories(data);
      final result = storage.getCategories()!;
      expect(result, hasLength(3));
      expect(result.map((c) => c['text']).toList(), ['A', 'B', 'C']);
    });
  });

  group('StorageService — app settings', () {
    test('getAppSettings returns null when nothing stored', () {
      expect(storage.getAppSettings(), isNull);
    });

    test('saveAppSettings then getAppSettings round-trips data', () async {
      final data = {
        'speechRate': 0.7,
        'speechPitch': 1.2,
        'speechLanguage': 'es-MX',
        'fontSize': 20.0
      };
      await storage.saveAppSettings(data);
      final result = storage.getAppSettings();
      expect(result, isNotNull);
      expect(result!['speechRate'], 0.7);
      expect(result['speechPitch'], 1.2);
      expect(result['speechLanguage'], 'es-MX');
      expect(result['fontSize'], 20.0);
    });

    test('saveAppSettings overwrites previous settings', () async {
      await storage.saveAppSettings({'speechRate': 0.3});
      await storage.saveAppSettings({'speechRate': 0.9});
      expect(storage.getAppSettings()!['speechRate'], 0.9);
    });

    test('categories and settings are stored independently', () async {
      await storage.saveCategories([
        {'id': 'cat-1', 'text': 'Test', 'phrases': []}
      ]);
      await storage.saveAppSettings({'speechRate': 0.5});
      expect(storage.getCategories(), hasLength(1));
      expect(storage.getAppSettings()!['speechRate'], 0.5);
    });
  });
}
