// ============================================================
// Zawiyah — Biographies Screen
// lib/features/biographies/presentation/biographies_screen.dart
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/design_system/zawiyah_colors.dart';
import '../data/biography_content.dart';
import 'biography_detail_screen.dart';

class BiographiesScreen extends StatelessWidget {
  const BiographiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biographies')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: biographies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final b = biographies[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => BiographyDetailScreen(biography: b))),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ZawiyahColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ZawiyahColors.divider),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(b.name,
                        style: const TextStyle(
                            color: ZawiyahColors.text, fontWeight: FontWeight.w600)),
                  ),
                  const Icon(Icons.chevron_right, color: ZawiyahColors.muted, size: 18),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
