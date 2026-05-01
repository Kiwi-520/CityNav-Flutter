import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/onboarding/screens/feature_tour_screen.dart';
import '../../features/onboarding/screens/location_permission_screen.dart';
import '../../features/onboarding/screens/setup_complete_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/verify_otp_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/map/screens/map_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/routes/screens/route_options_screen.dart';
import '../../features/routes/screens/route_navigation_screen.dart';
import '../../features/apps/screens/essential_apps_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../shared/widgets/app_shell.dart';

abstract class AppRoutes {
  static const welcome            = '/welcome';
  static const featureTour        = '/feature-tour';
  static const locationPermission = '/location-permission';
  static const setupComplete      = '/setup-complete';
  static const login              = '/login';
  static const signup             = '/signup';
  static const verifyOtp          = '/verify-otp';
  static const home               = '/home';
  static const map                = '/map';
  static const search             = '/search';
  static const routeOptions       = '/route-options';
  static const routeNavigation    = '/route-navigation';
  static const essentialApps      = '/apps';
  static const profile            = '/profile';
  static const settings           = '/settings';
  static const notifications      = '/notifications';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(path: AppRoutes.welcome,
          pageBuilder: (c, s) => _fade(const WelcomeScreen(), s)),
      GoRoute(path: AppRoutes.featureTour,
          pageBuilder: (c, s) => _slide(const FeatureTourScreen(), s)),
      GoRoute(path: AppRoutes.locationPermission,
          pageBuilder: (c, s) => _slide(const LocationPermissionScreen(), s)),
      GoRoute(path: AppRoutes.setupComplete,
          pageBuilder: (c, s) => _slide(const SetupCompleteScreen(), s)),
      GoRoute(path: AppRoutes.login,
          pageBuilder: (c, s) => _slide(const LoginScreen(), s)),
      GoRoute(path: AppRoutes.signup,
          pageBuilder: (c, s) => _slide(const SignupScreen(), s)),
      GoRoute(path: AppRoutes.verifyOtp,
          pageBuilder: (c, s) => _slide(const VerifyOtpScreen(), s)),
      GoRoute(path: AppRoutes.profile,
          pageBuilder: (c, s) => _slide(const ProfileScreen(), s)),
      GoRoute(path: AppRoutes.settings,
          pageBuilder: (c, s) => _slide(const SettingsScreen(), s)),
      GoRoute(path: AppRoutes.notifications,
          pageBuilder: (c, s) => _slide(const NotificationsScreen(), s)),
      GoRoute(path: AppRoutes.routeNavigation,
          pageBuilder: (c, s) => _slide(const RouteNavigationScreen(), s)),
      ShellRoute(
        builder: (c, s, child) => AppShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.home,
              pageBuilder: (c, s) => _fade(const HomeScreen(), s)),
          GoRoute(path: AppRoutes.map,
              pageBuilder: (c, s) => _fade(const MapScreen(), s)),
          GoRoute(path: AppRoutes.search,
              pageBuilder: (c, s) => _fade(const SearchScreen(), s)),
          GoRoute(path: AppRoutes.routeOptions,
              pageBuilder: (c, s) => _fade(const RouteOptionsScreen(), s)),
          GoRoute(path: AppRoutes.essentialApps,
              pageBuilder: (c, s) => _fade(const EssentialAppsScreen(), s)),
        ],
      ),
    ],
    errorBuilder: (c, s) =>
        Scaffold(body: Center(child: Text('Page not found: \${s.uri}'))),
  );
});

CustomTransitionPage<void> _fade(Widget w, GoRouterState s) =>
    CustomTransitionPage<void>(
      key: s.pageKey, child: w,
      transitionsBuilder: (c, a, _, ch) => FadeTransition(opacity: a, child: ch),
      transitionDuration: const Duration(milliseconds: 200),
    );

CustomTransitionPage<void> _slide(Widget w, GoRouterState s) =>
    CustomTransitionPage<void>(
      key: s.pageKey, child: w,
      transitionsBuilder: (c, a, _, ch) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: ch,
      ),
      transitionDuration: const Duration(milliseconds: 280),
    );
