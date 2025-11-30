import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Blur Extensions', () {
    testWidgets('blur() applies blur effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: Container(),
            ).blur(sigmaX: 5),
          ),
        ),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRect), findsOneWidget);
    });

    testWidgets('blur() with custom sigmaX and sigmaY', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Container().blur(sigmaX: 10, sigmaY: 5)),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('backdropBlur() applies backdrop blur', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Container().backdropBlur(sigma: 10)),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRect), findsOneWidget);
    });

    testWidgets('backdropBlur() with overlay color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().backdropBlur(
            sigma: 10,
            overlayColor: Colors.black26,
          ),
        ),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('frostedGlass() creates frosted glass effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Container().frostedGlass(sigma: 8)),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRect), findsOneWidget);
    });

    testWidgets('frostedGlass() with custom color and opacity', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().frostedGlass(
            sigma: 10,
            color: Colors.blue,
            opacity: 0.5,
          ),
        ),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('blurRounded() applies blur with border radius', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Container().blurRounded(sigma: 5, radius: 12)),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
    });
  });
}
