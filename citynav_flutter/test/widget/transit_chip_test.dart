import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:citynav/shared/widgets/transit_chip.dart';
import 'package:citynav/core/theme/app_theme.dart';

void main() {
  Widget buildChip(TransitMode mode, {String? duration}) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: Center(
        child: TransitChip(mode: mode, duration: duration),
      )),
    );
  }

  group('TransitChip', () {
    testWidgets('renders Metro chip', (tester) async {
      await tester.pumpWidget(buildChip(TransitMode.metro));
      expect(find.text('Metro'), findsOneWidget);
    });

    testWidgets('renders Bus chip', (tester) async {
      await tester.pumpWidget(buildChip(TransitMode.bus));
      expect(find.text('Bus'), findsOneWidget);
    });

    testWidgets('renders Walk chip with duration', (tester) async {
      await tester.pumpWidget(buildChip(TransitMode.walk, duration: '5 min'));
      expect(find.text('Walk · 5 min'), findsOneWidget);
    });

    testWidgets('renders Auto chip', (tester) async {
      await tester.pumpWidget(buildChip(TransitMode.auto));
      expect(find.text('Auto'), findsOneWidget);
    });
  });
}