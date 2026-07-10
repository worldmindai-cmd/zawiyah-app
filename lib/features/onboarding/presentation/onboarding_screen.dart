import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _storage = FlutterSecureStorage();
  String? _role;
  int _page = 0;

  static const _roles = [
    ('beginner', 'Beginning my journey', 'A gentle teacher, one step at a time.'),
    ('child', 'Child / Young Zawiyah', 'Age-appropriate learning with a parent or guardian.'),
    ('parent', 'Parent / Family', 'Shared worship, stories and family learning.'),
    ('teen', 'Teenager', 'Questions, learning and habits for life.'),
    ('adult', 'Daily worshipper', 'A practical spiritual companion.'),
    ('student', 'Student of knowledge', 'Structured learning and transparent sources.'),
    ('scholar', 'Scholar / researcher', 'An organised reference companion.'),
  ];

  Future<void> _finish() async {
    await _storage.write(key: 'zawiyah_role', value: _role ?? 'adult');
    await _storage.write(key: 'zawiyah_onboarded', value: 'true');
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: _page == 0 ? _duaPage() : _rolePage(),
        ),
      ),
    );
  }

  Widget _duaPage() => Column(
    children: [
      const Spacer(),
      const Directionality(
        textDirection: TextDirection.rtl,
        child: Text('بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيمِ', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, color: ZawiyahColors.gold)),
      ),
      const SizedBox(height: 22),
      Text(
        'O Allah, if there is any good in this work, accept it from us and allow it to benefit Your servants. Forgive our shortcomings, correct our mistakes, and do not let our egos become part of what was intended solely for Your sake. Make this a means of guidance, remembrance, comfort, and closeness to You through the Holy Qur\'an and the teachings of the Ahlul Bayt (AS). Āmīn.',
        textAlign: TextAlign.center,
        style: ZawiyahTypography.translation.copyWith(fontSize: 17, height: 1.65),
      ),
      const SizedBox(height: 24),
      Text(
        'Zawiyah is dedicated to all those who devoted their lives to Allah (SWT), His Messenger (SAW), and the Ahlul Bayt (AS). If you are able, please recite Surah al-Fātiḥah for them.',
        textAlign: TextAlign.center,
        style: ZawiyahTypography.subtitle,
      ),
      const Spacer(),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: () => setState(() => _page = 1), child: const Text('Continue'))),
    ],
  );

  Widget _rolePage() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('How should Zawiyah support you?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ZawiyahColors.gold)),
      const SizedBox(height: 8),
      Text('Your role helps us explain why the organisation is useful to you. You can change it later.', style: ZawiyahTypography.translation),
      const SizedBox(height: 18),
      Expanded(
        child: ListView(
          children: _roles.map((r) => RadioListTile<String>(
            value: r.$1,
            groupValue: _role,
            onChanged: (v) => setState(() => _role = v),
            title: Text(r.$2),
            subtitle: Text(r.$3),
          )).toList(),
        ),
      ),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: _role == null ? null : _finish, child: const Text('Enter Zawiyah'))),
    ],
  );
}
