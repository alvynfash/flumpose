import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Visibility Extensions', () {
    testWidgets('visible() wraps in Visibility widget', (tester) async {
      final widget = Container().visible(true);
      expect(widget, isA<Visibility>());
    });

    testWidgets('hide() creates invisible widget', (tester) async {
      final widget = const Text('Test').hide();
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(Visibility), findsOneWidget);
      final visibility = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibility.visible, false);
    });

    testWidgets('show() creates visible widget', (tester) async {
      final widget = const Text('Test').show();
      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('showIf() conditionally shows widget', (tester) async {
      final shown = const Text('Shown').showIf(true);
      final hidden = const Text('Hidden').showIf(false);

      await tester.pumpWidget(
        MaterialApp(home: Column(children: [shown, hidden])),
      );

      expect(find.text('Shown'), findsOneWidget);
      expect(find.text('Hidden'), findsNothing);
    });

    testWidgets('opacity() wraps in Opacity widget', (tester) async {
      final widget = const Text('Test').opacity(0.5);
      await tester.pumpWidget(MaterialApp(home: widget));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 0.5);
    });

    testWidgets('semiTransparent() sets 50% opacity', (tester) async {
      final widget = const Text('Test').semiTransparent();
      await tester.pumpWidget(MaterialApp(home: widget));

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 0.5);
    });

    testWidgets('ignorePointer() wraps in IgnorePointer', (tester) async {
      final widget = Container().ignorePointer(ignoring: true);
      expect(widget, isA<IgnorePointer>());
    });

    testWidgets('absorbPointer() wraps in AbsorbPointer', (tester) async {
      final widget = Container().absorbPointer(absorbing: true);
      expect(widget, isA<AbsorbPointer>());
    });
  });

  group('Flex Extensions', () {
    testWidgets('expanded() wraps in Expanded', (tester) async {
      final widget = Container().expanded();
      expect(widget, isA<Expanded>());
    });

    testWidgets('expanded() with flex parameter', (tester) async {
      final widget = Container().expanded(flex: 2);
      await tester.pumpWidget(MaterialApp(home: Row(children: [widget])));

      final expanded = tester.widget<Expanded>(find.byType(Expanded));
      expect(expanded.flex, 2);
    });

    testWidgets('flexible() wraps in Flexible', (tester) async {
      final widget = Container().flexible();
      expect(widget, isA<Flexible>());
    });

    testWidgets('fractionalSize() wraps in FractionallySizedBox', (
      tester,
    ) async {
      final widget = Container().fractionalSize(widthFactor: 0.5);
      expect(widget, isA<FractionallySizedBox>());
    });

    testWidgets('square() creates 1:1 aspect ratio', (tester) async {
      final widget = Container().square();
      await tester.pumpWidget(MaterialApp(home: widget));

      final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
      expect(aspectRatio.aspectRatio, 1.0);
    });

    testWidgets('aspect16x9() creates 16:9 aspect ratio', (tester) async {
      final widget = Container().aspect16x9();
      await tester.pumpWidget(MaterialApp(home: widget));

      final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
      expect(aspectRatio.aspectRatio, 16 / 9);
    });

    testWidgets('fitted() wraps in FittedBox', (tester) async {
      final widget = Container().fitted();
      expect(widget, isA<FittedBox>());
    });

    testWidgets('fitContain() uses BoxFit.contain', (tester) async {
      final widget = Container().fitContain();
      await tester.pumpWidget(MaterialApp(home: widget));

      final fittedBox = tester.widget<FittedBox>(find.byType(FittedBox));
      expect(fittedBox.fit, BoxFit.contain);
    });

    testWidgets('fitCover() uses BoxFit.cover', (tester) async {
      final widget = Container().fitCover();
      await tester.pumpWidget(MaterialApp(home: widget));

      final fittedBox = tester.widget<FittedBox>(find.byType(FittedBox));
      expect(fittedBox.fit, BoxFit.cover);
    });
  });

  group('Stack Extensions', () {
    testWidgets('positioned() wraps in Positioned', (tester) async {
      final widget = Container().positioned(left: 10, top: 20);
      expect(widget, isA<Positioned>());
    });

    testWidgets('positionedTopLeft() sets top and left', (tester) async {
      final widget = Container().positionedTopLeft(top: 5, left: 10);
      await tester.pumpWidget(MaterialApp(home: Stack(children: [widget])));

      final positioned = tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned.top, 5);
      expect(positioned.left, 10);
    });

    testWidgets('positionedFill() creates Positioned.fill', (tester) async {
      final widget = Container().positionedFill();
      await tester.pumpWidget(MaterialApp(home: Stack(children: [widget])));

      final positioned = tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned.left, 0);
      expect(positioned.top, 0);
      expect(positioned.right, 0);
      expect(positioned.bottom, 0);
    });

    testWidgets('stack() creates Stack with children', (tester) async {
      final widget = Container(
        color: Colors.red,
      ).stack(children: [Container(color: Colors.blue)]);

      await tester.pumpWidget(MaterialApp(home: widget));
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets('withOverlay() adds overlay on top', (tester) async {
      final widget = Container().withOverlay(const Text('Overlay'));
      expect(widget, isA<Stack>());
    });

    testWidgets('indexedStack() creates IndexedStack', (tester) async {
      final widgets = [Container(), Container()];
      final indexedStack = widgets.indexedStack(index: 0);
      expect(indexedStack, isA<IndexedStack>());
    });
  });

  group('Responsive Extensions', () {
    testWidgets('maxWidthBox() constrains width', (tester) async {
      final widget = Container().maxWidthBox(300);
      expect(widget, isA<Align>());
    });

    testWidgets('fillWithAspectRatio() creates AspectRatio', (tester) async {
      final widget = Container().fillWithAspectRatio(16 / 9);
      expect(widget, isA<AspectRatio>());
    });
  });

  group('Utility Extensions', () {
    testWidgets('safeArea() wraps in SafeArea', (tester) async {
      final widget = Container().safeArea();
      expect(widget, isA<SafeArea>());
    });

    testWidgets('safeTop() only applies top padding', (tester) async {
      final widget = Container().safeTop();
      await tester.pumpWidget(MaterialApp(home: widget));

      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.top, true);
      expect(safeArea.bottom, false);
      expect(safeArea.left, false);
      expect(safeArea.right, false);
    });

    testWidgets('hero() wraps in Hero', (tester) async {
      final widget = Container().hero(tag: 'test');
      expect(widget, isA<Hero>());
    });

    testWidgets('material() wraps in Material', (tester) async {
      final widget = Container().material(color: Colors.white);
      expect(widget, isA<Material>());
    });

    testWidgets('card() wraps in Card', (tester) async {
      final widget = Container().card();
      expect(widget, isA<Card>());
    });

    testWidgets('toSliverBox() creates SliverToBoxAdapter', (tester) async {
      final widget = Container().toSliverBox();
      expect(widget, isA<SliverToBoxAdapter>());
    });

    testWidgets('toSliverList() creates SliverList', (tester) async {
      final widgets = [Container(), Container()];
      final sliver = widgets.toSliverList();
      expect(sliver, isA<SliverList>());
    });

    testWidgets('toSliverGrid() creates SliverGrid', (tester) async {
      final widgets = [Container(), Container()];
      final sliver = widgets.toSliverGrid(crossAxisCount: 2);
      expect(sliver, isA<SliverGrid>());
    });

    testWidgets('scaffold() wraps in Scaffold', (tester) async {
      final widget = Container().scaffold(
        appBar: AppBar(title: const Text('Test')),
      );
      expect(widget, isA<Scaffold>());
    });

    testWidgets('rotatedBox() wraps in RotatedBox', (tester) async {
      final widget = Container().rotatedBox(1);
      expect(widget, isA<RotatedBox>());
    });
  });

  group('Advanced Gesture Extensions', () {
    testWidgets('onPan() wraps in GestureDetector', (tester) async {
      final widget = Container().onPan(onPanUpdate: (details) {});
      expect(widget, isA<GestureDetector>());
    });

    testWidgets('onHorizontalDrag() detects horizontal drags', (tester) async {
      final widget = Container().onHorizontalDrag(onUpdate: (details) {});
      expect(widget, isA<GestureDetector>());
    });

    testWidgets('onVerticalDrag() detects vertical drags', (tester) async {
      final widget = Container().onVerticalDrag(onUpdate: (details) {});
      expect(widget, isA<GestureDetector>());
    });

    testWidgets('onScale() detects scale gestures', (tester) async {
      final widget = Container().onScale(onScaleUpdate: (details) {});
      expect(widget, isA<GestureDetector>());
    });

    testWidgets('draggable() creates Draggable', (tester) async {
      final widget = Container().draggable<String>(data: 'test');
      expect(widget, isA<Draggable<String>>());
    });

    testWidgets('onTapWithPosition() provides tap location', (tester) async {
      final widget = Container().onTapWithPosition(onTapDown: (details) {});
      expect(widget, isA<GestureDetector>());
    });
  });

  group('Responsive Context Extensions', () {
    testWidgets('BuildContext extensions work correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Test screen dimension getters
              expect(context.screenWidth, greaterThan(0));
              expect(context.screenHeight, greaterThan(0));

              // Test breakpoint helpers
              expect(
                context.isMobile || context.isTablet || context.isDesktop,
                true,
              );

              // Test responsive value
              final value = context.responsiveValue(
                mobile: 'mobile',
                tablet: 'tablet',
                desktop: 'desktop',
              );
              expect(value, isA<String>());

              return Container();
            },
          ),
        ),
      );
    });
  });

  group('Breakpoint Helpers', () {
    testWidgets('Breakpoint constants are defined', (tester) async {
      expect(Breakpoint.mobile, 600);
      expect(Breakpoint.tablet, 900);
      expect(Breakpoint.desktop, 1200);
    });
  });
}
