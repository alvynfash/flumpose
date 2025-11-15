import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Context Extensions', () {
    testWidgets('Screen size extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.width, greaterThan(0));
      expect(capturedContext.height, greaterThan(0));
      expect(capturedContext.screenSize, isA<Size>());
      expect(capturedContext.shortestSide, greaterThan(0));
      expect(capturedContext.longestSide, greaterThan(0));
    });

    testWidgets('Screen width and height work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.screenWidth, greaterThan(0));
      expect(capturedContext.screenHeight, greaterThan(0));
      expect(capturedContext.screenWidth, equals(capturedContext.width));
      expect(capturedContext.screenHeight, equals(capturedContext.height));
    });

    testWidgets('Orientation extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.orientation, isA<Orientation>());
      expect(capturedContext.isPortrait || capturedContext.isLandscape, isTrue);
    });

    testWidgets('Responsive helpers work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      // At least one should be true
      expect(
        capturedContext.isMobile ||
            capturedContext.isTablet ||
            capturedContext.isDesktop,
        isTrue,
      );
    });

    testWidgets('responsiveValue returns correct value', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      final value = capturedContext.responsiveValue(
        mobile: 'mobile',
        tablet: 'tablet',
        desktop: 'desktop',
      );

      expect(value, isIn(['mobile', 'tablet', 'desktop']));
    });

    testWidgets('Theme extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.theme, isA<ThemeData>());
      expect(capturedContext.colorScheme, isA<ColorScheme>());
      expect(capturedContext.textTheme, isA<TextTheme>());
      expect(capturedContext.primaryColor, isA<Color>());
      expect(capturedContext.secondaryColor, isA<Color>());
      expect(capturedContext.backgroundColor, isA<Color>());
      expect(capturedContext.surfaceColor, isA<Color>());
      expect(capturedContext.errorColor, isA<Color>());
    });

    testWidgets('Text style extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      // Display styles
      expect(capturedContext.displayLarge, isA<TextStyle?>());
      expect(capturedContext.displayMedium, isA<TextStyle?>());
      expect(capturedContext.displaySmall, isA<TextStyle?>());

      // Headline styles
      expect(capturedContext.headlineLarge, isA<TextStyle?>());
      expect(capturedContext.headlineMedium, isA<TextStyle?>());
      expect(capturedContext.headlineSmall, isA<TextStyle?>());

      // Title styles
      expect(capturedContext.titleLarge, isA<TextStyle?>());
      expect(capturedContext.titleMedium, isA<TextStyle?>());
      expect(capturedContext.titleSmall, isA<TextStyle?>());

      // Body styles
      expect(capturedContext.bodyLarge, isA<TextStyle?>());
      expect(capturedContext.bodyMedium, isA<TextStyle?>());
      expect(capturedContext.bodySmall, isA<TextStyle?>());

      // Label styles
      expect(capturedContext.labelLarge, isA<TextStyle?>());
      expect(capturedContext.labelMedium, isA<TextStyle?>());
      expect(capturedContext.labelSmall, isA<TextStyle?>());
    });

    testWidgets('Brightness extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.platformBrightness, isA<Brightness>());
      expect(capturedContext.isDarkMode || capturedContext.isLightMode, isTrue);
    });

    testWidgets('MediaQuery extensions work correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.padding, isA<EdgeInsets>());
      expect(capturedContext.viewInsets, isA<EdgeInsets>());
      expect(capturedContext.viewPadding, isA<EdgeInsets>());
      expect(capturedContext.devicePixelRatio, greaterThan(0));
      expect(capturedContext.textScaler, isA<TextScaler>());
    });

    testWidgets('unfocus works correctly', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return TextField(
                  focusNode: focusNode,
                  onTap: () => context.unfocus(),
                );
              },
            ),
          ),
        ),
      );

      // Request focus
      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      // Tap to unfocus
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Focus should be removed
      expect(focusNode.hasFocus, isFalse);

      focusNode.dispose();
    });

    testWidgets('showSnackBar works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.showSnackBar('Test message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('showBottomSheet works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.showBottomSheet(
                      builder: (ctx) => const Text('Bottom Sheet'),
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Bottom Sheet'), findsOneWidget);
    });

    testWidgets('showMaterialDialog works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.showMaterialDialog(
                      builder: (ctx) =>
                          const AlertDialog(title: Text('Dialog')),
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog'), findsOneWidget);
    });

    testWidgets('mounted check works correctly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(capturedContext.mounted, isTrue);
    });
  });
}
