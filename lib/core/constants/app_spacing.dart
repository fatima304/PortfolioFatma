import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double section = 80;
  static const double sectionLarge = 120;

  static const double maxContentWidth = 1200;
  static const double navbarHeight = 70;

  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: section,
  );

  static const EdgeInsets sectionPaddingMobile = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xxl,
  );

  static const double desktopBreakpoint = 1024;
  static const double tabletBreakpoint = 768;
  static const double mobileBreakpoint = 480;
}
