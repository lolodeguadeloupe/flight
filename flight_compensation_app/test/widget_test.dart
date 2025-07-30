// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flight_compensation_app/main.dart';

void main() {
  testWidgets('Flight compensation app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: FlightCompensationApp()));

    // Verify that the app loads with the form
    expect(find.text('Réclamation Indemnité Vol'), findsOneWidget);
    expect(find.text('Informations du vol'), findsOneWidget);
    expect(find.text('Numéro de vol'), findsOneWidget);
  });
}
