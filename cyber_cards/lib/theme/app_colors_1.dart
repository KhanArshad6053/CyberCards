import 'package:flutter/material.dart';

/// Central color tokens for CyberCards.
/// Dark theme is the primary/first-class experience; light theme keeps the
/// same cyan/purple accent system on a bright, cool background.
class AppColors {
  AppColors._();

  // ---- Brand accents (shared across themes) ----
  static const Color primaryCyan = Color(0xFF35D6FF);
  static const Color secondaryPurple = Color(0xFF8B7CFF);
  static const Color successGreen = Color(0xFF35D07F);
  static const Color warningOrange = Color(0xFFFFB84D);
  static const Color errorRed = Color(0xFFFF5C6C);

  // ---- Dark theme ----
  static const Color darkBackground = Color(0xFF080B14);
  static const Color darkSurface = Color(0xFF10141F);
  static const Color darkGlass = Color(0x1AFFFFFF); // translucent white
  static const Color darkGlassBorder = Color(0x33FFFFFF);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA7B0C0);

  // ---- Light theme ----
  static const Color lightBackground = Color(0xFFF3F6FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightGlass = Color(0xCCFFFFFF);
  static const Color lightGlassBorder = Color(0x1A0B1220);
  static const Color lightTextPrimary = Color(0xFF0B1220);
  static const Color lightTextSecondary = Color(0xFF5C6779);

  /// Category accent colors, keyed by category id.
  static const Map<String, Color> categoryAccents = {
    'phishing': primaryCyan,
    'password_security': secondaryPurple,
    'malware': errorRed,
    'social_engineering': warningOrange,
    'online_safety': successGreen,
  };
}
