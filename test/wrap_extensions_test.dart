import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Wrap Extensions', () {
    testWidgets('toWrap() creates Wrap widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [
            const Text('A'),
            const Text('B'),
            const Text('C'),
          ].toWrap(spacing: 8),
        ),
      );
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('toHorizontalWrap() creates horizontal Wrap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [
            const Text('A'),
            const Text('B'),
          ].toHorizontalWrap(spacing: 16),
        ),
      );
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('toVerticalWrap() creates vertical Wrap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [const Text('A'), const Text('B')].toVerticalWrap(spacing: 8),
        ),
      );
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('wrap() wraps single widget in Wrap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const Text('Test').wrap(spacing: 8)),
      );
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
