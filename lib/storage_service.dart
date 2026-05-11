import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _categoriesKey = 'categories';
  static const String _settingsKey = 'app_settings';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  List<dynamic>? getCategories() {
    final raw = _prefs.getString(_categoriesKey);
    if (raw == null) return null;
    return jsonDecode(raw) as List<dynamic>;
  }

  Future<void> saveCategories(List<Map<String, dynamic>> data) async {
    await _prefs.setString(_categoriesKey, jsonEncode(data));
  }

  Map<String, dynamic>? getAppSettings() {
    final raw = _prefs.getString(_settingsKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> saveAppSettings(Map<String, dynamic> data) async {
    await _prefs.setString(_settingsKey, jsonEncode(data));
  }
}
