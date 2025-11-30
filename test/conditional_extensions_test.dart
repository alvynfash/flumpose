import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Conditional Extensions', () {
    testWidgets('when() applies transformation when condition is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().width(100).when(true, (w) => w.height(200)),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('when() skips transformation when condition is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Container().width(100).when(false, (w) => w.height(200)),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('conditional() applies onTrue when condition is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Text('Test').conditional(
            true,
            onTrue: (w) => w.hide(),
            onFalse: (w) => w.show(),
          ),
        ),
      );
      expect(find.byType(Visibility), findsOneWidget);
    });

    testWidgets('conditional() applies onFalse when condition is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Text('Test').conditional(
            false,
            onTrue: (w) => w.hide(),
            onFalse: (w) => w.backgroundColor(Colors.blue),
          ),
        ),
      );
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('loadingState() shows loading widget when isLoading is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const Text('Content').loadingState(isLoading: true)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Content'), findsNothing);
    });

    testWidgets('loadingState() shows content when isLoading is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const Text('Content').loadingState(isLoading: false)),
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('errorState() shows error widget when hasError is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Text(
            'Content',
          ).errorState(hasError: true, errorMessage: 'Error occurred'),
        ),
      );
      expect(find.text('Error occurred'), findsOneWidget);
      expect(find.text('Content'), findsNothing);
    });

    testWidgets('emptyState() shows empty widget when isEmpty is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Text(
            'Content',
          ).emptyState(isEmpty: true, emptyMessage: 'No data'),
        ),
      );
      expect(find.text('No data'), findsOneWidget);
      expect(find.text('Content'), findsNothing);
    });

    testWidgets('switchState() switches between states', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Text('Content').switchState(
            state: 'loading',
            cases: {
              'loading': (w) => const CircularProgressIndicator(),
              'error': (w) => const Text('Error'),
            },
            defaultCase: (w) => w,
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
