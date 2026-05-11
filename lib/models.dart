import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Phrase {
  final String id;
  String text;

  Phrase(this.id, this.text);
}

class Category {
  final String id;
  String text;
  final Map<String, Phrase> _phrases = {};

  Category(this.id, this.text);

  void addPhrase(String phraseText) {
    final id = _uuid.v4();
    _phrases[id] = Phrase(id, phraseText);
  }

  void addPhraseWithId(String phraseId, String phraseText) {
    _phrases[phraseId] = Phrase(phraseId, phraseText);
  }

  List<Phrase> getPhrases() => _phrases.values.toList();

  void removePhrase(String phraseId) => _phrases.remove(phraseId);

  void editPhrase(String phraseId, String newText) {
    _phrases[phraseId]?.text = newText;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'phrases': getPhrases()
            .map((p) => {'id': p.id, 'text': p.text})
            .toList(),
      };

  factory Category.fromJson(Map<String, dynamic> json) {
    final cat = Category(json['id'] as String, json['text'] as String);
    for (final p in (json['phrases'] as List)) {
      cat.addPhraseWithId(p['id'] as String, p['text'] as String);
    }
    return cat;
  }
}

class AppSettings {
  final double speechRate;
  final double speechPitch;
  final String speechLanguage;
  final double fontSize;

  const AppSettings({
    this.speechRate = 0.5,
    this.speechPitch = 1.0,
    this.speechLanguage = 'es-ES',
    this.fontSize = 16.0,
  });

  AppSettings copyWith({
    double? speechRate,
    double? speechPitch,
    String? speechLanguage,
    double? fontSize,
  }) =>
      AppSettings(
        speechRate: speechRate ?? this.speechRate,
        speechPitch: speechPitch ?? this.speechPitch,
        speechLanguage: speechLanguage ?? this.speechLanguage,
        fontSize: fontSize ?? this.fontSize,
      );

  Map<String, dynamic> toJson() => {
        'speechRate': speechRate,
        'speechPitch': speechPitch,
        'speechLanguage': speechLanguage,
        'fontSize': fontSize,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        speechRate: (json['speechRate'] as num?)?.toDouble() ?? 0.5,
        speechPitch: (json['speechPitch'] as num?)?.toDouble() ?? 1.0,
        speechLanguage: json['speechLanguage'] as String? ?? 'es-ES',
        fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16.0,
      );

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.speechRate == speechRate &&
      other.speechPitch == speechPitch &&
      other.speechLanguage == speechLanguage &&
      other.fontSize == fontSize;

  @override
  int get hashCode =>
      Object.hash(speechRate, speechPitch, speechLanguage, fontSize);
}
