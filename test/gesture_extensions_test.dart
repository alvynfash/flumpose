import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Gesture Extensions', () {
    group('Tap Gestures', () {
      testWidgets('onTap() handles tap events', (tester) async {
        bool tapped = false;
        final widget = const Text('Tap').onTap(() {
          tapped = true;
        });
        await tester.pumpWidget(MaterialApp(home: widget));
        await tester.tap(find.text('Tap'));
        expect(tapped, isTrue);
      });

      testWidgets('ripple() creates InkWell with ripple effect', (
        tester,
      ) async {
        final widget = const Text('Ripple').ripple(() {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Ripple'), findsOneWidget);
        expect(find.byType(InkWell), findsOneWidget);
      });

      testWidgets('onTapWithPosition() wraps in GestureDetector', (
        tester,
      ) async {
        final widget = Container().onTapWithPosition(onTapDown: (d) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });
    });

    group('Pan Gestures', () {
      testWidgets('onPan() handles pan gestures', (tester) async {
        final widget = Container().onPan(onPanStart: (details) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });

      testWidgets('onPan() with update callback creates GestureDetector', (
        tester,
      ) async {
        final widget = Container().onPan(onPanUpdate: (details) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });
    });

    group('Drag Gestures', () {
      testWidgets('onHorizontalDrag() creates GestureDetector', (tester) async {
        final widget = Container().onHorizontalDrag(onUpdate: (details) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });

      testWidgets('onVerticalDrag() creates GestureDetector', (tester) async {
        final widget = Container().onVerticalDrag(onUpdate: (details) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });
    });

    group('Scale Gestures', () {
      testWidgets('onScale() detects scale gestures', (tester) async {
        final widget = Container().onScale(onScaleStart: (details) {});
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(GestureDetector), findsOneWidget);
      });
    });

    group('Draggable', () {
      testWidgets('draggable() creates Draggable widget', (tester) async {
        final widget = Container().draggable<String>(data: 'test');
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Draggable<String>), findsOneWidget);
      });

      testWidgets('draggable() with feedback widget', (tester) async {
        final widget = Container().draggable<String>(
          data: 'test',
          feedback: const Text('Dragging'),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Draggable<String>), findsOneWidget);
      });
    });

    group('Chaining', () {
      testWidgets('gesture extensions can be chained', (tester) async {
        final widget = Container().onTap(() {}).pad(16);

        await tester.pumpWidget(MaterialApp(home: widget));
        // Just verify the GestureDetector and Padding are created
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(Padding), findsOneWidget);
      });
    });
  });
}
