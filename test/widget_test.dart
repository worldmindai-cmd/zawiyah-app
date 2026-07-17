import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:zawiyah/core/storage/local_storage_service.dart';
import 'package:zawiyah/main.dart';

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiNoIsolate;
    // Pre-warm the connection for real (setUpAll runs outside the
    // fake-async pump zone) -- opening it lazily inside a pump() would
    // never resolve, since sqflite's FFI file I/O needs real wall-clock
    // time that the fake-async test zone doesn't advance.
    await LocalStorageService().database;
  });

  testWidgets('Zawiyah app launches', (WidgetTester tester) async {
    // Seed onboarding as complete so the smoke test exercises the main
    // shell (NavigationBar) rather than the first-run onboarding flow.
    await LocalStorageService().setString('onboarding_complete', '1');

    await tester.pumpWidget(
      const ProviderScope(child: ZawiyahApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
