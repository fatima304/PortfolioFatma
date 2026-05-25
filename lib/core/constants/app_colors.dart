import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary dark background
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF111118);
  static const Color card = Color(0xFF16161F);
  static const Color cardHover = Color(0xFF1C1C28);

  // Accent / brand
  static const Color accent = Color(0xFF06BCC1);
  static const Color accentLight = Color(0xFF08D9DF);
  static const Color accentDark = Color(0xFF059EA3);

  // Gradient
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFF6C63FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF06BCC1), Color(0xFF6C63FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF16161F), Color(0xFF1A1A26)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text
  static const Color textPrimary = Color(0xFFF0F0F3);
  static const Color textSecondary = Color(0xFFA0A0B0);
  static const Color textTertiary = Color(0xFF6B6B7B);

  // Borders & dividers
  static const Color border = Color(0xFF2A2A3A);
  static const Color borderLight = Color(0xFF3A3A4A);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);

  // Glow
  static Color accentGlow = accent.withValues(alpha: 0.15);
}
