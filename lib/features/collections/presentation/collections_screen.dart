// ============================================================
// Zawiyah — Collections Screen
// lib/features/collections/presentation/collections_screen.dart
//
// Per the Community Collections design decision: the existing
// Morning A'mal sequence IS the default/example collection ("Suggested
// Morning A'mal") -- shown here as a built-in, non-deletable entry
// that just opens the existing Morning A'mal screen. User-created
// collections are separate, stored via LocalStorageService.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../morning_aamal/presentation/morning_aamal_screen.dart';
import 'collection_detail_screen.dart';

final collectionsListProvider =
    FutureProvider<List<Map<String, Object?>>>((ref) async {
  return LocalStorageService().listCollectionRows();
});

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  Future<void> _createCollection(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ZawiyahColors.card,
        title: const Text('New collection',
            style: TextStyle(color: ZawiyahColors.gold)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: ZawiyahTypography.body,
          decoration: const InputDecoration(hintText: 'e.g. Ramadhan Fajr'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (title == null || title.isEmpty) return;
    final id = const Uuid().v4();
    await LocalStorageService().createCollection(id, title);
    ref.invalidate(collectionsListProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Collections')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createCollection(context, ref),
        backgroundColor: ZawiyahColors.gold,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: collectionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (rows) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Built-in default collection.
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const MorningAamalScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ZawiyahColors.card2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ZawiyahColors.gold.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: ZawiyahColors.gold, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Sample Morning A\'māl',
                        style: TextStyle(
                          color: ZawiyahColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text('Built-in', style: ZawiyahTypography.subtitle),
                  ],
                ),
              ),
            ),
            if (rows.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Tap + to create your own personal collection — e.g. Ramadhan Fajr, Friday Morning, or Travel du\'as.',
                  style: ZawiyahTypography.subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ...rows.map((row) {
              final id = row['id'] as String;
              final title = row['title'] as String;
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CollectionDetailScreen(collectionId: id, title: title),
                  ),
                ),
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
                      const Icon(Icons.bookmark_outline,
                          color: ZawiyahColors.muted, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(title,
                            style: const TextStyle(
                                color: ZawiyahColors.text,
                                fontWeight: FontWeight.w600)),
                      ),
                      const Icon(Icons.chevron_right,
                          color: ZawiyahColors.muted, size: 18),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
