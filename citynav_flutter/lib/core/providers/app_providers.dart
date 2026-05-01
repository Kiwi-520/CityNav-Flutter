import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import '../constants/app_constants.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize in main.dart with override');
});

final onboardingDoneProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return prefs.getBool(AppConstants.keyOnboardingDone) ?? false;
});

final selectedLanguageProvider =
    StateNotifierProvider<LanguageNotifier, String>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return LanguageNotifier(prefs);
});

class LanguageNotifier extends StateNotifier<String> {
  final SharedPreferences _prefs;
  LanguageNotifier(this._prefs)
      : super(_prefs.getString(AppConstants.keySelectedLang) ?? 'en');

  Future<void> setLanguage(String code) async {
    state = code;
    await _prefs.setString(AppConstants.keySelectedLang, code);
  }
}

final userLocationProvider =
    StateNotifierProvider<LocationNotifier, AsyncValue<Position?>>(
  (ref) => LocationNotifier(),
);

class LocationNotifier extends StateNotifier<AsyncValue<Position?>> {
  LocationNotifier() : super(const AsyncValue.data(null));

  Future<void> fetchLocation() async {
    state = const AsyncValue.loading();
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) { state = const AsyncValue.data(null); return; }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = const AsyncValue.data(null); return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        state = const AsyncValue.data(null); return;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      state = AsyncValue.data(position);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final userCityProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return prefs.getString(AppConstants.keyUserCity) ?? 'Mumbai';
});

final isLoggedInProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return prefs.getString(AppConstants.keyAuthToken) != null;
});

final userNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return prefs.getString(AppConstants.keyUserName) ?? 'Guest';
});