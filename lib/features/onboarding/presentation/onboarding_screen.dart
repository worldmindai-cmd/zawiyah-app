// ============================================================
// Zawiyah — Onboarding Screen
// lib/features/onboarding/presentation/onboarding_screen.dart
//
// Merged from ChatGPT's dedication+role pages (kept largely as-built
// -- their 7 roles match the Constitution exactly) with Claude's
// language/privacy/notification pages added after role selection, to
// cover all 6 steps the Master Spec requires. Storage moved from
// flutter_secure_storage to LocalStorageService (SQLite) -- role and
// an onboarding-complete flag aren't sensitive enough to need a
// separate secure-storage system running alongside the one the rest
// of the app already uses.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/locale/locale_provider.dart';
import '../../../core/storage/local_storage_service.dart';
import '../domain/user_role.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({super.key, required this.onComplete});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _page = 0;
  UserRole? _role;
  String _language = 'en';

  static const _languages = {
    'en': 'English',
    'ur': 'اردو (Urdu)',
    'ar': 'العربية (Arabic)',
  };

  Future<void> _finish() async {
    final storage = LocalStorageService();
    await storage.setString('user_role', (_role ?? UserRole.adult).storageKey);
    await storage.setString('app_language', _language);
    await storage.setString('onboarding_complete', '1');
    ref.invalidate(appLocaleProvider);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _duaPage(),
      _rolePage(),
      _languagePage(),
      _privacyPage(),
      _notificationPrefsPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: pages[_page],
        ),
      ),
    );
  }

  Widget _duaPage() => Column(
        children: [
          const Spacer(),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, color: ZawiyahColors.gold),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'O Allah, if there is any good in this work, accept it from us and allow it to benefit Your servants. Forgive our shortcomings, correct our mistakes, and do not let our egos become part of what was intended solely for Your sake. Make this a means of guidance, remembrance, comfort, and closeness to You through the Holy Qur\'an and the teachings of the Ahlul Bayt (AS). Āmīn.',
            textAlign: TextAlign.center,
            style: ZawiyahTypography.translation.copyWith(fontSize: 17, height: 1.65),
          ),
          const SizedBox(height: 24),
          const Text(
            'Zawiyah is dedicated to all those who devoted their lives to Allah (SWT), His Messenger (SAW), and the Ahlul Bayt (AS). If you are able, please recite Surah al-Fātiḥah for them.',
            textAlign: TextAlign.center,
            style: ZawiyahTypography.subtitle,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => setState(() => _page = 1),
              child: const Text('Continue'),
            ),
          ),
        ],
      );

  Widget _rolePage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How should Zawiyah support you?',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ZawiyahColors.gold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your role helps us explain why the organisation is useful to you. You can change it later.',
            style: ZawiyahTypography.translation,
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView(
              children: UserRole.values
                  .map((r) => RadioListTile<UserRole>(
                        value: r,
                        // ignore: deprecated_member_use
                        groupValue: _role,
                        // ignore: deprecated_member_use
                        onChanged: (v) => setState(() => _role = v),
                        title: Text(r.label),
                        subtitle: Text(r.subtitle),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _role == null ? null : () => setState(() => _page = 2),
              child: const Text('Continue'),
            ),
          ),
        ],
      );

  Widget _languagePage() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose your language',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ZawiyahColors.gold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ..._languages.entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _language = e.key),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _language == e.key
                          ? ZawiyahColors.gold.withValues(alpha: 0.12)
                          : ZawiyahColors.card2,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _language == e.key
                            ? ZawiyahColors.gold
                            : ZawiyahColors.divider2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _language == e.key
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: _language == e.key
                              ? ZawiyahColors.gold
                              : ZawiyahColors.muted,
                        ),
                        const SizedBox(width: 12),
                        Text(e.value, style: ZawiyahTypography.body),
                      ],
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => setState(() => _page = 3),
            child: const Text('Continue'),
          ),
        ],
      );

  Widget _privacyPage() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.lock_outline, size: 48, color: ZawiyahColors.gold),
          const SizedBox(height: 20),
          const Text(
            'Your privacy',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ZawiyahColors.gold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Your preferences, progress and counters are stored on your device. Zawiyah does not use your devotional activity for advertising, and does not sell or share your data.\n\nContent downloads only when you choose to use it.',
            style: ZawiyahTypography.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => setState(() => _page = 4),
            child: const Text('Continue'),
          ),
        ],
      );

  Widget _notificationPrefsPage() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.notifications_none, size: 48, color: ZawiyahColors.gold),
          const SizedBox(height: 20),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ZawiyahColors.gold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Notifications are off by default. You can turn on gentle reminders for Morning A\'māl, events, or downloads anytime from More → Notifications.',
            style: ZawiyahTypography.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _finish,
            child: const Text('Enter Zawiyah'),
          ),
        ],
      );
}
