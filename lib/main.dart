// ============================================================
// Zawiyah — App Entry Point
// lib/main.dart
//
// Routes through AppGate (onboarding check via SQLite), theme
// switches automatically based on ZawiyahCalendar's Aza period.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/calendar/calendar_provider.dart';
import 'core/design_system/zawiyah_theme.dart';
import 'core/locale/locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'shared/navigation/app_gate.dart';

void main() {
  runApp(const ProviderScope(child: ZawiyahApp()));
}

class ZawiyahApp extends ConsumerWidget {
  const ZawiyahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx = ref.watch(currentCalendarContextProvider);
    final theme = ctx.isMourning ? ZawiyahTheme.mourning : ZawiyahTheme.normal;
    final locale = ref.watch(appLocaleProvider).value;

    return MaterialApp(
      title: 'Zawiyah',
      debugShowCheckedModeBanner: false,
      theme: theme,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('ar'),
      ],
      home: const AppGate(),
    );
  }
}
