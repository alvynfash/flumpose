import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Custom Layout Extensions', () {
    testWidgets('layoutBuilder() creates LayoutBuilder', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().layoutBuilder(
            (context, constraints) => Text('Width: ${constraints.maxWidth}'),
          ),
        ),
      );
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('offstage() hides widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const Text('Hidden').offstage())),
      );
      expect(find.byType(Offstage), findsOneWidget);
    });

    testWidgets('offstage(false) shows widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const Text('Visible').offstage(offstage: false)),
      );
      expect(find.text('Visible'), findsOneWidget);
    });

    testWidgets('overflowBox() creates OverflowBox', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              height: 100,
              child: Container().overflowBox(maxWidth: 200, maxHeight: 200),
            ),
          ),
        ),
      );
      expect(find.byType(OverflowBox), findsOneWidget);
    });

    testWidgets('limitedBox() creates LimitedBox', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container().limitedBox(maxWidth: 100, maxHeight: 100),
          ),
        ),
      );
      expect(find.byType(LimitedBox), findsOneWidget);
    });

    testWidgets('intrinsicHeight() creates IntrinsicHeight', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const Text('Test').intrinsicHeight())),
      );
      expect(find.byType(IntrinsicHeight), findsOneWidget);
    });

    testWidgets('intrinsicWidth() creates IntrinsicWidth', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const Text('Test').intrinsicWidth())),
      );
      expect(find.byType(IntrinsicWidth), findsOneWidget);
    });

    testWidgets('repaintBoundary() creates RepaintBoundary', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: Container().repaintBoundary())),
      );
      expect(find.byType(RepaintBoundary), findsAtLeastNWidgets(1));
    });

    testWidgets('toListView() creates ListView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: [const Text('A'), const Text('B')].toListView()),
      );
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('toGridView() creates GridView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [
            Container(),
            Container(),
            Container(),
          ].toGridView(crossAxisCount: 2),
        ),
      );
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
