import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  testWidgets('Text extension chain works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Test').pad(8).backgroundColor(Colors.red).alignCenter(),
      ),
    );
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('Padding extension works with double', (tester) async {
    await tester.pumpWidget(MaterialApp(home: const Text('Pad').pad(12)));
    expect(find.text('Pad'), findsOneWidget);
  });

  testWidgets('Padding extension works with EdgeInsets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: const Text('Pad').padding(const EdgeInsets.all(12))),
    );
    expect(find.text('Pad'), findsOneWidget);
  });

  testWidgets('Margin extension works with double', (tester) async {
    await tester.pumpWidget(MaterialApp(home: const Text('Margin').margin(16)));
    expect(find.text('Margin'), findsOneWidget);
  });

  testWidgets('Margin extension works with EdgeInsets', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const Text(
          'Margin',
        ).marginAll(const EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
    expect(find.text('Margin'), findsOneWidget);
  });

  testWidgets('Alignment extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('Align').alignBottomRight()),
    );
    expect(find.text('Align'), findsOneWidget);
  });

  testWidgets('Background color extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('BG').backgroundColor(Colors.blue)),
    );
    expect(find.text('BG'), findsOneWidget);
  });

  testWidgets('Background gradient extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Gradient').backgroundGradient(
          LinearGradient(colors: [Colors.red, Colors.yellow]),
        ),
      ),
    );
    expect(find.text('Gradient'), findsOneWidget);
  });

  testWidgets('Border extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Border').border(Border.all(color: Colors.green, width: 2)),
      ),
    );
    expect(find.text('Border'), findsOneWidget);
  });

  testWidgets('BorderRadius extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('Radius').borderRadius(BorderRadius.circular(20))),
    );
    expect(find.text('Radius'), findsOneWidget);
  });

  testWidgets('ClipRRect extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('ClipRRect').clipRRect(BorderRadius.circular(12))),
    );
    expect(find.text('ClipRRect'), findsOneWidget);
  });

  testWidgets('ClipOval extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('ClipOval').clipOval()));
    expect(find.text('ClipOval'), findsOneWidget);
  });

  testWidgets('onTap extension works', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Tap').onTap(() {
          tapped = true;
        }),
      ),
    );
    await tester.tap(find.text('Tap'));
    expect(tapped, isTrue);
  });

  testWidgets('Ripple extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('Ripple').ripple(() {})));
    expect(find.text('Ripple'), findsOneWidget);
  });

  testWidgets('Rotate extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('Rotate').rotate(0.5)));
    expect(find.text('Rotate'), findsOneWidget);
  });

  testWidgets('Scale extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('Scale').scaleWidget(1.5)));
    expect(find.text('Scale'), findsOneWidget);
  });

  testWidgets('Translate extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('Translate').translate(x: 10, y: 10)),
    );
    expect(find.text('Translate'), findsOneWidget);
  });

  testWidgets('fontSize extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('FontSize').fontSize(30)));
    expect(find.text('FontSize'), findsOneWidget);
  });

  testWidgets('color extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('Color').color(Colors.purple)),
    );
    expect(find.text('Color'), findsOneWidget);
  });

  testWidgets('bold extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('Bold').bold()));
    expect(find.text('Bold'), findsOneWidget);
  });

  testWidgets('italic extension works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Text('Italic').italic()));
    expect(find.text('Italic'), findsOneWidget);
  });

  testWidgets('textColor extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Text('TextColor').textColor(Colors.orange)),
    );
    expect(find.text('TextColor'), findsOneWidget);
  });

  testWidgets('Fade extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Fade').fade(duration: const Duration(milliseconds: 200)),
      ),
    );
    expect(find.text('Fade'), findsOneWidget);
  });

  testWidgets('Parent extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Text('Parent').parent((child) => Container(child: child)),
      ),
    );
    expect(find.text('Parent'), findsOneWidget);
  });

  testWidgets('SemanticsLabel extension works', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SemanticsExtensions(
          const Text('Semantics'),
        ).semanticsLabel('label', excludeSemantics: true),
      ),
    );
    final semantics = tester.ensureSemantics();
    expect(find.text('Semantics'), findsOneWidget);
    expect(find.bySemanticsLabel('label'), findsOneWidget);
    semantics.dispose();
  });
}
