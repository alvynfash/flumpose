import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Layout Extensions', () {
    group('Padding', () {
      testWidgets('pad() with double value', (tester) async {
        final widget = const Text('Test').pad(8);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Test'), findsOneWidget);
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('pad() with EdgeInsets', (tester) async {
        final widget = const Text('Pad').padding(const EdgeInsets.all(12));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Pad'), findsOneWidget);
      });

      testWidgets('pad() with const-optimized value', (tester) async {
        final widget = Container().pad(16);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('padH() adds horizontal padding', (tester) async {
        final widget = Container().padH(16);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('padV() adds vertical padding', (tester) async {
        final widget = Container().padV(8);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('padSymmetric() adds symmetric padding', (tester) async {
        final widget = Container().padSymmetric(horizontal: 16, vertical: 8);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('padOnly() adds directional padding', (tester) async {
        final widget = Container().padOnly(left: 10, top: 5);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Padding), findsOneWidget);
      });
    });

    group('Margin', () {
      testWidgets('margin() with double value', (tester) async {
        final widget = const Text('Margin').margin(12);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Margin'), findsOneWidget);
      });

      testWidgets('margin() with EdgeInsets', (tester) async {
        final widget = const Text(
          'Margin',
        ).marginAll(const EdgeInsets.symmetric(horizontal: 16));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Margin'), findsOneWidget);
      });

      testWidgets('marginH() adds horizontal margin', (tester) async {
        final widget = Container().marginH(20);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Container), findsNWidgets(2));
      });

      testWidgets('marginV() adds vertical margin', (tester) async {
        final widget = Container().marginV(10);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Container), findsNWidgets(2));
      });

      testWidgets('marginSymmetric() adds symmetric margin', (tester) async {
        final widget = Container().marginSymmetric(
          horizontal: 20,
          vertical: 10,
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Container), findsNWidgets(2));
      });

      testWidgets('marginOnly() adds directional margin', (tester) async {
        final widget = Container().marginOnly(left: 15, right: 25);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Container), findsNWidgets(2));
      });
    });

    group('Alignment', () {
      testWidgets('alignCenter() centers widget', (tester) async {
        final widget = const Text('Center').alignCenter();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Center'), findsOneWidget);
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('alignTopLeft() aligns to top left', (tester) async {
        final widget = const Text('TopLeft').alignTopLeft();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('alignBottomRight() aligns to bottom right', (tester) async {
        final widget = const Text('Align').alignBottomRight();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Align'), findsOneWidget);
      });

      testWidgets('alignTopCenter() aligns to top center', (tester) async {
        final widget = Container().alignTopCenter();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('alignCenterLeft() aligns to center left', (tester) async {
        final widget = Container().alignCenterLeft();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('alignCenterRight() aligns to center right', (tester) async {
        final widget = Container().alignCenterRight();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('alignBottomCenter() aligns to bottom center', (
        tester,
      ) async {
        final widget = Container().alignBottomCenter();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });

      testWidgets('align() with custom alignment', (tester) async {
        final widget = Container().align(Alignment.topRight);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Align), findsOneWidget);
      });
    });

    group('Sizing', () {
      testWidgets('width() sets widget width', (tester) async {
        final widget = Container().width(200);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SizedBox), findsOneWidget);
      });

      testWidgets('height() sets widget height', (tester) async {
        final widget = Container().height(100);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SizedBox), findsOneWidget);
      });

      testWidgets('width() and height() chain together', (tester) async {
        final widget = Container().width(200).height(100);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SizedBox), findsNWidgets(2));
      });

      testWidgets('squareBox() creates square dimensions', (tester) async {
        final widget = Container().squareBox(50);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SizedBox), findsOneWidget);
      });
    });

    group('Constraints', () {
      testWidgets('constrained() applies box constraints', (tester) async {
        final widget = Container().constrained(
          const BoxConstraints(maxWidth: 300, maxHeight: 400),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(ConstrainedBox), findsNWidgets(3));
      });
    });

    group('Scrollable', () {
      testWidgets('scrollable() makes widget scrollable', (tester) async {
        final widget = Container().scrollable();
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('scrollable() with custom axis', (tester) async {
        final widget = Container().scrollable(axis: Axis.horizontal);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });
    });

    group('Overflow', () {
      testWidgets('overflow() clips content', (tester) async {
        final widget = Container().overflow(clip: Clip.hardEdge);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(ClipRect), findsOneWidget);
      });
    });

    group('Chaining', () {
      testWidgets('multiple layout extensions chain correctly', (tester) async {
        final widget = const Text(
          'Test',
        ).pad(8).margin(16).alignCenter().width(200).height(100);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Test'), findsOneWidget);
      });
    });
  });
}
