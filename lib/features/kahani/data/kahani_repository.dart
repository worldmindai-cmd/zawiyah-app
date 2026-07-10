// ============================================================
// Zawiyah — Kahani Content Repository
// lib/features/kahani/data/kahani_repository.dart
//
// Loads Kahani content from JSON files under assets/content/kahani/
// instead of hardcoding it as Dart string literals. This matters for
// a few reasons:
//   - Content Authority / review workflow: a scholar or reviewer can
//     edit a .json file directly without touching Dart code
//   - Matches the Content Engine layer described in the Technical
//     Build Specification -- content is DATA, the app is CODE
//   - A natural stepping stone toward the real Download System later
//     (these files could equally be fetched from a server rather
//     than bundled, without changing this repository's public shape)
//
// Adding a new kahani = add a new .json file here AND list its
// filename below -- Flutter's asset system doesn't support runtime
// directory listing, so the filename list has to be maintained
// explicitly (see _kahaniFilenames).
// ============================================================

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../domain/kahani_item.dart';

const _kahaniFilenames = [
  'fatima.json',
  'sakina.json',
  'abbas.json',
  'ali_asghar.json',
  'zainab.json',
];

class KahaniRepository {
  Future<List<KahaniItem>> loadAll() async {
    final items = <KahaniItem>[];
    for (final filename in _kahaniFilenames) {
      final raw = await rootBundle
          .loadString('assets/content/kahani/$filename');
      final json = jsonDecode(raw) as Map<String, dynamic>;
      items.add(_fromJson(json));
    }
    return items;
  }

  KahaniItem _fromJson(Map<String, dynamic> json) {
    return KahaniItem(
      id: json['id'] as String,
      title: json['title'] as String,
      aamal: json['aamal'] as String?,
      english: json['english'] as String?,
      urduScript: json['urduScript'] as String?,
      romanUrdu: json['romanUrdu'] as String?,
      arabic: json['arabic'] as String?,
      aiTranslatedLanguages: (json['aiTranslatedLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );
  }
}
