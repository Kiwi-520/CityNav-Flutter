import 'package:flutter/material.dart';

/// CityNav Indigo Metro — Color Tokens
abstract class AppColors {
  static const indigo50  = Color(0xFFEEF2FF);
  static const indigo100 = Color(0xFFE0E7FF);
  static const indigo200 = Color(0xFFC7D2FE);
  static const indigo300 = Color(0xFFA5B4FC);
  static const indigo400 = Color(0xFF818CF8);
  static const indigo500 = Color(0xFF6366F1);
  static const indigo600 = Color(0xFF4F46E5);
  static const indigo700 = Color(0xFF4338CA);
  static const indigo800 = Color(0xFF3730A3);
  static const indigo900 = Color(0xFF1E1B4B);
  static const indigo950 = Color(0xFF0F0D2E);

  static const amber50  = Color(0xFFFFFBEB);
  static const amber100 = Color(0xFFFEF3C7);
  static const amber500 = Color(0xFFF59E0B);
  static const amber600 = Color(0xFFD97706);
  static const amber700 = Color(0xFFB45309);

  static const red50  = Color(0xFFFEF2F2);
  static const red100 = Color(0xFFFEE2E2);
  static const red500 = Color(0xFFEF4444);
  static const red700 = Color(0xFFB91C1C);

  static const green50  = Color(0xFFF0FDF4);
  static const green100 = Color(0xFFDCFCE7);
  static const green500 = Color(0xFF22C55E);
  static const green700 = Color(0xFF15803D);

  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);

  static const transitMetro   = Color(0xFF4F46E5);
  static const transitMetroBg = Color(0xFFE0E7FF);
  static const transitBus     = Color(0xFF22C55E);
  static const transitBusBg   = Color(0xFFDCFCE7);
  static const transitWalk    = Color(0xFFF59E0B);
  static const transitWalkBg  = Color(0xFFFEF3C7);
  static const transitTaxi    = Color(0xFFEF4444);
  static const transitTaxiBg  = Color(0xFFFEE2E2);
  static const transitAuto    = Color(0xFFF97316);
  static const transitAutoBg  = Color(0xFFFFEDD5);

  static const bg             = indigo50;
  static const bgSubtle       = indigo100;
  static const surface        = Color(0xFFFFFFFF);
  static const surfaceTinted  = indigo100;
  static const surfaceOverlay = Color(0xF2FFFFFF);

  static const primary        = indigo600;
  static const primaryDark    = indigo700;
  static const primaryLight   = indigo100;
  static const primaryFg      = Color(0xFFFFFFFF);

  static const accent         = amber500;
  static const accentDark     = amber600;
  static const accentLight    = amber100;

  static const textPrimary    = indigo900;
  static const textSecondary  = slate500;
  static const textTertiary   = indigo300;
  static const textLink       = indigo600;

  static const border         = indigo200;
  static const borderSubtle   = indigo100;
  static const borderStrong   = indigo300;
  static const borderFocus    = indigo600;

  static const success        = green500;
  static const successLight   = green100;
  static const warning        = amber500;
  static const warningLight   = amber100;
  static const danger         = red500;
  static const dangerLight    = red100;

  static const shadowColor    = Color(0x1F4F46E5);
}
