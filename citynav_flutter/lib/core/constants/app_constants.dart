abstract class AppConstants {
  static const String appName     = 'CityNav';
  static const String appVersion  = '1.0.0';
  static const String appTagline  = 'Navigate smarter, live better';

  static const List<String> supportedCities = [
    'Mumbai', 'Pune', 'Delhi', 'Bengaluru',
    'Chennai', 'Hyderabad', 'Kolkata', 'Ahmedabad',
  ];

  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'hi': 'हिंदी',
    'mr': 'मराठी',
    'ta': 'தமிழ்',
  };

  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  static const double defaultLat  = 19.0760;
  static const double defaultLng  = 72.8777;
  static const double defaultZoom = 12.0;

  static const String keyOnboardingDone = 'onboarding_complete';
  static const String keyUserCity       = 'user_city';
  static const String keyUserLat        = 'user_lat';
  static const String keyUserLng        = 'user_lng';
  static const String keySelectedLang   = 'selected_language';
  static const String keyAuthToken      = 'auth_token';
  static const String keyUserName       = 'user_name';
  static const String keyUserEmail      = 'user_email';
  static const String keyRecentSearches = 'recent_searches';

  static const double navBarHeight = 72.0;
}
