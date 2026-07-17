// ============================================================
// Zawiyah — Screenshot flow
//
// Navigates through onboarding (if shown) and each main tab, printing
// a "SCREENSHOT_READY:<name>" marker and pausing before each one so
// an external process (xcrun simctl / adb) can capture a full-device
// screenshot at that exact moment. Not a correctness test -- a driver
// for store-listing screenshots.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:zawiyah/main.dart';

const _pause = Duration(seconds: 6);

Future<void> _readyAndPause(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  // ignore: avoid_print
  print('SCREENSHOT_READY:$name');
  await Future.delayed(_pause);
}

// Home's quick-access cards intentionally reuse the same icons as the
// bottom NavigationBar destinations, so a bare find.byIcon() can match
// both. Scope to the NavigationBar itself to always hit the tab, not
// the card (which pushes a full-screen route instead of switching tabs).
Finder _navIcon(IconData icon) => find.descendant(
      of: find.byType(NavigationBar),
      matching: find.byIcon(icon),
    );

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture store screenshots', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ZawiyahApp()));
    await tester.pumpAndSettle();

    // Complete onboarding if it's showing (fresh install). Skip
    // gracefully if the app already landed on the main shell.
    if (find.text('Continue').evaluate().isNotEmpty) {
      await tester.tap(find.text('Continue')); // dua page
      await tester.pumpAndSettle();

      await tester.tap(
        find.byWidgetPredicate((w) => w is RadioListTile).first,
      ); // role page
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue')); // language page (default en)
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue')); // privacy page
      await tester.pumpAndSettle();

      await tester.tap(find.text('Enter Zawiyah')); // notifications page
      await tester.pumpAndSettle();
    }

    await _readyAndPause(tester, 'home');

    await tester.tap(_navIcon(Icons.wb_twilight_outlined));
    await _readyAndPause(tester, 'morning_aamal');

    await tester.tap(_navIcon(Icons.auto_stories_outlined));
    await _readyAndPause(tester, 'kahani');

    await tester.tap(_navIcon(Icons.local_library_outlined));
    await _readyAndPause(tester, 'library');

    await tester.tap(_navIcon(Icons.more_horiz));
    await _readyAndPause(tester, 'more');
  });
}
