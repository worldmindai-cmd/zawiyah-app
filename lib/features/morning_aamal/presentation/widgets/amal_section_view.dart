// ============================================================
// Zawiyah — A'mal Section Card
// lib/features/morning_aamal/presentation/widgets/amal_section_view.dart
//
// Renders one AmalSection as an expandable card, matching the
// prototype's <details>/<summary> behaviour (open/closed sections).
//
// DELIBERATELY custom-built rather than using Flutter's ExpansionTile
// + ExpansionTileController. That combination proved unreliable when
// commanding many tiles to collapse at once (Close All behaved
// erratically -- some sections stayed open, others reopened after
// appearing closed). Rather than keep patching around ExpansionTile's
// internal animation/attachment state, this widget reads its
// expanded/collapsed boolean directly from sectionExpansionProvider
// and renders accordingly -- fully deterministic, no hidden state
// this widget doesn't already know about.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/zawiyah_colors.dart';
import '../../../../shared/providers/section_expansion_state.dart';
import '../../domain/amal_models.dart';
import 'amal_section_card.dart'; // AmalBlockView

class AmalSectionView extends ConsumerWidget {
  final AmalSection section;

  const AmalSectionView({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded =
        ref.watch(sectionExpansionProvider)[section.id] ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: ZawiyahColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ZawiyahColors.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => ref
                .read(sectionExpansionProvider.notifier)
                .toggle(section.id),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        color: ZawiyahColors.gold,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: ZawiyahColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AnimatedSize gives a smooth expand/collapse transition
          // without any of ExpansionTile's internal state machinery --
          // this widget's build method is the single source of truth
          // for whether children render at all.
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: section.blocks
                          .map((block) => AmalBlockView(block: block))
                          .toList(),
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}
