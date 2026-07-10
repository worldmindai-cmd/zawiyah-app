// ============================================================
// Zawiyah — Counter Reset Signal
// lib/shared/providers/counter_reset_signal.dart
//
// A simple "signal" provider: incrementing its value is a broadcast
// telling every currently-mounted DevotionalCounter/_CounterBlock to
// reset itself to zero. Using an incrementing int (rather than a
// bool) means every press is a distinct, observable event even if
// pressed twice in a row.
// ============================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterResetSignalProvider = StateProvider<int>((ref) => 0);
