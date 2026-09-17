import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// A translucent, blurred "liquid glass" card used throughout the app.
/// Set [glow] to true for an accented neon border glow (e.g. active states).
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool glow;
  final Color? glowColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadius.large,
    this.glow = false,
    this.glowColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glass = isDark ? AppColors.darkGlass : AppColors.lightGlass;
    final border = isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder;
    final accent = glowColor ?? AppColors.primaryCyan;

    final content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: glass,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: glow ? accent.withOpacity(0.6) : border,
              width: glow ? 1.4 : 1,
            ),
            boxShadow: glow
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.35),
                      blurRadius: 24,
                      spreadRadius: -4,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: content,
      ),
    );
  }
}
