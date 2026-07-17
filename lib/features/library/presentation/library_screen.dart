// ============================================================
// Zawiyah — Library Screen
// lib/features/library/presentation/library_screen.dart
//
// Hub listing every section from the Technical Build Specification
// that doesn't have real content/logic yet -- Qur'an, Nahjul Balagha,
// Sahifa Sajjadiya, Mafatih al-Jinan, Ask the Sources, Guided Khums,
// Young Zawiyah, Ziyarat/Du'as, and Collections. Real navigation
// structure now; each opens a clearly-labeled placeholder until built.
//
// IMPORTANT: canonical texts (Qur'an, Nahjul Balagha, Sahifa
// Sajjadiya, Mafatih al-Jinan) must come from a verified source/API
// when built -- never AI-generated from memory, per the Constitution.
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/coming_soon_screen.dart';
import '../../collections/presentation/collections_screen.dart';
import '../../biographies/presentation/biographies_screen.dart';

class _LibrarySection {
  final String title;
  final IconData icon;
  final String description;
  const _LibrarySection(this.title, this.icon, this.description);
}

const _sections = [
  _LibrarySection(
    'Qur\'an',
    Icons.menu_book_outlined,
    'Reading, search, and AI-assisted explanation and cross-references. Requires a verified Qur\'an text source before any content is added.',
  ),
  _LibrarySection(
    'Nahjul Balagha',
    Icons.format_quote_outlined,
    'The sermons, letters and sayings of Imam Ali (AS), with AI-assisted study tools.',
  ),
  _LibrarySection(
    'Sahifa Sajjadiya',
    Icons.auto_stories_outlined,
    'The du\'as of Imam Zainul Abideen (AS), with AI-assisted study tools.',
  ),
  _LibrarySection(
    'Mafatih al-Jinan',
    Icons.local_florist_outlined,
    'The core du\'a and ziyarat collection, integrated for daily and occasion-based use.',
  ),
  _LibrarySection(
    'Ziyarat & Du\'as',
    Icons.mosque_outlined,
    'The broader authenticated source library beyond the core Mafatih collection.',
  ),
  _LibrarySection(
    'Ask the Sources',
    Icons.search_outlined,
    'Ask a question; the app searches authenticated content (Qur\'an, Hadith, Mafatih, Nahjul Balagha, Sahifa, recognised scholars) and returns a clearly labelled, sourced summary — never an invented answer.',
  ),
  _LibrarySection(
    'Guided Khums',
    Icons.calculate_outlined,
    'A guided assistant — not a bare calculator — walking through income, savings, assets, debts, expenses, investments and exemptions to estimate your Khums position.',
  ),
  _LibrarySection(
    'Young Zawiyah',
    Icons.family_restroom_outlined,
    'Age-adaptive family learning about the Prophet (SAW) and the Ahlul Bayt (AS) — stories, timelines, maps and discussion prompts. No depiction of the Ma\'sumeen (AS), by design.',
  ),
  _LibrarySection(
    'Biographies',
    Icons.people_outline,
    'The Holy Prophet (SAWW) and the Twelve Imams (AS) — Who, What, When, Where, Why, How. Placeholder content pending sourcing and review.',
  ),
  _LibrarySection(
    'My Collections',
    Icons.collections_bookmark_outlined,
    'Create and store your own personal worship routines, referencing the source library rather than duplicating content.',
  ),
];

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navLibrary)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final section = _sections[index];
          final isCollections = section.title == 'My Collections';
          final isBiographies = section.title == 'Biographies';
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => isCollections
                    ? const CollectionsScreen()
                    : isBiographies
                        ? const BiographiesScreen()
                        : ComingSoonScreen(
                            title: section.title,
                            icon: section.icon,
                            description: section.description,
                          ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
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
                    child: Icon(section.icon,
                        color: ZawiyahColors.gold, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        color: ZawiyahColors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: ZawiyahColors.muted, size: 18),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
