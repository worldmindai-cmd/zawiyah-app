// ============================================================
// Zawiyah — App Entry Point
// lib/main.dart
//
// Wires together the theme engine, localization (en/ur/ar, with
// ur/ar RTL handled automatically via Flutter's Directionality once
// the locale is set), and the root navigation shell.
//
// RTL is NOT special-cased here -- MaterialApp's localizationsDelegates
// + supportedLocales already tells Flutter which locales are RTL
// (Arabic and Urdu both are), and every screen inherits correct
// Directionality automatically as long as widgets use directional
// properties (EdgeInsetsDirectional, AlignmentDirectional, etc.)
// rather than hardcoded left/right -- see zawiyah_theme.dart's header
// comment for the project-wide rule on this.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/design_system/zawiyah_theme.dart';
import 'l10n/app_localizations.dart';
import 'shared/navigation/root_shell.dart';

void main() {
  runApp(const ProviderScope(child: ZawiyahApp()));
}

class ZawiyahApp extends StatelessWidget {
  const ZawiyahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zawiyah',
      debugShowCheckedModeBanner: false,
      theme: ZawiyahTheme.normal,
      // TODO: switch to ZawiyahTheme.mourning automatically based on
      // the Calendar Engine's current Hijri date once that module is
      // built -- see the Theme Engine spec (auto Ayam-e-Aza/Shahadat
      // switching) and the prototype's `body.mourning` logic for the
      // reference date ranges to port over.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English -- LTR
        Locale('ur'), // Urdu -- RTL
        Locale('ar'), // Arabic -- RTL
        // Locale('fa'), // Persian -- RTL, planned later
        // Locale('fr'), // French -- LTR, planned later
      ],
      home: const RootShell(),
    );
  }
}
