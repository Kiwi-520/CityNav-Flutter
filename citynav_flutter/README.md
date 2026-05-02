# 🧭 CityNav — Flutter MVP Phase 1

Smart city navigation app for Indian cities.
Built with Flutter · OpenStreetMap · Riverpod · GoRouter

**Design System: Indigo Metro**

---

## 📋 What's in Phase 1

| Feature | Status |
|---------|--------|
| Indigo Metro Design System | ✅ Complete |
| GoRouter navigation (all routes) | ✅ Complete |
| Onboarding (Welcome → Feature Tour → Location → Setup) | ✅ Complete |
| Auth (Login → Signup → OTP Verification) | ✅ Complete |
| Home Dashboard | ✅ Complete |
| OSM Map (flutter_map) with location | ✅ Complete |
| Search & Discovery | ✅ Complete |
| Route Options (multimodal comparison) | ✅ Complete |
| Turn-by-Turn Navigation (step-through UI) | ✅ Complete |
| Essential City Apps | ✅ Complete |
| Profile Screen | ✅ Complete |
| Settings (with toggles) | ✅ Complete |
| Notifications feed | ✅ Complete |
| Riverpod state management | ✅ Complete |
| Unit & widget tests | ✅ Complete |

---

## 🚀 Quick Start

### Prerequisites

```bash
flutter --version   # requires Flutter 3.13+
dart --version      # requires Dart 3.1+
```

### 1. Clone & Install

```bash
git clone <your-repo>
cd citynav
flutter pub get
```

### 2. Add font assets

Download from Google Fonts and place in `assets/fonts/`:
- **Syne**: Regular(400), Medium(500), SemiBold(600), Bold(700), ExtraBold(800)
- **DM Sans**: Regular(400), Medium(500), SemiBold(600)

```bash
mkdir -p assets/fonts assets/images assets/icons assets/animations
```

> **Quick alternative**: Remove the `fonts:` section from `pubspec.yaml` and
> the app will use system fonts. Add fonts before release.

### 3. Run

```bash
# Android
flutter run

# iOS (Mac only)
flutter run -d ios

# Chrome (web preview)
flutter run -d chrome
```

---

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry, provider setup
├── core/
│   ├── theme/
│   │   ├── app_colors.dart          # Full Indigo Metro color tokens
│   │   ├── app_text_styles.dart     # Syne + DM Sans typography
│   │   ├── app_theme.dart           # MaterialApp ThemeData
│   │   ├── app_spacing.dart         # Spacing, radius, shadow scales
│   │   └── theme_exports.dart       # Single barrel import
│   ├── router/
│   │   └── app_router.dart          # GoRouter config + route constants
│   ├── providers/
│   │   └── app_providers.dart       # Riverpod providers (auth, location, prefs)
│   └── constants/
│       └── app_constants.dart       # App-wide constants
├── features/
│   ├── onboarding/screens/          # Welcome, FeatureTour, LocationPerm, SetupComplete
│   ├── auth/screens/                # Login, Signup, VerifyOtp
│   ├── home/screens/                # HomeDashboard
│   ├── map/screens/                 # MapScreen (OSM)
│   ├── search/screens/              # SearchScreen
│   ├── routes/screens/              # RouteOptions, RouteNavigation
│   ├── apps/screens/                # EssentialApps
│   ├── profile/screens/             # ProfileScreen
│   ├── settings/screens/            # SettingsScreen
│   └── notifications/screens/       # NotificationsScreen
└── shared/
    └── widgets/
        ├── app_shell.dart           # Bottom navigation shell
        ├── cn_button.dart           # CnButton (primary/secondary/ghost/accent/danger)
        ├── cn_card.dart             # CnCard
        ├── cn_text_field.dart       # CnTextField with label
        ├── page_header.dart         # PageHeader with back button
        ├── loading_screen.dart      # Animated loading/splash
        └── transit_chip.dart        # Transit mode chips (metro/bus/walk/taxi/auto)
```

---

## 🧪 Running Tests

```bash
# All tests
flutter test

# Unit tests only
flutter test test/unit/

# Widget tests only
flutter test test/widget/

# With coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 🗺️ OSM Map Notes

The map uses **OpenStreetMap** via `flutter_map`. No API key needed.

Tile URL: `https://tile.openstreetmap.org/{z}/{x}/{y}.png`

**OSM Attribution required** (add to your map widget or About page):
> © OpenStreetMap contributors

For offline tile caching in Phase 2, add `flutter_map_cache` with
`dio_cache_interceptor_hive_store`.

---

## 🔑 Required Android Permissions

Already added to `AndroidManifest.xml`:
- `INTERNET` — OSM map tiles
- `ACCESS_FINE_LOCATION` — GPS
- `ACCESS_COARSE_LOCATION` — network location
- `SEND_SMS` — SOS fallback (Phase 2)
- `CALL_PHONE` — emergency dial (Phase 2)

For iOS, add to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>CityNav needs location to show routes and nearby places.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>CityNav uses background location for navigation guidance.</string>
```

---

## 🎨 Indigo Metro Design Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.primary` | `#4F46E5` | CTAs, nav active, links |
| `AppColors.primaryDark` | `#4338CA` | Button hover/pressed |
| `AppColors.primaryLight` | `#E0E7FF` | Icon backgrounds, chips |
| `AppColors.accent` | `#F59E0B` | Highlights, warnings |
| `AppColors.bg` | `#EEF2FF` | Page background |
| `AppColors.surface` | `#FFFFFF` | Cards, panels |
| `AppColors.border` | `#C7D2FE` | Card borders |
| `AppColors.textPrimary` | `#1E1B4B` | Headlines, body |
| `AppColors.textSecondary` | `#64748B` | Muted text, captions |
| `AppColors.success` | `#22C55E` | Bus, success states |
| `AppColors.danger` | `#EF4444` | SOS, errors, alerts |

---

## 🔮 Phase 2 Roadmap

- [ ] Real OSRM multimodal routing API integration
- [ ] Tile caching for offline maps (Hive store)
- [ ] Background location tracking during navigation
- [ ] SOS button with SMS fallback (telephony package)
- [ ] Safety heatmap layer on OSM
- [ ] Auto-rickshaw fare calculator (per-city meter rates)
- [ ] Crowdsourced community reports (Firebase)
- [ ] Multilingual TTS voice guidance
- [ ] Push notifications (FCM)
- [ ] Deep links for sharing routes

---

## 📄 License

MIT © CityNav 2024