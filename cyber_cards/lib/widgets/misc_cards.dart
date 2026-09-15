import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

/// Small stat tile used on the Progress screen (Learned / Still Learning /
/// Remaining / Total).
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData? icon;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg, horizontal: AppSpacing.md),
      radius: AppRadius.medium,
      child: Column(
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
          ],
          Text(value,
              style: textTheme.headlineMedium?.copyWith(color: color, fontSize: 26)),
          const SizedBox(height: 2),
          Text(label, style: textTheme.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// Security tip preview card (Home) and full tip card (Tips screen).
class TipCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  const TipCard({
    super.key,
    required this.title,
    required this.body,
    this.icon = Icons.shield_outlined,
    this.onTap,
    this.color = AppColors.primaryCyan,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GlassCard(
      onTap: onTap,
      glow: true,
      glowColor: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(body, style: textTheme.bodyMedium),
                if (onTap != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('View more',
                          style: textTheme.bodySmall?.copyWith(
                              color: color, fontWeight: FontWeight.w700)),
                      Icon(Icons.arrow_forward_rounded, size: 14, color: color),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A settings row with a label, optional subtitle, and a switch.
class ToggleRow extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleRow({
    super.key,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.bodyLarge),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(subtitle!, style: textTheme.bodySmall),
                ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryCyan,
        ),
      ],
    );
  }
}
