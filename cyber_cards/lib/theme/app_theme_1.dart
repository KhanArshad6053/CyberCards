import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Spacing scale (4, 8, 12, 16, 24, 32).
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Corner radius scale.
class AppRadius {
  AppRadius._();
  static const double small = 10;
  static const double medium = 16;
  static const double large = 24;
  static const double xLarge = 32;
}

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color primary, Color secondary) {
    final base = GoogleFonts.manropeTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
          color: primary, fontWeight: FontWeight.w800, fontSize: 32),
      headlineMedium: base.headlineMedium?.copyWith(
          color: primary, fontWeight: FontWeight.w800, fontSize: 24),
      titleLarge: base.titleLarge?.copyWith(
          color: primary, fontWeight: FontWeight.w700, fontSize: 18),
      titleMedium: base.titleMedium?.copyWith(
          color: primary, fontWeight: FontWeight.w600, fontSize: 16),
      bodyLarge: base.bodyLarge
          ?.copyWith(color: primary, fontSize: 15, height: 1.4),
      bodyMedium: base.bodyMedium
          ?.copyWith(color: secondary, fontSize: 14, height: 1.4),
      bodySmall: base.bodySmall?.copyWith(color: secondary, fontSize: 12),
      labelLarge: base.labelLarge
          ?.copyWith(color: primary, fontWeight: FontWeight.w700),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryCyan,
        secondary: AppColors.secondaryPurple,
        error: AppColors.errorRed,
        surface: AppColors.darkSurface,
      ),
      textTheme: _textTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary),
      splashFactory: InkRipple.splashFactory,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primaryCyan,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryCyan,
        secondary: AppColors.secondaryPurple,
        error: AppColors.errorRed,
        surface: AppColors.lightSurface,
      ),
      textTheme: _textTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
