import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum ButtonState { normal, disabled, success, warning }

/// Solid gradient button — the app's primary call-to-action.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonState state;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.state = ButtonState.normal,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = state == ButtonState.disabled || onPressed == null;

    List<Color> gradientColors;
    switch (state) {
      case ButtonState.success:
        gradientColors = [AppColors.successGreen, AppColors.successGreen.withOpacity(0.8)];
        break;
      case ButtonState.warning:
        gradientColors = [AppColors.warningOrange, AppColors.warningOrange.withOpacity(0.8)];
        break;
      case ButtonState.disabled:
        gradientColors = [Colors.grey.shade600, Colors.grey.shade700];
        break;
      case ButtonState.normal:
        gradientColors = [AppColors.primaryCyan, AppColors.secondaryPurple];
    }

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          onTap: disabled ? null : onPressed,
          child: Ink(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl, vertical: AppSpacing.md + 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(AppRadius.medium),
              boxShadow: disabled
                  ? []
                  : [
                      BoxShadow(
                        color: gradientColors.first.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: Colors.white),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Outlined / glass secondary button — for less prominent actions.
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? accentColor;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = accentColor ?? AppColors.primaryCyan;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.md + 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(color: accent.withOpacity(0.6), width: 1.2),
            color: accent.withOpacity(0.08),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: textColor),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact circular icon button used in top bars.
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const AppIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? AppColors.darkGlass : AppColors.lightGlass,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon,
              size: 20,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
        ),
      ),
    );
  }
}
