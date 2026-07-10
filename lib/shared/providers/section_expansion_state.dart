// ============================================================
// Zawiyah — Section Expansion State
// lib/shared/providers/section_expansion_state.dart
//
// Explicit, fully-owned expand/collapse state per section, keyed by
// section id. This REPLACES reliance on ExpansionTileController,
// which turned out to have unreliable/erratic behaviour when many
// tiles were commanded to collapse in a single pass (its internal
// animation/attachment state didn't stay reliably in sync with rapid
// external commands). Owning the boolean state ourselves in a plain
// provider is fully deterministic: "Close All" simply sets every
// value to false, "Open All" sets every value to true, and each
// section's widget just reads its own boolean -- no controller
// object, no animation-state ambiguity, no room for drift between
// what we told it to do and what it actually did.
// ============================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/morning_aamal/data/morning_aamal_content.dart';

class SectionExpansionNotifier extends StateNotifier<Map<String, bool>> {
  SectionExpansionNotifier()
      : super({
          for (final s in morningAamalSections) s.id: s.initiallyOpen,
        });

  void setExpanded(String sectionId, bool expanded) {
    state = {...state, sectionId: expanded};
  }

  void toggle(String sectionId) {
    setExpanded(sectionId, !(state[sectionId] ?? false));
  }

  void setAll(bool expanded) {
    state = {for (final id in state.keys) id: expanded};
  }
}

final sectionExpansionProvider =
    StateNotifierProvider<SectionExpansionNotifier, Map<String, bool>>(
  (ref) => SectionExpansionNotifier(),
);
