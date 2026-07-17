// ============================================================
// Zawiyah — Coming Soon Screen
// lib/shared/widgets/coming_soon_screen.dart
//
// Reusable placeholder for sections that exist in the navigation
// structure but don't have real content/logic built yet. One widget,
// parameterised per section, rather than near-duplicate files.
// ============================================================

import 'package:flutter/material.dart';

import '../../core/design_system/zawiyah_colors.dart';
import '../../core/design_system/zawiyah_typography.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: ZawiyahColors.gold),
              const SizedBox(height: 16),
              Text(
                title,
                style: ZawiyahTypography.heading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: ZawiyahTypography.subtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ZawiyahColors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: ZawiyahColors.green.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  'Coming soon',
                  style: TextStyle(
                    color: ZawiyahColors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
