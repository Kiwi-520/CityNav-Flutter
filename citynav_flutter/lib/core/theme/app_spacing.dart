import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const double s1  = 4;
  static const double s2  = 8;
  static const double s3  = 12;
  static const double s4  = 16;
  static const double s5  = 20;
  static const double s6  = 24;
  static const double s8  = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s16 = 64;
  static const double pagePadding = 20;
}

abstract class AppRadius {
  static const double sm   = 8;
  static const double md   = 12;
  static const double lg   = 16;
  static const double xl   = 20;
  static const double xxl  = 24;
  static const double xxxl = 32;
  static const double pill = 999;
}

abstract class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(offset: Offset(0, 4), blurRadius: 16, color: Color(0x1F4F46E5)),
  ];
  static const List<BoxShadow> cardLg = [
    BoxShadow(offset: Offset(0, 8), blurRadius: 28, color: Color(0x284F46E5)),
  ];
  static const List<BoxShadow> nav = [
    BoxShadow(offset: Offset(0, -2), blurRadius: 20, color: Color(0x1A4F46E5)),
  ];
  static const List<BoxShadow> focus = [
    BoxShadow(blurRadius: 0, spreadRadius: 3, color: Color(0x404F46E5)),
  ];
}