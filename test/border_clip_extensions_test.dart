import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Border & Clip Extensions', () {
    group('Borders', () {
      testWidgets('border() applies border', (tester) async {
        final widget = const Text(
          'Border',
        ).border(Border.all(color: Colors.green, width: 2));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Border'), findsOneWidget);
        expect(find.byType(DecoratedBox), findsOneWidget);
      });

      testWidgets('border() with custom border', (tester) async {
        final widget = Container().border(
          const Border(
            top: BorderSide(color: Colors.red, width: 3),
            bottom: BorderSide(color: Colors.blue, width: 3),
          ),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });
    });

    group('Border Radius', () {
      testWidgets('borderRadius() applies border radius', (tester) async {
        final widget = const Text(
          'Radius',
        ).borderRadius(BorderRadius.circular(20));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Radius'), findsOneWidget);
      });

      testWidgets('borderRadius() with custom radius', (tester) async {
        final widget = Container().borderRadius(
          const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(ClipRRect), findsOneWidget);
      });
    });

    group('Clipping', () {
      testWidgets('clipRRect() clips with rounded corners', (tester) async {
        final widget = const Text(
          'ClipRRect',
        ).clipRRect(BorderRadius.circular(12));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('ClipRRect'), findsOneWidget);
        expect(find.byType(ClipRRect), findsOneWidget);
      });

      testWidgets('clipOval() clips to oval shape', (tester) async {
        final widget = const Text('ClipOval').clipOval();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('ClipOval'), findsOneWidget);
        expect(find.byType(ClipOval), findsOneWidget);
      });
    });

    group('Chaining', () {
      testWidgets('border and clip extensions chain correctly', (tester) async {
        final widget = Container()
            .border(Border.all(color: Colors.black))
            .borderRadius(BorderRadius.circular(8))
            .clipRRect(BorderRadius.circular(8));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(ClipRRect), findsExactly(2));
      });
    });
  });
}
