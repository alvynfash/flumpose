import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Badge Extensions', () {
    testWidgets('badge() adds badge with count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const Icon(Icons.notifications).badge(count: 5)),
      );
      expect(find.text('5'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('badge() hides when count is 0 and showZero is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const Icon(Icons.notifications).badge(count: 0)),
      );
      expect(find.text('0'), findsNothing);
    });

    testWidgets('badge() shows when count is 0 and showZero is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Icon(Icons.notifications).badge(count: 0, showZero: true),
        ),
      );
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('dotBadge() creates simple dot badge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Icon(Icons.person).dotBadge(color: Colors.green),
        ),
      );
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('notificationBadge() creates notification badge', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const Icon(Icons.mail).notificationBadge(10)),
      );
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('badge() with custom label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const Icon(Icons.star).badge(label: 'NEW')),
      );
      expect(find.text('NEW'), findsOneWidget);
    });
  });
}
