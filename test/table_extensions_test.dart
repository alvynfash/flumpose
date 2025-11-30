import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flumpose/flumpose.dart';

void main() {
  group('Table Extensions', () {
    testWidgets('toTable() creates Table widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [
            [const Text('A'), const Text('B')],
            [const Text('C'), const Text('D')],
          ].toTable(),
        ),
      );
      expect(find.byType(Table), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
    });

    testWidgets('toBorderedTable() creates Table with borders', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: [
            [const Text('1'), const Text('2')],
            [const Text('3'), const Text('4')],
          ].toBorderedTable(),
        ),
      );
      expect(find.byType(Table), findsOneWidget);
    });

    testWidgets('listTile() wraps in ListTile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('Title').listTile(
              leading: const Icon(Icons.star),
              trailing: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('withDivider() adds divider', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const Text('Item').withDivider()),
      );
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('withDividers() inserts dividers between items', (
      tester,
    ) async {
      final widgets = [
        const Text('A'),
        const Text('B'),
        const Text('C'),
      ].withDividers();

      await tester.pumpWidget(MaterialApp(home: Column(children: widgets)));
      expect(find.byType(Divider), findsNWidgets(2)); // n-1 dividers
    });

    testWidgets('separated() inserts custom separator', (tester) async {
      final widgets = [
        const Text('A'),
        const Text('B'),
      ].separated(const SizedBox(height: 16));

      await tester.pumpWidget(MaterialApp(home: Column(children: widgets)));
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
