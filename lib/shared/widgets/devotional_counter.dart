// ============================================================
// Zawiyah — Reusable Counter Widget
// lib/shared/widgets/devotional_counter.dart
//
// The core interactive component for tasbeeh/dhikr counting,
// implementing the v0.5 counter experience decisions:
//   - Haptic feedback on every tap
//   - Stronger haptic on completion (reaching max)
//   - Persists via the offline architecture's local storage (caller
//     passes in current value + onIncrement/onReset callbacks --
//     this widget itself holds no persistence logic, keeping it a
//     pure, reusable, testable UI component)
//   - Sajda mode (tap-anywhere-on-screen, no need to look at the
//     display) is a separate wrapper widget, not built here yet
//
// RTL NOTE (open question, not assumed): "right-handed operation"
// was specified against an implicit LTR mental model. In an RTL
// layout (Arabic/Urdu), naively mirroring this widget's layout could
// put the tap target in a position that no longer matches the actual
// ergonomic intent (thumb position relative to how the phone is
// typically held). This widget currently uses a literal Row (not
// swapped by Directionality) so tap/reset/count always appear in the
// same visual position regardless of locale -- this is a deliberate
// choice to preserve ergonomics over automatic mirroring, but it's
// exactly the kind of decision the Content Authority / Design System
// docs should confirm explicitly rather than Claude assuming silently.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/design_system/zawiyah_colors.dart';
import '../../core/design_system/zawiyah_typography.dart';
import '../../l10n/app_localizations.dart';

class DevotionalCounter extends StatelessWidget {
  final String arabicText;
  final String transliteration;
  final String? translation;
  final int currentCount;
  final int maxCount;
  final VoidCallback onIncrement;
  final VoidCallback onReset;

  const DevotionalCounter({
    super.key,
    required this.arabicText,
    required this.transliteration,
    this.translation,
    required this.currentCount,
    required this.maxCount,
    required this.onIncrement,
    required this.onReset,
  });

  bool get _isComplete => currentCount >= maxCount;

  void _handleTap() {
    if (_isComplete) return;
    final willComplete = currentCount + 1 >= maxCount;
    // Stronger haptic on completion, lighter tap otherwise -- per the
    // v0.5 counter experience decision.
    if (willComplete) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.lightImpact();
    }
    onIncrement();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: ZawiyahColors.card2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZawiyahColors.divider2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Arabic text is always RTL, regardless of app locale.
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              arabicText,
              style: ZawiyahTypography.arabic,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 8),
          Text(transliteration, style: ZawiyahTypography.transliteration),
          if (translation != null) ...[
            const SizedBox(height: 8),
            Text(translation!, style: ZawiyahTypography.translation),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: _isComplete ? null : _handleTap,
                child: Text(l10n.tap),
              ),
              const SizedBox(width: 8),
              Text(
                '$currentCount/$maxCount',
                style: const TextStyle(
                  color: ZawiyahColors.gold,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onReset,
                child: Text(l10n.reset),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
