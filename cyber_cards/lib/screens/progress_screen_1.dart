import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/progress_ring.dart';
import '../widgets/progress_bar.dart';
import '../widgets/misc_cards.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  // Sample weekly activity (cards learned per day) — wire up to real
  // history data when persistence is added.
  static const _weekly = [3, 5, 2, 6, 4, 1, 2];
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final textTheme = Theme.of(context).textTheme;
    final maxDay = _weekly.reduce((a, b) => a > b ? a : b).toDouble();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 120),
        children: [
          Text('Your Progress', style: textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xl),

          Center(
            child: ProgressRing(
              progress: app.overallProgress,
              size: 170,
              strokeWidth: 14,
              centerLabel: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${(app.overallProgress * 100).round()}%',
                      style: textTheme.headlineMedium?.copyWith(fontSize: 30)),
                  Text('Overall', style: textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.5,
            children: [
              StatCard(value: '${app.learnedCount}', label: 'Learned', color: AppColors.successGreen, icon: Icons.check_circle_outline),
              StatCard(value: '${app.stillLearningCount}', label: 'Still Learning', color: AppColors.warningOrange, icon: Icons.refresh_rounded),
              StatCard(value: '${app.remainingCount}', label: 'Remaining', color: AppColors.secondaryPurple, icon: Icons.hourglass_empty_rounded),
              StatCard(value: '${app.totalCards}', label: 'Total Cards', color: AppColors.primaryCyan, icon: Icons.style_outlined),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          Text('Category Progress', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          GlassCard(
            child: Column(
              children: SampleData.categories.map((category) {
                final progress = app.progressForCategory(category.id);
                final learned = app.learnedForCategory(category.id);
                final isLast = category == SampleData.categories.last;
                return Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
                  child: Row(
                    children: [
                      Icon(category.icon, color: category.color, size: 20),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category.name, style: textTheme.bodyLarge),
                                Text('${(progress * 100).round()}%',
                                    style: textTheme.bodySmall?.copyWith(color: category.color)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            AppProgressBar(progress: progress, color: category.color, height: 6),
                            const SizedBox(height: 2),
                            Text('$learned / ${category.cardCount} cards', style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          Text('Weekly Activity', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          GlassCard(
            child: SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_weekly.length, (i) {
                  final heightFactor = maxDay == 0 ? 0.0 : _weekly[i] / maxDay;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${_weekly[i]}', style: textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Container(
                        width: 18,
                        height: 60 * heightFactor + 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [AppColors.primaryCyan, AppColors.secondaryPurple],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(_days[i], style: textTheme.bodySmall),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          GlassCard(
            glow: true,
            glowColor: AppColors.warningOrange,
            child: Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${app.streakDays} Day Streak', style: textTheme.titleMedium),
                      Text('Keep learning to maintain your streak!', style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
