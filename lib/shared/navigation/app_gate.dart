// ============================================================
// Zawiyah — App Gate
// lib/shared/navigation/app_gate.dart
//
// Adopted from ChatGPT's pattern. One change: uses LocalStorageService
// (SQLite, same store as the rest of the app) instead of
// flutter_secure_storage -- an onboarding-complete flag and a role
// preference aren't sensitive enough to warrant a second persistence
// system running alongside the one everything else already uses.
// ============================================================

import 'package:flutter/material.dart';

import '../../core/storage/local_storage_service.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import 'root_shell.dart';

class AppGate extends StatefulWidget {
  const AppGate({super.key});
  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  late Future<bool> _ready;

  @override
  void initState() {
    super.initState();
    _ready = _isOnboarded();
  }

  Future<bool> _isOnboarded() async =>
      (await LocalStorageService().getString('onboarding_complete')) == '1';

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: _ready,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.data!) return const RootShell();
          return OnboardingScreen(
            onComplete: () {
              setState(() {
                _ready = Future.value(true);
              });
            },
          );
        },
      );
}
