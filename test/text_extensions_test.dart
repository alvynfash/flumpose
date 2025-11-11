import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Text Extensions', () {
    group('Font Size', () {
      testWidgets('fontSize() sets font size', (tester) async {
        final widget = const Text('FontSize').fontSize(30);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('FontSize'), findsOneWidget);

        final text = tester.widget<Text>(find.text('FontSize'));
        expect(text.style?.fontSize, 30);
      });

      testWidgets('fontSize() with different sizes', (tester) async {
        final widget = const Text('Test').fontSize(18);
        await tester.pumpWidget(MaterialApp(home: widget));

        final text = tester.widget<Text>(find.text('Test'));
        expect(text.style?.fontSize, 18);
      });
    });

    group('Text Color', () {
      testWidgets('color() sets text color', (tester) async {
        final widget = const Text('Color').color(Colors.purple);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Color'), findsOneWidget);

        final text = tester.widget<Text>(find.text('Color'));
        expect(text.style?.color, Colors.purple);
      });

      testWidgets('textColor() sets text color', (tester) async {
        final widget = const Text('TextColor').textColor(Colors.orange);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('TextColor'), findsOneWidget);

        final text = tester.widget<Text>(find.text('TextColor'));
        expect(text.style?.color, Colors.orange);
      });
    });

    group('Font Weight', () {
      testWidgets('bold() makes text bold', (tester) async {
        final widget = const Text('Bold').bold();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Bold'), findsOneWidget);

        final text = tester.widget<Text>(find.text('Bold'));
        expect(text.style?.fontWeight, FontWeight.bold);
      });
    });

    group('Font Style', () {
      testWidgets('italic() makes text italic', (tester) async {
        final widget = const Text('Italic').italic();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Italic'), findsOneWidget);

        final text = tester.widget<Text>(find.text('Italic'));
        expect(text.style?.fontStyle, FontStyle.italic);
      });
    });

    group('Chaining', () {
      testWidgets('multiple text extensions chain correctly', (tester) async {
        final widget = const Text('Test').bold().color(Colors.red).fontSize(18);

        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Test'), findsOneWidget);

        final text = tester.widget<Text>(find.text('Test'));
        expect(text.style?.fontWeight, FontWeight.bold);
        expect(text.style?.color, Colors.red);
        expect(text.style?.fontSize, 18);
      });
    });
  });
}
