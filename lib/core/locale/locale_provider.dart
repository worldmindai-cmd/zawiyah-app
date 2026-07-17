// ============================================================
// Zawiyah — App Locale Provider
// lib/core/locale/locale_provider.dart
//
// Reads the language chosen during onboarding (stored as a plain
// language code -- 'en'/'ur'/'ar' -- via LocalStorageService) and
// exposes it as the Locale MaterialApp should use. Null means "no
// explicit choice yet," which lets MaterialApp fall back to its
// normal device-locale resolution against supportedLocales.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/local_storage_service.dart';

final appLocaleProvider = FutureProvider<Locale?>((ref) async {
  final language = await LocalStorageService().getString('app_language');
  return language == null ? null : Locale(language);
});
