// ============================================================
// Zawiyah — A'mal Block Renderer
// lib/features/morning_aamal/presentation/widgets/amal_block_view.dart
//
// Renders any AmalBlock generically -- this is the reusable module
// concept in practice: the same widget renders Morning A'mal, and
// will render Friday/Muharram A'mal later, since they're all built
// from the same AmalBlock data rather than bespoke per-screen widgets.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/zawiyah_colors.dart';
import '../../../../core/design_system/zawiyah_typography.dart';
import '../../../../core/storage/local_storage_service.dart';
import '../../../../shared/providers/counter_reset_signal.dart';
import '../../domain/amal_models.dart';
import '../../../../shared/widgets/devotional_counter.dart';

/// Loads/saves a single counter's progress via LocalStorageService.
/// Keyed by contentId so each du'a/dhikr counter persists independently.
final counterProgressProvider =
    FutureProvider.family<int, String>((ref, contentId) async {
  return LocalStorageService().getCounterProgress(contentId);
});

class AmalBlockView extends ConsumerWidget {
  final AmalBlock block;

  const AmalBlockView({super.key, required this.block});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (block.kind) {
      case AmalBlockKind.action:
        return _ActionBox(text: block.text!);

      case AmalBlockKind.note:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(block.text!, style: ZawiyahTypography.translation),
        );

      case AmalBlockKind.list:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: block.listItems!
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('•  ', style: ZawiyahTypography.translation),
                          Expanded(
                            child: Text(item,
                                style: ZawiyahTypography.translation),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        );

      case AmalBlockKind.textItem:
        return _TextItemView(block: block);

      case AmalBlockKind.group:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ZawiyahColors.card2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ZawiyahColors.divider2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(block.label!, style: ZawiyahTypography.label),
              const SizedBox(height: 8),
              ...block.children!.map((child) => AmalBlockView(block: child)),
            ],
          ),
        );
    }
  }
}

class _ActionBox extends StatelessWidget {
  final String text;
  const _ActionBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF17130C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3D3320)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Action',
            style: TextStyle(
              color: ZawiyahColors.gold,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(text, style: ZawiyahTypography.translation),
        ],
      ),
    );
  }
}

class _TextItemView extends ConsumerWidget {
  final AmalBlock block;
  const _TextItemView({required this.block});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Items with no maxCount are just displayed (du'a text, no counter).
    if (block.maxCount == null) {
      return _StaticTextBlock(block: block);
    }

    // Items with a contentId get live persistence via the counter
    // progress provider; fall back to 0 while loading.
    final progressAsync = ref.watch(counterProgressProvider(block.contentId!));

    return progressAsync.when(
      data: (savedCount) => _CounterBlock(block: block, initialCount: savedCount),
      loading: () => _CounterBlock(block: block, initialCount: 0),
      error: (_, __) => _CounterBlock(block: block, initialCount: 0),
    );
  }
}

class _StaticTextBlock extends StatelessWidget {
  final AmalBlock block;
  const _StaticTextBlock({required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZawiyahColors.card2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZawiyahColors.divider2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.label != null) ...[
            Text(
              block.label!,
              style: ZawiyahTypography.label.copyWith(
                color: block.isRed ? const Color(0xFFFFB1B1) : null,
              ),
            ),
            const SizedBox(height: 6),
          ],
          if (block.arabic != null && block.arabic!.isNotEmpty) ...[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                block.arabic!,
                style: ZawiyahTypography.arabic,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (block.transliteration != null &&
              block.transliteration!.isNotEmpty) ...[
            Text(block.transliteration!,
                style: ZawiyahTypography.transliteration),
            const SizedBox(height: 8),
          ],
          if (block.translation != null)
            Text(block.translation!, style: ZawiyahTypography.translation),
        ],
      ),
    );
  }
}

/// Stateful wrapper around DevotionalCounter -- holds the live count
/// locally for instant UI feedback, persisting to LocalStorageService
/// on every tap/reset, and listening to counterResetSignalProvider so
/// the "Reset counters" toolbar button can reset every mounted
/// counter at once.
class _CounterBlock extends ConsumerStatefulWidget {
  final AmalBlock block;
  final int initialCount;
  const _CounterBlock({required this.block, required this.initialCount});

  @override
  ConsumerState<_CounterBlock> createState() => _CounterBlockState();
}

class _CounterBlockState extends ConsumerState<_CounterBlock> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  Future<void> _persist() async {
    await LocalStorageService().setCounterProgress(
      contentId: widget.block.contentId!,
      currentCount: _count,
      maxCount: widget.block.maxCount!,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen (not watch) -- we only want a side effect (resetting
    // local state) when the signal changes, not a rebuild triggered
    // by watching it directly.
    ref.listen<int>(counterResetSignalProvider, (previous, next) {
      if (previous != next && mounted) {
        setState(() => _count = 0);
      }
    });

    return DevotionalCounter(
      arabicText: widget.block.arabic ?? '',
      transliteration: widget.block.transliteration ?? '',
      translation: widget.block.label != null
          ? '${widget.block.translation ?? ''}${widget.block.translation != null ? ' — ' : ''}${widget.block.label}'
          : widget.block.translation,
      currentCount: _count,
      maxCount: widget.block.maxCount!,
      onIncrement: () {
        setState(() => _count++);
        _persist();
      },
      onReset: () {
        setState(() => _count = 0);
        _persist();
      },
    );
  }
}
