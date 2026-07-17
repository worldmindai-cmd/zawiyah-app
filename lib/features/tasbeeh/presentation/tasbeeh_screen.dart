// ============================================================
// Zawiyah — Tasbeeh Screen
// lib/features/tasbeeh/presentation/tasbeeh_screen.dart
//
// The free/unbounded quick counter, ported from the prototype's
// "Digital Tasbeeh" tab -- for any dhikr outside the structured
// Morning A'mal routine. Unlike the structured counters, this one has
// no max_count to cap it: the progress bar simply loops every 100,
// matching the prototype's `freeCount % 100` behaviour.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../../l10n/app_localizations.dart';

final freeCounterProvider =
    FutureProvider<int>((ref) => LocalStorageService().getFreeCounter());

class TasbeehScreen extends ConsumerStatefulWidget {
  const TasbeehScreen({super.key});

  @override
  ConsumerState<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends ConsumerState<TasbeehScreen> {
  int? _count;

  Future<void> _tap() async {
    final current = _count ?? 0;
    setState(() => _count = current + 1);
    HapticFeedback.lightImpact();
    await LocalStorageService().setFreeCounter(current + 1);
  }

  Future<void> _reset() async {
    setState(() => _count = 0);
    await LocalStorageService().setFreeCounter(0);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loadedAsync = ref.watch(freeCounterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navTasbeeh)),
      body: loadedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _buildContent(context, 0),
        data: (loaded) {
          _count ??= loaded;
          return _buildContent(context, _count!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, int count) {
    final progress = (count % 100) / 100;

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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Action',
                style: TextStyle(
                  color: ZawiyahColors.gold,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Use this for any additional dhikr outside the structured morning routine.',
                style: ZawiyahTypography.translation,
              ),
            ],
          ),
        ),
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
              const Text('Quick counter', style: ZawiyahTypography.label),
              const SizedBox(height: 8),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: ZawiyahColors.gold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _tap,
                    child: Text(AppLocalizations.of(context)!.tap),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _reset,
                    child: Text(AppLocalizations.of(context)!.reset),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 9,
                  backgroundColor: const Color(0xFF252525),
                  valueColor:
                      const AlwaysStoppedAnimation(ZawiyahColors.green),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'For any extra dhikr beyond the structured routine.',
                style: ZawiyahTypography.subtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
