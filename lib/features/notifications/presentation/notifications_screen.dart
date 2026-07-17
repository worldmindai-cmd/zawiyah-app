// ============================================================
// Zawiyah — Notifications Settings
// lib/features/notifications/presentation/notifications_screen.dart
//
// Master Spec 4.11: categories off by default, respectful wording,
// each independently toggleable. This screen provides the SETTINGS
// SURFACE only -- actual scheduling logic (local notification
// triggers) is a separate follow-up, not yet built, so these toggles
// currently just persist a preference without yet firing anything.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/storage/local_storage_service.dart';

class _NotificationCategory {
  final String key;
  final String label;
  final String description;
  const _NotificationCategory(this.key, this.label, this.description);
}

const _categories = [
  _NotificationCategory('notif_morning_aamal', 'Morning A\'māl',
      'A gentle daily reminder for your morning routine.'),
  _NotificationCategory('notif_events', 'Event reminders',
      'Notable dates and commemorations.'),
  _NotificationCategory('notif_downloads', 'Download reminders',
      'When new content is available to download.'),
  _NotificationCategory('notif_children', 'Children\'s learning',
      'Reminders for Young Zawiyah activities.'),
  _NotificationCategory('notif_custom', 'My reminders',
      'Reminders you create yourself.'),
];

final notificationTogglesProvider =
    FutureProvider<Map<String, bool>>((ref) async {
  final storage = LocalStorageService();
  final result = <String, bool>{};
  for (final c in _categories) {
    result[c.key] = (await storage.getString(c.key)) == '1';
  }
  return result;
});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final togglesAsync = ref.watch(notificationTogglesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: togglesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (toggles) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Off by default. Turn on only what\'s useful to you — nothing sends without your permission.',
              style: ZawiyahTypography.subtitle,
            ),
            const SizedBox(height: 16),
            ..._categories.map((c) {
              final value = toggles[c.key] ?? false;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: ZawiyahColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ZawiyahColors.divider),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.label,
                              style: const TextStyle(
                                  color: ZawiyahColors.text,
                                  fontWeight: FontWeight.w600)),
                          Text(c.description, style: ZawiyahTypography.subtitle),
                        ],
                      ),
                    ),
                    Switch(
                      value: value,
                      activeThumbColor: ZawiyahColors.gold,
                      onChanged: (v) async {
                        await LocalStorageService()
                            .setString(c.key, v ? '1' : '0');
                        ref.invalidate(notificationTogglesProvider);
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
