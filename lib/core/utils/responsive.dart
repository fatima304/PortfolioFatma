import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= AppSpacing.desktopBreakpoint) return DeviceType.desktop;
    if (width >= AppSpacing.tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  @override
  Widget build(BuildContext context) {
    final type = getDeviceType(context);
    switch (type) {
      case DeviceType.desktop:
        return desktop;
      case DeviceType.tablet:
        return tablet ?? desktop;
      case DeviceType.mobile:
        return mobile;
    }
  }
}
