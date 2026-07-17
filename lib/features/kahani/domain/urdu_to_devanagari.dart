// ============================================================
// Zawiyah — Roman Urdu → Devanagari Transliteration
// lib/features/kahani/domain/urdu_to_devanagari.dart
//
// Converts Roman Urdu text to Devanagari script, so it can be spoken
// via a Hindi (hi-IN) TTS voice instead of requiring an Urdu voice to
// be installed. Spoken Urdu and Hindi are the same language
// (Hindustani) with different scripts, so this works well for
// pronunciation -- Hindi voices are far more commonly pre-installed
// on phones/computers than Urdu ones.
//
// HONEST CAVEAT: this is an approximate, rule-based transliteration,
// not a linguistically perfect one. Known limitations:
//   - Doesn't distinguish dental vs retroflex t/d/n (Roman Urdu
//     doesn't reliably disambiguate these either)
//   - Urdu-specific sounds borrowed from Arabic/Persian (qaaf, ghain,
//     etc.) are approximated to their nearest Hindi-writable form
//   - Schwa deletion (when a word-final "inherent a" is silent) is
//     only handled for the very last consonant, not mid-word clusters
// This should be spot-checked by ear once running, since text-based
// testing alone can't confirm actual pronunciation quality.
// ============================================================

const Map<String, String> _vowelMatras = {
  'aa': '\u093E',
  'i': '\u093F',
  'ee': '\u0940',
  'u': '\u0941',
  'oo': '\u0942',
  'e': '\u0947',
  'ai': '\u0948',
  'o': '\u094B',
  'au': '\u094C',
};

const Map<String, String> _independentVowels = {
  'a': '\u0905',
  'aa': '\u0906',
  'i': '\u0907',
  'ee': '\u0908',
  'u': '\u0909',
  'oo': '\u090A',
  'e': '\u090F',
  'ai': '\u0910',
  'o': '\u0913',
  'au': '\u0914',
};

// Ordered longest-match-first; each entry is (roman, devanagariBase).
const List<List<String>> _consonants = [
  ['kh', '\u0916'],
  ['gh', '\u0918'],
  ['chh', '\u091B'],
  ['ch', '\u091A'],
  ['jh', '\u091D'],
  ['th', '\u0925'],
  ['dh', '\u0927'],
  ['bh', '\u092D'],
  ['ph', '\u092B'],
  ['sh', '\u0936'],
  ['ng', '\u0919'],
  ['q', '\u0958'], // qaaf -> क़
  ['z', '\u095B'], // ज़
  ['f', '\u095E'], // फ़
  ['k', '\u0915'],
  ['g', '\u0917'],
  ['j', '\u091C'],
  ['t', '\u0924'],
  ['d', '\u0926'],
  ['n', '\u0928'],
  ['p', '\u092A'],
  ['b', '\u092C'],
  ['m', '\u092E'],
  ['y', '\u092F'],
  ['r', '\u0930'],
  ['l', '\u0932'],
  ['v', '\u0935'],
  ['w', '\u0935'],
  ['s', '\u0938'],
  ['h', '\u0939'],
];

const String _virama = '\u094D';

List<String> _vowelKeysSorted() {
  final keys = {..._vowelMatras.keys, ..._independentVowels.keys}.toList();
  keys.sort((a, b) => b.length.compareTo(a.length));
  return keys;
}

final List<String> _vowelKeys = _vowelKeysSorted();
final List<List<String>> _consonantKeys = [..._consonants]
  ..sort((a, b) => b[0].length.compareTo(a[0].length));

String? _matchAt(String s, int i, List<String> keys) {
  for (final k in keys) {
    if (i + k.length <= s.length && s.substring(i, i + k.length) == k) {
      return k;
    }
  }
  return null;
}

List<String>? _matchConsonantAt(String s, int i) {
  for (final entry in _consonantKeys) {
    final k = entry[0];
    if (i + k.length <= s.length && s.substring(i, i + k.length) == k) {
      return entry;
    }
  }
  return null;
}

String _transliterateWord(String word) {
  final lower = word.toLowerCase();
  final buffer = StringBuffer();
  int i = 0;
  final n = lower.length;

  while (i < n) {
    final consonantMatch = _matchConsonantAt(lower, i);
    if (consonantMatch != null) {
      final roman = consonantMatch[0];
      final devanagari = consonantMatch[1];
      i += roman.length;

      final vowel = _matchAt(lower, i, _vowelKeys);
      if (vowel != null) {
        i += vowel.length;
        if (vowel == 'a') {
          buffer.write(devanagari); // inherent vowel, no matra needed
        } else {
          buffer.write(devanagari + (_vowelMatras[vowel] ?? ''));
        }
      } else {
        // No vowel follows -- consonant cluster. Add virama unless
        // this is the last character of the word (schwa deletion:
        // word-final inherent 'a' is typically silent in spoken
        // Hindi/Urdu, so we drop the virama there for a more natural
        // pronunciation rather than an abrupt consonant stop).
        if (i < n) {
          buffer.write(devanagari + _virama);
        } else {
          buffer.write(devanagari);
        }
      }
      continue;
    }

    final vowelMatch = _matchAt(lower, i, _vowelKeys);
    if (vowelMatch != null) {
      i += vowelMatch.length;
      buffer.write(_independentVowels[vowelMatch] ?? '');
      continue;
    }

    // Unknown character (space, punctuation, digit) -- pass through.
    buffer.write(lower[i]);
    i++;
  }

  return buffer.toString();
}

/// Converts a full block of Roman Urdu text to Devanagari, word by
/// word, preserving whitespace and punctuation.
String romanUrduToDevanagari(String text) {
  return text.split(' ').map((w) {
    if (w.trim().isEmpty) return w;
    return _transliterateWord(w);
  }).join(' ');
}
