import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Thin animated linear progress bar with a gradient fill.
class AppProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double height;
  final Color? color;

  const AppProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor =
        isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06);
    final fillColor = color ?? AppColors.primaryCyan;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: trackColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress.clamp(0, 1)),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fillColor, fillColor.withOpacity(0.6)],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
