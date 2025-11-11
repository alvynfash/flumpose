import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  testWidgets('LayoutExtensions padding test', (WidgetTester tester) async {
    final widget = Container().pad(10);
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byWidget(widget), findsOneWidget);
  });

  testWidgets('BackgroundExtensions backgroundColor test', (
    WidgetTester tester,
  ) async {
    final widget = Container().backgroundColor(Colors.red);
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byWidget(widget), findsOneWidget);
  });

  testWidgets('BorderClipExtensions borderRadius test', (
    WidgetTester tester,
  ) async {
    final widget = Container().borderRadius(BorderRadius.circular(8));
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byWidget(widget), findsOneWidget);
  });

  testWidgets('TransformExtensions rotate test', (WidgetTester tester) async {
    final widget = Container().rotate(0.5);
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byWidget(widget), findsOneWidget);
  });

  testWidgets('GestureExtensions onTap test', (WidgetTester tester) async {
    bool tapped = false;
    final widget = Container().onTap(() {
      tapped = true;
    });
    await tester.pumpWidget(MaterialApp(home: widget));
    await tester.tap(find.byWidget(widget));
    expect(tapped, isTrue);
  });

  testWidgets('TextExtensions style helpers test', (WidgetTester tester) async {
    final widget = Text('Test').bold().color(Colors.red).fontSize(18);
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.text('Test'), findsOneWidget);
    final text = tester.widget<Text>(find.text('Test'));
    expect(text.style?.fontWeight, FontWeight.bold);
    expect(text.style?.color, Colors.red);
    expect(text.style?.fontSize, 18);
  });

  testWidgets('AnimationExtensions fade test', (WidgetTester tester) async {
    final widget = Container().fade(duration: Duration(milliseconds: 100));
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byType(AnimatedOpacity), findsOneWidget);
  });

  testWidgets('ParentExtensions parent test', (WidgetTester tester) async {
    final widget = Container().parent((child) => Container(child: child));
    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byType(Container), findsNWidgets(2));
  });

  testWidgets('SemanticsExtensions semanticsLabel test', (
    WidgetTester tester,
  ) async {
    final widget = Container().semanticsLabel('label', excludeSemantics: true);
    await tester.pumpWidget(MaterialApp(home: widget));
    final semantics = tester.ensureSemantics();
    expect(find.bySemanticsLabel('label'), findsOneWidget);
    semantics.dispose();
  });
}
