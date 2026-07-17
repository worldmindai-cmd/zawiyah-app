// ============================================================
// Zawiyah — App Gate
// lib/shared/navigation/app_gate.dart
//
// Adopted from ChatGPT's pattern. One change: uses LocalStorageService
// (SQLite, same store as the rest of the app) instead of
// flutter_secure_storage -- an onboarding-complete flag and a role
// preference aren't sensitive enough to warrant a second persistence
// system running alongside the one everything else already uses.
//
// MIGRATION: earlier builds stored these in flutter_secure_storage
// under 'zawiyah_onboarded'/'zawiyah_role'. On first launch of this
// build, fall back to those keys so existing testers don't get
// dropped back into onboarding and lose their role choice -- then
// migrate the values into LocalStorageService and clear the old keys.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/storage/local_storage_service.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import 'root_shell.dart';

class AppGate extends StatefulWidget {
  const AppGate({super.key});
  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  static const _legacyStorage = FlutterSecureStorage();
  late Future<bool> _ready;

  @override
  void initState() {
    super.initState();
    _ready = _isOnboarded();
  }

  Future<bool> _isOnboarded() async {
    if ((await LocalStorageService().getString('onboarding_complete')) == '1') {
      return true;
    }
    return _migrateFromLegacyStorage();
  }

  Future<bool> _migrateFromLegacyStorage() async {
    final legacyOnboarded = await _legacyStorage.read(key: 'zawiyah_onboarded');
    if (legacyOnboarded != 'true') return false;

    final legacyRole = await _legacyStorage.read(key: 'zawiyah_role');
    final storage = LocalStorageService();
    await storage.setString('user_role', legacyRole ?? 'adult');
    await storage.setString('onboarding_complete', '1');
    await _legacyStorage.delete(key: 'zawiyah_onboarded');
    await _legacyStorage.delete(key: 'zawiyah_role');
    return true;
  }

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
