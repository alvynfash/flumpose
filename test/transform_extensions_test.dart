import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Transform Extensions', () {
    group('Rotation', () {
      testWidgets('rotate() rotates widget', (tester) async {
        final widget = const Text('Rotate').rotate(0.5);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Rotate'), findsOneWidget);
        expect(find.byType(Transform), findsOneWidget);
      });

      testWidgets('rotate() with different angles', (tester) async {
        final widget = Container().rotate(1.0);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Transform), findsOneWidget);
      });
    });

    group('Scaling', () {
      testWidgets('scaleWidget() scales widget', (tester) async {
        final widget = const Text('Scale').scaleWidget(1.5);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Scale'), findsOneWidget);
        expect(find.byType(Transform), findsOneWidget);
      });

      testWidgets('scaleWidget() with different scale factors', (tester) async {
        final widget = Container().scaleWidget(2.0);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Transform), findsOneWidget);
      });
    });

    group('Translation', () {
      testWidgets('translate() moves widget', (tester) async {
        final widget = const Text('Translate').translate(x: 10, y: 10);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Translate'), findsOneWidget);
        expect(find.byType(Transform), findsOneWidget);
      });

      testWidgets('translate() with x offset only', (tester) async {
        final widget = Container().translate(x: 20);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Transform), findsOneWidget);
      });

      testWidgets('translate() with y offset only', (tester) async {
        final widget = Container().translate(y: 30);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Transform), findsOneWidget);
      });
    });

    group('Chaining', () {
      testWidgets('multiple transform extensions chain correctly', (
        tester,
      ) async {
        final widget = Container()
            .rotate(0.5)
            .scaleWidget(1.2)
            .translate(x: 10, y: 20);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Transform), findsNWidgets(3));
      });
    });
  });
}
