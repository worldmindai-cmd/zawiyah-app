// ============================================================
// Zawiyah — Calendar Provider
// lib/core/calendar/calendar_provider.dart
//
// Wraps ZawiyahCalendar.now() with the user's stored manual day
// offset, giving one source of truth for both the Home screen's date
// display and the app-level Aza-period theme switch.
// ============================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/local_storage_service.dart';
import 'zawiyah_calendar.dart';

final hijriDayOffsetProvider = FutureProvider<int>((ref) {
  return LocalStorageService().getHijriDayOffset();
});

final currentCalendarContextProvider = Provider<ShiaCalendarContext>((ref) {
  final offsetAsync = ref.watch(hijriDayOffsetProvider);
  final offset = offsetAsync.value ?? 0;
  return ZawiyahCalendar.now(dayOffset: offset);
});
