// ============================================================
// Zawiyah — Morning A'mal Screen
// lib/features/morning_aamal/presentation/morning_aamal_screen.dart
//
// Renders Ali's complete Morning A'mal routine (see
// data/morning_aamal_content.dart), ported faithfully from the
// prototype into the real Flutter architecture.
//
// Open All/Close All now call sectionExpansionProvider.setAll(),
// which is fully deterministic (see section_expansion_state.dart for
// why this replaced ExpansionTileController). Reset counters bumps
// counterResetSignalProvider and persists the zeroed state.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/morning_aamal_content.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/providers/counter_reset_signal.dart';
import '../../../shared/providers/section_expansion_state.dart';
import 'widgets/amal_section_view.dart';

class MorningAamalScreen extends ConsumerWidget {
  const MorningAamalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMorningAamal)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
        children: [
          for (final section in morningAamalSections)
            AmalSectionView(
              key: ValueKey(section.id),
              section: section,
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xE6050505),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                ref.read(counterResetSignalProvider.notifier).state++;
                await LocalStorageService().resetAllCounters();
              },
              child: Text(l10n.resetCounters),
            ),
            TextButton(
              onPressed: () =>
                  ref.read(sectionExpansionProvider.notifier).setAll(true),
              child: Text(l10n.openAll),
            ),
            TextButton(
              onPressed: () =>
                  ref.read(sectionExpansionProvider.notifier).setAll(false),
              child: Text(l10n.closeAll),
            ),
          ],
        ),
      ),
    );
  }
}
