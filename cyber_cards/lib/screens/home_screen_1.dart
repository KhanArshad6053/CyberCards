import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/progress_ring.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/misc_cards.dart';
import '../widgets/app_buttons.dart';
import 'flashcard_screen.dart';
import 'tips_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigateToTab;

  const HomeScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final textTheme = Theme.of(context).textTheme;
    final continueCard = app.continueCard;
    final continueCategory = continueCard == null
        ? null
        : SampleData.categories.firstWhere((c) => c.id == continueCard.categoryId);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 120),
        children: [
          // ---- Header ----
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stay Secure 👋', style: textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text('Here\'s your cybersecurity learning snapshot.',
                        style: textTheme.bodyMedium),
                  ],
                ),
              ),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      colors: [AppColors.primaryCyan, AppColors.secondaryPurple]),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // ---- Overall progress card ----
          GlassCard(
            glow: true,
            child: Row(
              children: [
                ProgressRing(progress: app.overallProgress, size: 100, strokeWidth: 10),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Security Progress', style: textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.sm),
                      _MiniStat(label: 'Learned', value: '${app.learnedCount}', color: AppColors.successGreen),
                      _MiniStat(label: 'Remaining', value: '${app.remainingCount}', color: AppColors.warningOrange),
                      _MiniStat(label: 'Total', value: '${app.totalCards}', color: AppColors.primaryCyan),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ---- Continue learning ----
          if (continueCard != null && continueCategory != null) ...[
            GlassCard(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => FlashcardScreen(category: continueCategory),
              )),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Continue Learning', style: textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Text(continueCategory.name, style: textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text(
                          'Card ${app.learnedForCategory(continueCategory.id) + 1} of ${continueCategory.cardCount}',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PrimaryButton(
                          label: 'Continue',
                          icon: Icons.play_arrow_rounded,
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FlashcardScreen(category: continueCategory),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.only(left: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: continueCategory.color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(continueCategory.icon, color: continueCategory.color, size: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // ---- Quick categories ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quick Learning', style: textTheme.titleLarge),
              TextButton(
                onPressed: () => onNavigateToTab(1),
                child: const Text('See all'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: SampleData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, i) {
                final category = SampleData.categories[i];
                return CategoryCardWidget(
                  category: category,
                  compact: true,
                  progress: app.progressForCategory(category.id),
                  learnedCount: app.learnedForCategory(category.id),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FlashcardScreen(category: category),
                  )),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ---- Daily tip ----
          TipCard(
            title: 'Daily Security Tip',
            body: SampleData.dailyTip,
            icon: Icons.shield_outlined,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const TipsScreen())),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$value $label', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
