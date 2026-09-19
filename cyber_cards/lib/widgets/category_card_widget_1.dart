import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';
import 'progress_bar.dart';
import 'app_buttons.dart';

/// Large category card used on the Topics screen (description + progress
/// bar + Start/Continue button). Pass [compact] for the smaller Home
/// screen quick-category variant.
class CategoryCardWidget extends StatelessWidget {
  final CategoryModel category;
  final double progress;
  final int learnedCount;
  final VoidCallback onTap;
  final bool compact;

  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.progress,
    required this.learnedCount,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final started = learnedCount > 0;

    if (compact) {
      return GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(AppSpacing.md),
        radius: AppRadius.medium,
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBadge(color: category.color, icon: category.icon),
              const SizedBox(height: AppSpacing.sm),
              Text(category.name, style: textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text('${category.cardCount} cards', style: textTheme.bodySmall),
              const SizedBox(height: AppSpacing.sm),
              AppProgressBar(progress: progress, color: category.color, height: 6),
            ],
          ),
        ),
      );
    }

    return GlassCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBadge(color: category.color, icon: category.icon, size: 52),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(category.name, style: textTheme.titleLarge)),
                    Text('${(progress * 100).round()}%',
                        style: textTheme.titleMedium?.copyWith(color: category.color)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(category.description, style: textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.md),
                AppProgressBar(progress: progress, color: category.color),
                const SizedBox(height: 4),
                Text('$learnedCount / ${category.cardCount} cards', style: textTheme.bodySmall),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  label: started ? 'Continue' : 'Start',
                  accentColor: category.color,
                  icon: started ? Icons.play_arrow_rounded : Icons.flag_outlined,
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;

  const _IconBadge({required this.color, required this.icon, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
