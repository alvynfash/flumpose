import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Animation Extensions', () {
    testWidgets('animate() creates AnimationConfigProvider', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().animate(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('AnimatedText widget renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AnimatedText('Hello')));

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('AnimatedText with style renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AnimatedText(
            'Hello',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('String.animatedText() creates AnimatedText', (tester) async {
      await tester.pumpWidget(MaterialApp(home: 'Hello World'.animatedText()));

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.byType(AnimatedText), findsOneWidget);
    });

    testWidgets('AnimatedText style extensions work', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: 'Hello'.animatedText().fontSize(24).color(Colors.red).bold(),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('AnimatedIconWidget renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedIconWidget(Icons.star, color: Colors.blue),
          ),
        ),
      );

      // AnimatedIconWidget should be in the tree
      expect(find.byType(AnimatedIconWidget), findsOneWidget);
    });

    testWidgets('IconData.animatedIcon() creates AnimatedIconWidget', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Icons.favorite.animatedIcon().iconColor(Colors.red),
          ),
        ),
      );

      // AnimatedIconWidget should be in the tree
      expect(find.byType(AnimatedIconWidget), findsOneWidget);
    });

    testWidgets('AnimatedIconWidget with color and size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Icons.star
                .animatedIcon()
                .iconColor(Colors.yellow)
                .iconSize(48),
          ),
        ),
      );

      // AnimatedIconWidget should be in the tree
      expect(find.byType(AnimatedIconWidget), findsOneWidget);
    });

    testWidgets('fade() creates AnimatedOpacity', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Container().fade()));

      expect(find.byType(AnimatedOpacity), findsOneWidget);
    });

    testWidgets('fade() with custom duration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().fade(duration: const Duration(seconds: 1)),
        ),
      );

      expect(find.byType(AnimatedOpacity), findsOneWidget);
    });

    testWidgets('Animated padding works with animate parameter', (
      tester,
    ) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container(color: Colors.blue)
                  .pad(10, animate: true)
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(AnimatedPadding), findsOneWidget);
    });

    testWidgets('Animated background color works with animate parameter', (
      tester,
    ) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container()
                  .backgroundColor(
                    Colors.red,
                    animate: true,
                  )
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('Animated width works with animate parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container()
              .width(100, animate: true)
              .animate(duration: const Duration(milliseconds: 300)),
        ),
      );

      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('Animated height works with animate parameter', (tester) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container()
                  .height(100, animate: true)
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('Animated alignment works with animate parameter', (
      tester,
    ) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container()
                  .align(
                    Alignment.centerLeft,
                    animate: true,
                  )
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(AnimatedAlign), findsOneWidget);
    });

    testWidgets('Animated rotate works with animate parameter', (tester) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container()
                  .rotate(0.0, animate: true)
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(TweenAnimationBuilder<double>), findsOneWidget);
    });

    testWidgets('Animated scale works with animate parameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container()
              .scaleWidget(1.0, animate: true)
              .animate(duration: const Duration(milliseconds: 300)),
        ),
      );

      expect(find.byType(TweenAnimationBuilder<double>), findsOneWidget);
    });

    testWidgets('Animated translate works with animate parameter', (
      tester,
    ) async {
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Container()
                  .translate(x: 0.0, animate: true)
                  .animate(duration: const Duration(milliseconds: 300)),
            );
          },
        ),
      );

      expect(find.byType(TweenAnimationBuilder<Offset>), findsOneWidget);
    });

    testWidgets('Multiple animations with different configs', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container()
              .pad(10, animate: true)
              .animate(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              )
              .backgroundColor(
                Colors.red,
                animate: true,
              )
              .animate(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linear,
              ),
        ),
      );

      // Should have both animated widgets
      expect(find.byType(AnimatedPadding), findsOneWidget);
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('Non-animated extensions work without animate parameter', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container()
              .pad(10) // animate: false by default
              .backgroundColor(Colors.blue) // animate: false by default
              .width(100), // animate: false by default
        ),
      );

      // Should use non-animated widgets
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('AnimationConfig equality works correctly', (tester) async {
      const config1 = AnimationConfig(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      const config2 = AnimationConfig(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      const config3 = AnimationConfig(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );

      expect(config1 == config2, isTrue);
      expect(config1 == config3, isFalse);
      expect(config1.hashCode == config2.hashCode, isTrue);
    });
  });
}
