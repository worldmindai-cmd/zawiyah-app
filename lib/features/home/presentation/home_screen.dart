import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/calendar/zawiyah_calendar.dart';
import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../shared/navigation/root_shell.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ZawiyahCalendar.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Zawiyah')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: ZawiyahColors.card2, borderRadius: BorderRadius.circular(16), border: Border.all(color: ZawiyahColors.divider2)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ZawiyahCalendar.gregorianLabel(c.deviceDateTime), style: ZawiyahTypography.label),
              const SizedBox(height: 6),
              Text(c.hijri.formatted, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: ZawiyahColors.gold)),
              const SizedBox(height: 10),
              Text(c.eventText, style: ZawiyahTypography.translation),
              if (c.isMourning) ...[
                const SizedBox(height: 10),
                const Text('Mourning theme active', style: TextStyle(color: ZawiyahColors.red, fontWeight: FontWeight.w700)),
              ],
            ]),
          ),
          const SizedBox(height: 14),
          _card(
            title: 'Suggested Morning A‘māl',
            body: 'A personal routine shared by a member of the Zawiyah development team in the hope that others may benefit. It is an example collection, not a prescribed or comprehensive routine.',
            action: 'Begin',
            onTap: () => ref.read(rootShellTabIndexProvider.notifier).state = 1,
          ),
          _card(
            title: 'Digital Tasbeeh',
            body: 'Use haptic counters with a full-screen tap mode when you do not want to look at the phone.',
            action: 'Open',
            onTap: () => ref.read(rootShellTabIndexProvider.notifier).state = 2,
          ),
          _card(
            title: 'Devotional Kahani',
            body: 'Read or listen using the phone voice. Content provenance remains visible.',
            action: 'Open',
            onTap: () => ref.read(rootShellTabIndexProvider.notifier).state = 3,
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required String body, required String action, required VoidCallback onTap}) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: ZawiyahColors.gold, fontWeight: FontWeight.w800, fontSize: 17)),
        const SizedBox(height: 8),
        Text(body, style: ZawiyahTypography.translation),
        const SizedBox(height: 12),
        Align(alignment: AlignmentDirectional.centerEnd, child: FilledButton(onPressed: onTap, child: Text(action))),
      ]),
    ),
  );
}
