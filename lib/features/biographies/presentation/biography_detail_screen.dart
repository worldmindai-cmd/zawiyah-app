// ============================================================
// Zawiyah — Biography Detail Screen
// lib/features/biographies/presentation/biography_detail_screen.dart
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../../../core/design_system/zawiyah_typography.dart';
import '../domain/biography.dart';

class BiographyDetailScreen extends StatelessWidget {
  final Biography biography;
  const BiographyDetailScreen({super.key, required this.biography});

  Widget _section(String label, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZawiyahColors.card2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ZawiyahColors.divider2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: ZawiyahTypography.label),
          const SizedBox(height: 6),
          Text(content, style: ZawiyahTypography.translation),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(biography.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (biography.needsReview)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: ZawiyahColors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ZawiyahColors.red.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'This content is a placeholder pending sourcing and scholarly review — not yet authoritative.',
                style: TextStyle(color: ZawiyahColors.text, fontSize: 12),
              ),
            ),
          _section('Who', biography.who),
          _section('What', biography.what),
          _section('When', biography.when),
          _section('Where', biography.where),
          _section('Why', biography.why),
          _section('How', biography.how),
        ],
      ),
    );
  }
}
