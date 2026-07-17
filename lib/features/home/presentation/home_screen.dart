// ============================================================
// Zawiyah — Home Screen
// lib/features/home/presentation/home_screen.dart
//
// Shows Gregorian + Hijri date (calculated/estimated, with manual
// +/-1 day adjustment) plus the actual regional event for the day
// (Ashura, Arbaeen, Bibi Sakina's anniversary, etc. -- via
// ZawiyahCalendar, adopted from ChatGPT's build after review), plus
// quick access to every main feature.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/calendar/calendar_provider.dart';
import '../../../core/calendar/zawiyah_calendar.dart';
import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../morning_aamal/presentation/morning_aamal_screen.dart';
import '../../tasbeeh/presentation/tasbeeh_screen.dart';
import '../../kahani/presentation/kahani_screen.dart';
import '../../library/presentation/library_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _adjustHijriOffset(WidgetRef ref, int delta) async {
    final current = await LocalStorageService().getHijriDayOffset();
    await LocalStorageService().setHijriDayOffset(current + delta);
    ref.invalidate(hijriDayOffsetProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx = ref.watch(currentCalendarContextProvider);
    final gregorianLabel = ZawiyahCalendar.gregorianLabel(ctx.deviceDateTime);

    return Scaffold(
      appBar: AppBar(title: const Text('Zawiyah')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ZawiyahColors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ZawiyahColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(gregorianLabel, style: ZawiyahTypography.body),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ctx.hijri.formatted,
                        style: ZawiyahTypography.heading.copyWith(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          size: 20, color: ZawiyahColors.muted),
                      onPressed: () => _adjustHijriOffset(ref, -1),
                      tooltip: 'Adjust one day earlier',
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          size: 20, color: ZawiyahColors.muted),
                      onPressed: () => _adjustHijriOffset(ref, 1),
                      tooltip: 'Adjust one day later',
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Calculated date — may differ from local moon-sighting or your community\'s observance. Adjust above if needed.',
                  style: ZawiyahTypography.subtitle,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: ctx.isMourning
                        ? ZawiyahColors.mourningLabel.withValues(alpha: 0.12)
                        : ZawiyahColors.card2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ctx.eventText,
                    style: ZawiyahTypography.subtitle.copyWith(
                      color: ctx.isMourning
                          ? ZawiyahColors.mourningLabel
                          : ZawiyahColors.muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Quick access', style: ZawiyahTypography.label),
          const SizedBox(height: 10),
          _QuickAccessCard(
            icon: Icons.wb_twilight_outlined,
            title: 'Morning A\'māl',
            subtitle: 'Continue today\'s routine',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MorningAamalScreen())),
          ),
          _QuickAccessCard(
            icon: Icons.filter_9_plus_outlined,
            title: 'Tasbeeh',
            subtitle: 'Quick dhikr counter',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const TasbeehScreen())),
          ),
          _QuickAccessCard(
            icon: Icons.auto_stories_outlined,
            title: 'Kahani',
            subtitle: 'Stories with meaning',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const KahaniScreen())),
          ),
          _QuickAccessCard(
            icon: Icons.local_library_outlined,
            title: 'Library',
            subtitle: 'Qur\'an, du\'as, Ask the Sources, and more',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LibraryScreen())),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ZawiyahColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ZawiyahColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: ZawiyahColors.card2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: ZawiyahColors.gold, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: ZawiyahColors.text,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle, style: ZawiyahTypography.subtitle),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: ZawiyahColors.muted, size: 18),
          ],
        ),
      ),
    );
  }
}
