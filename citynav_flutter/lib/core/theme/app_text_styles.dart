import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle displayXl = TextStyle(
    fontFamily: 'Syne', fontSize: 32, fontWeight: FontWeight.w800,
    letterSpacing: -0.5, height: 1.2, color: AppColors.textPrimary,
  );
  static const TextStyle displayLg = TextStyle(
    fontFamily: 'Syne', fontSize: 26, fontWeight: FontWeight.w700,
    letterSpacing: -0.5, height: 1.2, color: AppColors.textPrimary,
  );
  static const TextStyle heading = TextStyle(
    fontFamily: 'Syne', fontSize: 22, fontWeight: FontWeight.w700,
    letterSpacing: -0.3, height: 1.3, color: AppColors.textPrimary,
  );
  static const TextStyle subheading = TextStyle(
    fontFamily: 'Syne', fontSize: 18, fontWeight: FontWeight.w600,
    letterSpacing: -0.2, height: 1.3, color: AppColors.textPrimary,
  );
  static const TextStyle title = TextStyle(
    fontFamily: 'Syne', fontSize: 16, fontWeight: FontWeight.w700,
    letterSpacing: -0.1, color: AppColors.textPrimary,
  );
  static const TextStyle bodyLg = TextStyle(
    fontFamily: 'DMSans', fontSize: 16, fontWeight: FontWeight.w400,
    height: 1.6, color: AppColors.textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w400,
    height: 1.5, color: AppColors.textPrimary,
  );
  static const TextStyle bodySm = TextStyle(
    fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w400,
    height: 1.5, color: AppColors.textPrimary,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w500,
    height: 1.5, color: AppColors.textPrimary,
  );
  static const TextStyle bodySemibold = TextStyle(
    fontFamily: 'DMSans', fontSize: 15, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle label = TextStyle(
    fontFamily: 'DMSans', fontSize: 11, fontWeight: FontWeight.w600,
    letterSpacing: 1.5, color: AppColors.textSecondary,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: 'DMSans', fontSize: 11, fontWeight: FontWeight.w400,
    height: 1.5, color: AppColors.textSecondary,
  );
  static const TextStyle overline = TextStyle(
    fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w700,
    letterSpacing: 1.5, color: AppColors.textSecondary,
  );
  static const TextStyle btnLabel = TextStyle(
    fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700,
    letterSpacing: 0.3, color: Colors.white,
  );
  static const TextStyle btnLabelSm = TextStyle(
    fontFamily: 'Syne', fontSize: 13, fontWeight: FontWeight.w700,
    letterSpacing: 0.3, color: Colors.white,
  );
  static const TextStyle navLabel = TextStyle(
    fontFamily: 'DMSans', fontSize: 10, fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );
  static TextStyle get bodyMuted =>
      body.copyWith(color: AppColors.textSecondary);
}