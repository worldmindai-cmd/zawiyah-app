// ============================================================
// Zawiyah — Design System: Typography
// lib/core/design_system/zawiyah_typography.dart
//
// Three distinct text treatments carried over from the prototype:
// Arabic (larger, RTL, serif Arabic-script font), transliteration
// (italic, aids pronunciation), and translation (muted, regular).
// This distinction matters for the Language Philosophy article in
// the Constitution -- Arabic stays visually central and dominant,
// translation supports rather than replaces it.
// ============================================================

import 'package:flutter/material.dart';
import 'zawiyah_colors.dart';

class ZawiyahTypography {
  ZawiyahTypography._();

  /// Arabic script text -- always RTL regardless of the app's current
  /// interface language, larger size, generous line height for
  /// diacritics/tashkeel legibility.
  static const TextStyle arabic = TextStyle(
    fontSize: 25,
    height: 2.05,
    color: Colors.white,
    // Font family resolution happens per-platform via the theme's
    // fontFamilyFallback -- iOS/Android both ship a usable Arabic
    // serif system font; a bundled font (e.g. Amiri) can be added
    // later if system fallback proves inconsistent.
  );

  /// Transliteration -- italic, slightly warm off-white, aids the
  /// gradual-familiarity-with-Arabic goal from the Language
  /// Philosophy article without replacing the Arabic itself.
  static const TextStyle transliteration = TextStyle(
    fontSize: 15,
    height: 1.55,
    fontStyle: FontStyle.italic,
    color: Color(0xFFE9DCC1),
  );

  /// Translation -- muted, regular weight, clearly secondary to the
  /// Arabic and transliteration above it.
  static const TextStyle translation = TextStyle(
    fontSize: 15,
    height: 1.55,
    color: ZawiyahColors.muted,
  );

  /// Section/category label -- small, uppercase, green accent.
  static const TextStyle label = TextStyle(
    fontSize: 12,
    letterSpacing: 0.8,
    color: ZawiyahColors.green,
    fontWeight: FontWeight.w600,
  );

  /// Screen/section heading.
  static const TextStyle heading = TextStyle(
    fontSize: 23,
    letterSpacing: 0.2,
    color: ZawiyahColors.gold,
    fontWeight: FontWeight.w700,
  );

  /// Subheading / subtitle under a main heading.
  static const TextStyle subtitle = TextStyle(
    fontSize: 13,
    color: ZawiyahColors.muted,
  );

  /// Body text for general UI copy (not devotional content itself).
  static const TextStyle body = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: ZawiyahColors.text,
  );
}
