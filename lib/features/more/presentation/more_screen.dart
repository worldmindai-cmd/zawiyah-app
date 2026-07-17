// ============================================================
// Zawiyah — More / Help Screen
// lib/features/more/presentation/more_screen.dart
//
// Ported exactly from the prototype: the Amanah/Niyyah introduction,
// the 8 core principles, the success-measurement framing, and the
// closing prayer. Text copied verbatim, not paraphrased.
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../notifications/presentation/notifications_screen.dart';

class _Principle {
  final String title;
  final String body;
  const _Principle(this.title, this.body);
}

const _principles = [
  _Principle(
    'Allah is always the destination',
    'Everything points towards worship of Allah.',
  ),
  _Principle(
    'The Holy Qur\'an is our foundation',
    'The Qur\'an is the primary source of guidance.',
  ),
  _Principle(
    'The Ahlul Bayt (AS) illuminate the path',
    'Their teachings guide our understanding, worship and character.',
  ),
  _Principle(
    'Authenticity before convenience',
    'Whenever possible, every narration, du\'a and ruling should be linked back to its source. Where recognised scholarly differences exist, those differences should be made clear.',
  ),
  _Principle(
    'Provenance before confidence',
    'The app should show where material comes from and what the AI has done with it. It should not appear to score revelation, hadith, or scholarly opinions.',
  ),
  _Principle(
    'AI is an assistant — not an authority',
    'AI may explain, organise, translate and simplify navigation. It must never invent religion, issue religious verdicts or replace recognised scholarship.',
  ),
  _Principle(
    'Respect for all',
    'This app is rooted in the teachings of the Ahlul Bayt (AS). It exists to strengthen those who wish to follow that path. It is not intended to mock, belittle or provoke people of other beliefs or traditions.',
  ),
  _Principle(
    'Excellence / Ihsān',
    'Beauty, simplicity and clarity are acts of worship. Every screen, word and feature should reflect sincerity and care.',
  ),
];

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen())),
            child: Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: ZawiyahColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ZawiyahColors.divider),
              ),
              child: const Row(
                children: [
                  Icon(Icons.notifications_none, color: ZawiyahColors.gold),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text('Notifications',
                        style: TextStyle(
                            color: ZawiyahColors.text, fontWeight: FontWeight.w600)),
                  ),
                  Icon(Icons.chevron_right, color: ZawiyahColors.muted, size: 18),
                ],
              ),
            ),
          ),
          _sectionCard(
            title: '❤️ Our Intention / Niyyah',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This app is an amānah — a trust — not merely a piece of software. It was created to help people draw closer to Allah (SWT) through the authentic teachings of the Holy Qur\'an and the Ahlul Bayt (AS).',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: Color(0xFFF8ECD0),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'It is not intended to replace scholars, marājiʿ, teachers or traditional learning. It is intended to encourage worship, reflection, learning and a deeper relationship with Allah.',
                  style: ZawiyahTypography.translation,
                ),
                SizedBox(height: 10),
                Text(
                  'If this app helps even one person pray more regularly, understand one verse of the Qur\'an more deeply, discover one teaching of the Ahlul Bayt (AS), or find comfort in a difficult moment, we pray that Allah accepts this humble effort.',
                  style: ZawiyahTypography.translation,
                ),
              ],
            ),
          ),
          _sectionCard(
            title: '📚 Our Principles',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Use these principles as the guardrails for the app and for any future AI features.',
                  style: ZawiyahTypography.translation,
                ),
                const SizedBox(height: 12),
                ..._principles.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ZawiyahColors.card2,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ZawiyahColors.divider2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.title, style: ZawiyahTypography.label),
                            const SizedBox(height: 6),
                            Text(p.body, style: ZawiyahTypography.translation),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          _sectionCard(
            title: '🌱 How We Measure Success',
            child: const Text(
              'Success is not measured by downloads, popularity or revenue. Success is measured by whether this app helps people remember Allah more often, understand the Qur\'an more deeply, appreciate the teachings of the Ahlul Bayt (AS), develop consistency in worship, and become better human beings.',
              style: ZawiyahTypography.translation,
            ),
          ),
          _sectionCard(
            title: '🤲 A Final Prayer',
            child: const Text(
              'O Allah, accept this effort if it contains goodness. Forgive its shortcomings, guide those who use it, and make it a means of drawing hearts closer to You through the Holy Qur\'an and the teachings of Muhammad (SAW) and his purified Ahlul Bayt (AS). Āmīn.',
              style: ZawiyahTypography.translation,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ZawiyahColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ZawiyahColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ZawiyahColors.gold,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
