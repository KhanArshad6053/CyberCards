import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_data.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/category_card_widget.dart';
import 'flashcard_screen.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 120),
        children: [
          Text('Explore Topics', style: textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text('Build your cybersecurity knowledge one card at a time.',
              style: textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          GlassCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Overall completion', style: textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text('${(app.overallProgress * 100).round()}% complete',
                          style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.sm),
                      AppProgressBar(progress: app.overallProgress),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ...SampleData.categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: CategoryCardWidget(
                category: category,
                progress: app.progressForCategory(category.id),
                learnedCount: app.learnedForCategory(category.id),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FlashcardScreen(category: category),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
