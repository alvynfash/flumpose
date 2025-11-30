import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Ink Extensions', () {
    testWidgets('inkWell() wraps in InkWell', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().inkWell(onTap: () {})),
        ),
      );
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('inkWell() with splash color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container().inkWell(onTap: () {}, splashColor: Colors.blue),
          ),
        ),
      );
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('ink() wraps in Ink', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().ink(color: Colors.blue)),
        ),
      );
      expect(find.byType(Ink), findsOneWidget);
    });

    testWidgets('ink() with decoration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container().ink(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(Ink), findsOneWidget);
    });

    testWidgets('inkTap() combines Ink and InkWell', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('Tap').inkTap(onTap: () {}, color: Colors.blue),
          ),
        ),
      );
      expect(find.byType(Ink), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('inkDecoration() with decoration and tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('Tap').inkDecoration(
              onTap: () {},
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
        ),
      );
      expect(find.byType(Ink), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('inkResponse() wraps in InkResponse', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().inkResponse(onTap: () {})),
        ),
      );
      expect(find.byType(InkResponse), findsOneWidget);
    });
  });
}
