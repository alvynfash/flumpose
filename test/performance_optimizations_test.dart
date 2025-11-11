import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Performance Optimizations v2', () {
    group('Text Style Accumulation', () {
      testWidgets('preserves all Text properties through chains', (
        tester,
      ) async {
        const key = Key('test-text');
        final widget = const Text(
          'Hello',
          key: key,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ).color(Colors.red).fontSize(18).bold();

        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.byKey(key));
        expect(textWidget.data, 'Hello');
        expect(textWidget.textAlign, TextAlign.center);
        expect(textWidget.maxLines, 2);
        expect(textWidget.overflow, TextOverflow.ellipsis);
        expect(textWidget.style?.color, Colors.red);
        expect(textWidget.style?.fontSize, 18);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      });

      testWidgets('fontSize() sets font size', (tester) async {
        final widget = const Text('Test').fontSize(24);
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.fontSize, 24);
      });

      testWidgets('color() sets text color', (tester) async {
        final widget = const Text('Test').color(Colors.blue);
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.color, Colors.blue);
      });

      testWidgets('bold() makes text bold', (tester) async {
        final widget = const Text('Test').bold();
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      });

      testWidgets('italic() makes text italic', (tester) async {
        final widget = const Text('Test').italic();
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.fontStyle, FontStyle.italic);
      });

      testWidgets('fontWeight() sets font weight', (tester) async {
        final widget = const Text('Test').fontWeight(FontWeight.w600);
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.fontWeight, FontWeight.w600);
      });

      testWidgets('letterSpacing() sets letter spacing', (tester) async {
        final widget = const Text('Test').letterSpacing(2.0);
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.letterSpacing, 2.0);
      });

      testWidgets('height() sets line height', (tester) async {
        final widget = const Text('Test').height(1.5);
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.height, 1.5);
      });

      testWidgets('underline() adds underline decoration', (tester) async {
        final widget = const Text('Test').underline();
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.decoration, TextDecoration.underline);
      });

      testWidgets('lineThrough() adds strikethrough decoration', (
        tester,
      ) async {
        final widget = const Text('Test').lineThrough();
        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Test'));
        expect(textWidget.style?.decoration, TextDecoration.lineThrough);
      });

      testWidgets('chained text extensions accumulate styles', (tester) async {
        final widget = const Text(
          'Hello',
        ).color(Colors.red).fontSize(18).bold().letterSpacing(1.2);

        await tester.pumpWidget(MaterialApp(home: widget));

        final textWidget = tester.widget<Text>(find.text('Hello'));
        expect(textWidget.style?.color, Colors.red);
        expect(textWidget.style?.fontSize, 18);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.style?.letterSpacing, 1.2);
      });
    });

    group('DecorationBuilder', () {
      testWidgets('decorate() creates single Container', (tester) async {
        final widget = const Text('Test').decorate((d) => d.color(Colors.blue));
        await tester.pumpWidget(MaterialApp(home: widget));

        expect(find.byType(Container), findsOneWidget);
        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.blue);
      });

      testWidgets('builds decoration with color', (tester) async {
        final widget = const Text('Test').decorate((d) => d.color(Colors.red));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.red);
      });

      testWidgets('builds decoration with border', (tester) async {
        final border = Border.all(color: Colors.black, width: 2);
        final widget = const Text('Test').decorate((d) => d.border(border));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, border);
      });

      testWidgets('builds decoration with borderAll shorthand', (tester) async {
        final widget = const Text(
          'Test',
        ).decorate((d) => d.borderAll(color: Colors.green, width: 3));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isA<Border>());
      });

      testWidgets('builds decoration with borderRadius', (tester) async {
        final radius = BorderRadius.circular(8);
        final widget = const Text(
          'Test',
        ).decorate((d) => d.borderRadius(radius));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, radius);
      });

      testWidgets('builds decoration with circular shorthand', (tester) async {
        final widget = const Text('Test').decorate((d) => d.circular(12));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, BorderRadius.circular(12));
      });

      testWidgets('builds decoration with shadow', (tester) async {
        final shadow = const BoxShadow(color: Colors.black26, blurRadius: 4);
        final widget = const Text('Test').decorate((d) => d.shadow(shadow));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, [shadow]);
      });

      testWidgets('builds decoration with simpleShadow', (tester) async {
        final widget = const Text('Test').decorate((d) => d.simpleShadow());
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow?.length, 1);
      });

      testWidgets('builds decoration with linear gradient', (tester) async {
        final widget = const Text(
          'Test',
        ).decorate((d) => d.linearGradient(colors: [Colors.red, Colors.blue]));
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
      });

      testWidgets('builds decoration with radial gradient', (tester) async {
        final widget = const Text('Test').decorate(
          (d) => d.radialGradient(colors: [Colors.yellow, Colors.orange]),
        );
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<RadialGradient>());
      });

      testWidgets('builds decoration with circle shape', (tester) async {
        final widget = const Text('Test').decorate((d) => d.circle());
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.shape, BoxShape.circle);
      });

      testWidgets('chains multiple decoration properties', (tester) async {
        final widget = const Text('Test').decorate(
          (d) => d
              .color(Colors.blue)
              .circular(8)
              .borderAll(color: Colors.black, width: 2)
              .simpleShadow(),
        );
        await tester.pumpWidget(MaterialApp(home: widget));

        final container = tester.widget<Container>(find.byType(Container));
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.blue);
        expect(decoration.borderRadius, BorderRadius.circular(8));
        expect(decoration.border, isNotNull);
        expect(decoration.boxShadow, isNotNull);
      });

      testWidgets(
        'decorateWithPadding() creates single Container with padding',
        (tester) async {
          final widget = const Text('Test').decorateWithPadding(
            padding: const EdgeInsets.all(16),
            builder: (d) => d.color(Colors.green),
          );
          await tester.pumpWidget(MaterialApp(home: widget));

          expect(find.byType(Container), findsOneWidget);
          final container = tester.widget<Container>(find.byType(Container));
          expect(container.padding, const EdgeInsets.all(16));
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, Colors.green);
        },
      );
    });

    group('Performance Comparison', () {
      test('Text chaining creates fewer intermediate objects', () {
        // This is a conceptual test - in practice, we'd use profiling tools
        // to measure actual allocations. Here we just verify the API works.
        final text = const Text(
          'Hello',
        ).color(Colors.red).fontSize(18).bold().italic();

        expect(text.data, 'Hello');
        expect(text.style?.color, Colors.red);
        expect(text.style?.fontSize, 18);
        expect(text.style?.fontWeight, FontWeight.bold);
        expect(text.style?.fontStyle, FontStyle.italic);
      });

      test('DecorationBuilder creates single decoration', () {
        // Verify the builder pattern works correctly
        final builder = DecorationBuilder()
            .color(Colors.blue)
            .circular(8)
            .borderAll(color: Colors.black)
            .simpleShadow();

        final decoration = builder.build();
        expect(decoration.color, Colors.blue);
        expect(decoration.borderRadius, BorderRadius.circular(8));
        expect(decoration.border, isNotNull);
        expect(decoration.boxShadow, isNotNull);
      });
    });
  });
}
