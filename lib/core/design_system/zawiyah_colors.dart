// ============================================================
// Zawiyah — Design System: Colors
// lib/core/design_system/zawiyah_colors.dart
//
// Palette carried over directly from the HTML/JS prototype's CSS
// custom properties, so the visual identity is preserved exactly
// as it heads into the real Flutter build.
//
// Two palettes exist: the normal palette, and the "mourning" palette
// used automatically during Ayam-e-Aza / Shahadat days (see the
// Calendar Engine / Theme Engine, which switches between them based
// on the Hijri calendar -- this file only defines the colors, not
// the switching logic).
// ============================================================

import 'package:flutter/material.dart';

class ZawiyahColors {
  ZawiyahColors._();

  // ── Normal palette ──────────────────────────────────────────
  static const Color background = Color(0xFF050505);
  static const Color card = Color(0xFF111111);
  static const Color card2 = Color(0xFF171717);
  static const Color gold = Color(0xFFD6B25E);
  static const Color green = Color(0xFF2FAF7A);
  static const Color red = Color(0xFFB83D3D);
  static const Color text = Color(0xFFF6F1E8);
  static const Color muted = Color(0xFFBFB7AA);
  static const Color divider = Color(0xFF252525);
  static const Color divider2 = Color(0xFF292929);
  static const Color buttonBorder = Color(0xFF3A3A3A);
  static const Color buttonBg = Color(0xFF1B1B1B);

  // ── Mourning palette (Ayam-e-Aza / Shahadat days) ───────────
  // Muted, subdued tones -- deliberately less vibrant than the
  // normal palette, matching the prototype's `body.mourning` styles.
  static const Color mourningBackground = Color(0xFF020202);
  static const Color mourningBackgroundEnd = Color(0xFF090909);
  static const Color mourningDivider = Color(0xFF3A2020);
  static const Color mourningCardBorder = Color(0xFF332020);
  static const Color mourningHeading = Color(0xFFD0D0D0);
  static const Color mourningLabel = Color(0xFFC84D4D);
  static const Color mourningProgress = Color(0xFF7D1F1F);
}
