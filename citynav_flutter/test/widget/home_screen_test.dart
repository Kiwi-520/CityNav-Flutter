import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citynav/features/home/screens/home_screen.dart';
import 'package:citynav/core/theme/app_theme.dart';
import 'package:citynav/core/providers/app_providers.dart';
import 'package:citynav/core/router/app_router.dart';

void main() {
  group('HomeScreen', () {
    Future<Widget> buildWidget() async {
      SharedPreferences.setMockInitialValues({
        'user_name': 'Priya',
        'user_city': 'Mumbai',
      });
      final prefs = await SharedPreferences.getInstance();
      final router = GoRouter(
        initialLocation: AppRoutes.home,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(path: AppRoutes.search,
              builder: (_, __) => const Scaffold()),
          GoRoute(path: AppRoutes.map,
              builder: (_, __) => const Scaffold()),
          GoRoute(path: AppRoutes.routeOptions,
              builder: (_, __) => const Scaffold()),
          GoRoute(path: AppRoutes.essentialApps,
              builder: (_, __) => const Scaffold()),
          GoRoute(path: AppRoutes.notifications,
              builder: (_, __) => const Scaffold()),
          GoRoute(path: AppRoutes.profile,
              builder: (_, __) => const Scaffold()),
        ],
      );
      return ProviderScope(
        overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      );
    }

    testWidgets('renders search bar', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('Where do you want to go?'), findsOneWidget);
    });

    testWidgets('renders quick action labels', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('Maps'), findsOneWidget);
      expect(find.text('Routes'), findsOneWidget);
    });

    testWidgets('renders CityNav header', (tester) async {
      await tester.pumpWidget(await buildWidget());
      await tester.pumpAndSettle();
      expect(find.text('CityNav'), findsAtLeastNWidgets(1));
    });
  });
}