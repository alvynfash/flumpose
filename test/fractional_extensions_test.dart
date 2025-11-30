import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Fractional Extensions', () {
    testWidgets('fractionalTranslate() translates by fraction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().fractionalTranslate(x: 0.5, y: 0.5)),
        ),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('fractionalTranslate() with transformHitTests', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container().fractionalTranslate(
              x: 0.5,
              y: 0.5,
              transformHitTests: false,
            ),
          ),
        ),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('fractionalTranslateX() translates horizontally', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().fractionalTranslateX(0.5)),
        ),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('fractionalTranslateY() translates vertically', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: Container().fractionalTranslateY(0.5)),
        ),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('slideFromLeft() creates slide animation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().slideFromLeft(1.0))),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('slideFromRight() creates slide animation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().slideFromRight(1.0))),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('slideFromTop() creates slide animation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().slideFromTop(1.0))),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('slideFromBottom() creates slide animation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().slideFromBottom(1.0))),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });

    testWidgets('slideFromLeft() with progress 0.5', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().slideFromLeft(0.5))),
      );
      expect(find.byType(FractionalTranslation), findsOneWidget);
    });
  });
}
