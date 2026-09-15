import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_buttons.dart';
import 'flashcard_screen.dart';

class CompletionScreen extends StatelessWidget {
  final CategoryModel category;

  const CompletionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final textTheme = Theme.of(context).textTheme;
    final learned = app.learnedForCategory(category.id);
    final total = app.cardsFor(category.id).length;
    final percent = total == 0 ? 0 : ((learned / total) * 100).round();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      colors: [AppColors.successGreen, AppColors.primaryCyan]),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.successGreen.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 4),
                  ],
                ),
                child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 54),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Topic Completed!', style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text('Great job! 🎉', style: textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'You completed all ${category.name} cards.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('$percent% • $learned / $total cards learned',
                  style: textTheme.titleMedium?.copyWith(color: AppColors.primaryCyan)),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Review Again',
                icon: Icons.refresh_rounded,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => FlashcardScreen(category: category),
                  ));
                },
              ),
              const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                label: 'Explore More Topics',
                icon: Icons.explore_outlined,
                onPressed: () => Navigator.of(context)
                    .popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
