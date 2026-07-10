// ============================================================
// Zawiyah — Design System: Theme Engine
// lib/core/design_system/zawiyah_theme.dart
//
// Combines colors + typography into real ThemeData, and switches
// between "normal" and "mourning" palettes based on the current
// Hijri date (see calendar/ for the date logic itself -- this file
// just exposes the two ThemeData variants and lets the app-level
// widget pick between them).
//
// RTL NOTE: this app supports English (LTR) alongside Arabic and
// Urdu (both RTL), with Persian (RTL) and French (LTR) planned later.
// Flutter's Directionality widget (driven by the current Locale via
// MaterialApp's localizationsDelegates) handles the actual text-flow
// mirroring automatically for any widget using EdgeInsetsDirectional,
// Alignment.centerStart/centerEnd, etc. instead of literal
// left/right values -- ALL new widgets in this app must use the
// directional variants, never hardcoded left/right, so RTL languages
// get correctly mirrored layout without special-casing.
// ============================================================

import 'package:flutter/material.dart';
import 'zawiyah_colors.dart';
import 'zawiyah_typography.dart';

class ZawiyahTheme {
  ZawiyahTheme._();

  static ThemeData get normal {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ZawiyahColors.background,
      colorScheme: const ColorScheme.dark(
        primary: ZawiyahColors.gold,
        secondary: ZawiyahColors.green,
        error: ZawiyahColors.red,
        surface: ZawiyahColors.card,
      ),
      textTheme: const TextTheme(
        headlineSmall: ZawiyahTypography.heading,
        bodyMedium: ZawiyahTypography.body,
        bodySmall: ZawiyahTypography.subtitle,
        labelSmall: ZawiyahTypography.label,
      ),
      dividerColor: ZawiyahColors.divider,
      cardTheme: CardThemeData(
        color: ZawiyahColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: ZawiyahColors.divider),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ZawiyahColors.background,
        foregroundColor: ZawiyahColors.gold,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ZawiyahColors.buttonBg,
          foregroundColor: ZawiyahColors.text,
          side: const BorderSide(color: ZawiyahColors.buttonBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // pill shape
          ),
        ),
      ),
    );
  }

  /// Mourning theme -- automatically applied during Ayam-e-Aza and
  /// Shahadat days (Calendar Engine determines when; this is purely
  /// the visual variant). Deliberately more subdued than `normal`.
  static ThemeData get mourning {
    return normal.copyWith(
      scaffoldBackgroundColor: ZawiyahColors.mourningBackground,
      colorScheme: normal.colorScheme.copyWith(
        primary: ZawiyahColors.mourningHeading,
        secondary: ZawiyahColors.mourningLabel,
      ),
      dividerColor: ZawiyahColors.mourningDivider,
      cardTheme: normal.cardTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: ZawiyahColors.mourningCardBorder),
        ),
      ),
      appBarTheme: normal.appBarTheme.copyWith(
        foregroundColor: ZawiyahColors.mourningHeading,
      ),
      textTheme: normal.textTheme.copyWith(
        headlineSmall: ZawiyahTypography.heading.copyWith(
          color: ZawiyahColors.mourningHeading,
        ),
        labelSmall: ZawiyahTypography.label.copyWith(
          color: ZawiyahColors.mourningLabel,
        ),
      ),
    );
  }
}
