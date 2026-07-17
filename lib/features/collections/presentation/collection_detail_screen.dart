// ============================================================
// Zawiyah — Collection Detail Screen
// lib/features/collections/presentation/collection_detail_screen.dart
//
// Shows a personal collection's items, rendered using the SAME
// AmalBlockView/counter widgets as Morning A'mal -- since collections
// only store content IDs (not duplicated content), per the Offline
// Content Architecture decision. A picker lets the user add any
// existing textItem from the source content by ID.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../morning_aamal/data/morning_aamal_content.dart';
import '../../morning_aamal/domain/amal_models.dart';
import '../../morning_aamal/presentation/widgets/amal_section_card.dart';

final _collectionItemsProvider =
    FutureProvider.family<List<String>, String>((ref, collectionId) async {
  return LocalStorageService().getCollectionContentIds(collectionId);
});

class CollectionDetailScreen extends ConsumerWidget {
  final String collectionId;
  final String title;

  const CollectionDetailScreen({
    super.key,
    required this.collectionId,
    required this.title,
  });

  Future<void> _openAddItemPicker(BuildContext context, WidgetRef ref) async {
    final allItems = flattenTextItemsById(morningAamalSections);
    final existingIds =
        await LocalStorageService().getCollectionContentIds(collectionId);

    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      backgroundColor: ZawiyahColors.card,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (ctx, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Add from Morning A\'māl', style: ZawiyahTypography.label),
            const SizedBox(height: 12),
            ...allItems.entries.map((entry) {
              final id = entry.key;
              final block = entry.value;
              final alreadyAdded = existingIds.contains(id);
              return ListTile(
                title: Text(
                  block.label ?? block.transliteration ?? id,
                  style: ZawiyahTypography.body,
                ),
                trailing: alreadyAdded
                    ? const Icon(Icons.check, color: ZawiyahColors.green)
                    : const Icon(Icons.add_circle_outline,
                        color: ZawiyahColors.gold),
                onTap: alreadyAdded
                    ? null
                    : () async {
                        await LocalStorageService().addContentToCollection(
                          collectionId: collectionId,
                          contentId: id,
                        );
                        ref.invalidate(_collectionItemsProvider(collectionId));
                        if (ctx.mounted) Navigator.pop(ctx);
                      },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(_collectionItemsProvider(collectionId));
    final allItems = flattenTextItemsById(morningAamalSections);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddItemPicker(context, ref),
        backgroundColor: ZawiyahColors.gold,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contentIds) {
          if (contentIds.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Empty so far — tap + to add items from Morning A\'māl.',
                  style: ZawiyahTypography.subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: contentIds
                .where((id) => allItems.containsKey(id))
                .map((id) => Dismissible(
                      key: ValueKey(id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: ZawiyahColors.red.withValues(alpha: 0.3),
                        child: const Icon(Icons.delete_outline,
                            color: Colors.white),
                      ),
                      onDismissed: (_) async {
                        await LocalStorageService().removeContentFromCollection(
                          collectionId: collectionId,
                          contentId: id,
                        );
                        ref.invalidate(_collectionItemsProvider(collectionId));
                      },
                      child: AmalBlockView(block: allItems[id]!),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
