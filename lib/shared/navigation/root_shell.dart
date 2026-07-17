// ============================================================
// Zawiyah — Root Navigation Shell
// lib/shared/navigation/root_shell.dart
//
// Restructured per Zawiyah Master Spec v1.1 section 5: Home / A'mal /
// Learn / Library / More. Tasbeeh is no longer its own tab -- it's
// reached via Home's quick access instead, per spec ("Quick access to
// counters/tasbeeh" is listed under Home, not as a separate tab).
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/morning_aamal/presentation/morning_aamal_screen.dart';
import '../../features/kahani/presentation/kahani_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/more/presentation/more_screen.dart';

final rootShellTabIndexProvider = StateProvider<int>((ref) => 0);

class RootShell extends ConsumerWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = ref.watch(rootShellTabIndexProvider);

    const screens = [
      HomeScreen(),
      MorningAamalScreen(),
      KahaniScreen(),
      LibraryScreen(),
      MoreScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: screens[currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) =>
            ref.read(rootShellTabIndexProvider.notifier).state = i,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.wb_twilight_outlined),
            label: l10n.navMorningAamal,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_stories_outlined),
            label: l10n.navKahani,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_library_outlined),
            label: l10n.navLibrary,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}
