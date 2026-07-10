import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import 'root_shell.dart';

class AppGate extends StatefulWidget {
  const AppGate({super.key});
  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {
  static const _storage = FlutterSecureStorage();
  late Future<bool> _ready;

  @override
  void initState() {
    super.initState();
    _ready = _isOnboarded();
  }

  Future<bool> _isOnboarded() async => (await _storage.read(key: 'zawiyah_onboarded')) == 'true';

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: _ready,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
      if (snapshot.data!) return const RootShell();
      return OnboardingScreen(onComplete: () => setState(() => _ready = Future.value(true)));
    },
  );
}
