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

import 'urdu_to_devanagari.dart';

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
  // TTS locale to use for each language key. Urdu routes through
  // Hindi (hi-IN) since Hindi voices are far more commonly installed
  // than Urdu ones, and spoken Urdu/Hindi are the same language --
  // see urdu_to_devanagari.dart for the transliteration this depends on.
  static const _ttsLocales = {
    'english': 'en-GB',
    'urduScript': 'hi-IN',
    'romanUrdu': 'hi-IN',
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
  /// language. Urdu (either script) is transliterated to Devanagari
  /// and spoken via the Hindi voice (see ttsLocaleFor) -- see
  /// urdu_to_devanagari.dart for why. Falls back to the raw Urdu-
  /// script/Roman text if Devanagari conversion isn't applicable.
  String? speakableTextFor(String languageKey) {
    if (languageKey == 'romanUrdu' && romanUrdu != null) {
      return romanUrduToDevanagari(romanUrdu!);
    }
    if (languageKey == 'urduScript') {
      // Prefer transliterating from Roman Urdu if we have it (more
      // reliable input for this rule-based converter than parsing
      // Urdu/Arabic script directly, which this converter doesn't
      // handle at all yet). Fall back to displaying the raw script
      // text if no Roman Urdu variant exists for this item.
      return romanUrdu != null
          ? romanUrduToDevanagari(romanUrdu!)
          : urduScript;
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
