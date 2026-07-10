// ============================================================
// Zawiyah — Kahani Content Model
// lib/features/kahani/domain/kahani_item.dart
//
// Each field is nullable because not every kahani has content in
// every language/script yet.
//
// PROVENANCE: aiTranslatedLanguages marks which language variants are
// AI-generated translations (per the Constitution's Article VII
// permission for AI to translate) rather than original sourced text.
// The UI must surface this distinction -- an AI translation of a
// devotional narrative is a genuinely different provenance tier than
// the original text itself, and per the app's own Provenance model
// this should never be silently presented as equally authoritative.
// ============================================================

class KahaniItem {
  final String id;
  final String title;
  final String? aamal;
  final String? english;
  final String? urduScript;
  final String? romanUrdu;
  final String? arabic;
  final Set<String> aiTranslatedLanguages;

  const KahaniItem({
    required this.id,
    required this.title,
    this.aamal,
    this.english,
    this.urduScript,
    this.romanUrdu,
    this.arabic,
    this.aiTranslatedLanguages = const {},
  });

  static const _languageOrder = ['english', 'urduScript', 'romanUrdu', 'arabic'];
  static const _languageLabels = {
    'english': 'English',
    'urduScript': 'Urdu',
    'romanUrdu': 'Roman Urdu',
    'arabic': 'Arabic',
  };
  // TTS locale to use for each language key -- Roman Urdu still reads
  // with the Urdu voice, since it's the same language just transliterated.
  static const _ttsLocales = {
    'english': 'en-GB',
    'urduScript': 'ur-PK',
    'romanUrdu': 'ur-PK',
    'arabic': 'ar',
  };

  List<String> get availableLanguages => _languageOrder
      .where((key) => textFor(key) != null)
      .toList(growable: false);

  String labelFor(String languageKey) => _languageLabels[languageKey] ?? languageKey;

  String ttsLocaleFor(String languageKey) => _ttsLocales[languageKey] ?? 'en-GB';

  bool isAiTranslation(String languageKey) =>
      aiTranslatedLanguages.contains(languageKey);

  /// The text that should actually be SPOKEN for a given selected
  /// language -- distinct from what's DISPLAYED. TTS engines read
  /// based on script, not phonetic intent: feeding Roman Urdu (Latin
  /// letters) to an Urdu voice engine does not produce correct Urdu
  /// pronunciation, since the voice expects actual Urdu script. So
  /// when "Roman Urdu" is selected, we still display the Roman Urdu
  /// text (for readers who prefer that script) but speak the real
  /// Urdu-script version underneath, falling back to the Roman Urdu
  /// text only if no Urdu-script version exists for this kahani yet.
  String? speakableTextFor(String languageKey) {
    if (languageKey == 'romanUrdu') {
      return urduScript ?? romanUrdu;
    }
    return textFor(languageKey);
  }

  String? textFor(String languageKey) {
    switch (languageKey) {
      case 'english':
        return english;
      case 'urduScript':
        return urduScript;
      case 'romanUrdu':
        return romanUrdu;
      case 'arabic':
        return arabic;
      default:
        return null;
    }
  }

  bool isRtlFor(String languageKey) =>
      languageKey == 'urduScript' || languageKey == 'arabic';
}
