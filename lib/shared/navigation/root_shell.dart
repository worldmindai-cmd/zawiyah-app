// ============================================================
// Zawiyah — Root Navigation Shell
// lib/shared/navigation/root_shell.dart
//
// Four-tab bottom navigation, matching the prototype's structure:
// Morning A'māl, Tasbeeh, Kahani, More/Help. Each tab is currently a
// placeholder screen -- feature implementation comes after the
// engineering foundations are complete and reviewed, per the build
// kickoff instruction.
//
// RTL note: BottomNavigationBar / NavigationBar already mirror
// correctly for RTL locales out of the box in Flutter -- no special
// handling needed here specifically, but every CUSTOM widget built
// on top of this shell must still follow the directional-properties
// rule (see zawiyah_theme.dart).
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../features/morning_aamal/presentation/morning_aamal_screen.dart';
import '../../features/tasbeeh/presentation/tasbeeh_screen.dart';
import '../../features/kahani/presentation/kahani_screen.dart';
import '../../features/more/presentation/more_screen.dart';

final rootShellTabIndexProvider = StateProvider<int>((ref) => 0);

class RootShell extends ConsumerWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = ref.watch(rootShellTabIndexProvider);

    final screens = const [
      MorningAamalScreen(),
      TasbeehScreen(),
      KahaniScreen(),
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
            icon: const Icon(Icons.wb_twilight_outlined),
            label: l10n.navMorningAamal,
          ),
          NavigationDestination(
            icon: const Icon(Icons.filter_9_plus_outlined),
            label: l10n.navTasbeeh,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_stories_outlined),
            label: l10n.navKahani,
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
