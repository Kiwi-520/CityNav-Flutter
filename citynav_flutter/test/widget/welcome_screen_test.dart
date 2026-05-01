import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citynav/features/onboarding/screens/welcome_screen.dart';
import 'package:citynav/core/theme/app_theme.dart';
import 'package:citynav/core/providers/app_providers.dart';

void main() {
  group('WelcomeScreen', () {
    Future<Widget> buildWidget() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      return ProviderScope(
        overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const WelcomeScreen(),
        ),
      );
    }

    testWidgets('renders CityNav logo', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pump();
      expect(find.text('CityNav'), findsAtLeastNWidgets(1));
    });

    testWidgets('renders Get Started button', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pump();
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('renders language options', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pump();
      expect(find.text('English'), findsOneWidget);
      expect(find.text('हिंदी'), findsOneWidget);
      expect(find.text('मराठी'), findsOneWidget);
    });

    testWidgets('language selection changes state', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pump();
      await tester.tap(find.text('हिंदी'));
      await tester.pump();
      // verify it doesn't crash
      expect(find.text('हिंदी'), findsOneWidget);
    });
  });
}