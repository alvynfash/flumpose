import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Background Extensions', () {
    group('Solid Color', () {
      testWidgets('backgroundColor() applies solid color', (tester) async {
        final widget = const Text('BG').backgroundColor(Colors.blue);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('BG'), findsOneWidget);
        expect(find.byType(Container), findsAtLeast(1));
      });

      testWidgets('backgroundColor() with red color', (tester) async {
        final widget = Container().backgroundColor(Colors.red);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(Container), findsAtLeast(1));
      });
    });

    group('Gradients', () {
      testWidgets('backgroundGradient() applies custom gradient', (
        tester,
      ) async {
        final widget = const Text('Gradient').backgroundGradient(
          const LinearGradient(colors: [Colors.red, Colors.yellow]),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Gradient'), findsOneWidget);
      });

      testWidgets('backgroundLinearGradient() creates linear gradient', (
        tester,
      ) async {
        final widget = Container().backgroundLinearGradient(
          colors: [Colors.purple, Colors.blue],
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });

      testWidgets('backgroundLinearGradient() with custom begin/end', (
        tester,
      ) async {
        final widget = Container().backgroundLinearGradient(
          colors: [Colors.red, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });

      testWidgets('backgroundRadialGradient() creates radial gradient', (
        tester,
      ) async {
        final widget = Container().backgroundRadialGradient(
          colors: [Colors.white, Colors.black],
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });

      testWidgets('backgroundRadialGradient() with custom center', (
        tester,
      ) async {
        final widget = Container().backgroundRadialGradient(
          colors: [Colors.yellow, Colors.red],
          center: Alignment.topRight,
          radius: 0.8,
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });
    });

    group('Background Image', () {
      testWidgets('backgroundImage() applies background image', (tester) async {
        // Create a simple 1x1 transparent PNG (valid image data)
        final imageData = Uint8List.fromList([
          0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
          0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR chunk
          0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1x1 size
          0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
          0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, // IDAT chunk
          0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
          0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
          0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, // IEND chunk
          0x42, 0x60, 0x82,
        ]);
        final widget = Container().backgroundImage(MemoryImage(imageData));
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });

      testWidgets('backgroundImage() with fit and alignment', (tester) async {
        // Create a simple 1x1 transparent PNG (valid image data)
        final imageData = Uint8List.fromList([
          0x89,
          0x50,
          0x4E,
          0x47,
          0x0D,
          0x0A,
          0x1A,
          0x0A,
          0x00,
          0x00,
          0x00,
          0x0D,
          0x49,
          0x48,
          0x44,
          0x52,
          0x00,
          0x00,
          0x00,
          0x01,
          0x00,
          0x00,
          0x00,
          0x01,
          0x08,
          0x06,
          0x00,
          0x00,
          0x00,
          0x1F,
          0x15,
          0xC4,
          0x89,
          0x00,
          0x00,
          0x00,
          0x0A,
          0x49,
          0x44,
          0x41,
          0x54,
          0x78,
          0x9C,
          0x63,
          0x00,
          0x01,
          0x00,
          0x00,
          0x05,
          0x00,
          0x01,
          0x0D,
          0x0A,
          0x2D,
          0xB4,
          0x00,
          0x00,
          0x00,
          0x00,
          0x49,
          0x45,
          0x4E,
          0x44,
          0xAE,
          0x42,
          0x60,
          0x82,
        ]);
        final widget = Container().backgroundImage(
          MemoryImage(imageData),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });
    });

    group('Custom Decoration', () {
      testWidgets('decorated() applies custom BoxDecoration', (tester) async {
        final widget = Container().decorated(
          const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.byType(DecoratedBox), findsOneWidget);
      });
    });

    group('Chaining', () {
      testWidgets('multiple background extensions chain correctly', (
        tester,
      ) async {
        final widget = const Text('Test').backgroundColor(Colors.blue).pad(16);
        await tester.pumpWidget(MaterialApp(home: widget));
        expect(find.text('Test'), findsOneWidget);
      });
    });
  });
}
