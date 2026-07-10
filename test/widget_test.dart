import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zawiyah/main.dart';

void main() {
  testWidgets('Zawiyah app launches', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: ZawiyahApp()),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
