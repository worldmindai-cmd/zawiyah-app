// ============================================================
// Zawiyah — Kahani Screen
// lib/features/kahani/presentation/kahani_screen.dart
//
// Story selector + language selector + TTS read-aloud. Content is now
// loaded asynchronously from JSON asset files via KahaniRepository
// (see kahani_repository.dart) rather than hardcoded Dart strings.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../data/kahani_repository.dart';
import '../domain/kahani_item.dart';
import '../../../l10n/app_localizations.dart';

final kahaniListProvider =
    FutureProvider<List<KahaniItem>>((ref) => KahaniRepository().loadAll());

class KahaniScreen extends ConsumerStatefulWidget {
  const KahaniScreen({super.key});

  @override
  ConsumerState<KahaniScreen> createState() => _KahaniScreenState();
}

class _KahaniScreenState extends ConsumerState<KahaniScreen> {
  final FlutterTts _tts = FlutterTts();
  String? _selectedKahaniId;
  String? _selectedLanguage;

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _speak(KahaniItem item) async {
    final speakableText = item.speakableTextFor(_selectedLanguage!);
    if (speakableText == null || speakableText.isEmpty) return;
    await _tts.stop();
    await _tts.setLanguage(item.ttsLocaleFor(_selectedLanguage!));
    await _tts.speak(speakableText);
  }

  Future<void> _showAvailableLanguages() async {
    final languages = await _tts.getLanguages;
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ZawiyahColors.card,
        title: const Text(
          'Installed TTS languages',
          style: TextStyle(color: ZawiyahColors.gold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              (languages as List).join('\n'),
              style: ZawiyahTypography.body,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _stop() => _tts.stop();

  void _onKahaniChanged(String? id, List<KahaniItem> allItems) {
    if (id == null) return;
    final item = allItems.firstWhere((k) => k.id == id);
    setState(() {
      _selectedKahaniId = id;
      if (!item.availableLanguages.contains(_selectedLanguage)) {
        _selectedLanguage = item.availableLanguages.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final kahaniListAsync = ref.watch(kahaniListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navKahani)),
      body: kahaniListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Could not load kahani content: $err',
              style: ZawiyahTypography.translation,
            ),
          ),
        ),
        data: (items) {
          _selectedKahaniId ??= items.first.id;
          _selectedLanguage ??= items.first.availableLanguages.first;
          final item = items.firstWhere((k) => k.id == _selectedKahaniId);
          final text = item.textFor(_selectedLanguage!) ?? '';
          final isRtl = item.isRtlFor(_selectedLanguage!);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 8),
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
                    Text(
                      'Choose a kahani, select the language, then either read it yourself or use the phone voice to recite it aloud.',
                      style: ZawiyahTypography.translation,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: ZawiyahColors.card2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ZawiyahColors.divider2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Choose a kahani', style: ZawiyahTypography.label),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: ZawiyahColors.card2,
                      value: _selectedKahaniId,
                      items: items
                          .map((k) => DropdownMenuItem(
                                value: k.id,
                                child: Text(
                                  k.title,
                                  style: ZawiyahTypography.body,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (id) => _onKahaniChanged(id, items),
                    ),
                    const SizedBox(height: 14),
                    Text('Language', style: ZawiyahTypography.label),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: ZawiyahColors.card2,
                      value: _selectedLanguage,
                      items: item.availableLanguages
                          .map((key) => DropdownMenuItem(
                                value: key,
                                child: Text(item.labelFor(key)),
                              ))
                          .toList(),
                      onChanged: (v) => setState(
                          () => _selectedLanguage = v ?? _selectedLanguage),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _speak(item),
                          child: const Text('Recite with phone voice'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(onPressed: _stop, child: const Text('Stop')),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _showAvailableLanguages,
                          icon: const Icon(Icons.info_outline,
                              color: ZawiyahColors.muted, size: 18),
                          tooltip: 'Show installed TTS languages',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Uses the phone\'s voice engine where available: Siri-style voices on iPhone and Google voices on Android. Full Urdu/Arabic voice quality depends on installed device voices.',
                      style: ZawiyahTypography.subtitle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: ZawiyahColors.card2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: ZawiyahColors.divider2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: ZawiyahTypography.label),
                    if (item.isAiTranslation(_selectedLanguage!))
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ZawiyahColors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: ZawiyahColors.green.withOpacity(0.4),
                            ),
                          ),
                          child: const Text(
                            'AI translation — pending review',
                            style: TextStyle(
                              fontSize: 11,
                              color: ZawiyahColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Directionality(
                      textDirection:
                          isRtl ? TextDirection.rtl : TextDirection.ltr,
                      child: Text(
                        text,
                        style:
                            ZawiyahTypography.translation.copyWith(height: 1.7),
                        textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.aamal != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ZawiyahColors.card2,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ZawiyahColors.divider2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('A\'māl alongside this kahani',
                          style: ZawiyahTypography.label),
                      const SizedBox(height: 8),
                      Text(item.aamal!, style: ZawiyahTypography.translation),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
