import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citynav/core/providers/app_providers.dart';

void main() {
  group('App Providers', () {
    late ProviderContainer container;
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      );
    });

    tearDown(() => container.dispose());

    test('onboardingDoneProvider defaults to false', () {
      expect(container.read(onboardingDoneProvider), false);
    });

    test('selectedLanguageProvider defaults to en', () {
      expect(container.read(selectedLanguageProvider), 'en');
    });

    test('userCityProvider defaults to Mumbai', () {
      expect(container.read(userCityProvider), 'Mumbai');
    });

    test('isLoggedInProvider defaults to false', () {
      expect(container.read(isLoggedInProvider), false);
    });

    test('userNameProvider defaults to Guest', () {
      expect(container.read(userNameProvider), 'Guest');
    });

    test('LanguageNotifier can change language', () async {
      final notifier = container.read(selectedLanguageProvider.notifier);
      await notifier.setLanguage('hi');
      expect(container.read(selectedLanguageProvider), 'hi');
    });
  });
}