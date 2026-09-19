import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/misc_cards.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 120),
        children: [
          Text('Settings', style: textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xl),

          _SectionLabel('Appearance'),
          GlassCard(
            child: ToggleRow(
              label: 'Dark Mode',
              subtitle: 'Use the dark, neon cyber theme',
              value: app.themeMode == ThemeMode.dark,
              onChanged: app.toggleThemeMode,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          _SectionLabel('Learning'),
          GlassCard(
            child: Column(
              children: [
                ToggleRow(
                  label: 'Daily Reminders',
                  subtitle: 'Get a nudge to keep your streak going',
                  value: app.dailyRemindersEnabled,
                  onChanged: app.setDailyReminders,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Divider(height: 1),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Daily Goal', style: textTheme.bodyLarge),
                          Text('${app.dailyGoal} cards / day', style: textTheme.bodySmall),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: app.dailyGoal > 1
                          ? () => app.setDailyGoal(app.dailyGoal - 1)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => app.setDailyGoal(app.dailyGoal + 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          _SectionLabel('Progress'),
          GlassCard(
            child: Row(
              children: [
                const Icon(Icons.restart_alt_rounded, color: AppColors.errorRed),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reset Progress', style: textTheme.bodyLarge),
                      Text('Erase all learning progress', style: textTheme.bodySmall),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _confirmReset(context, app),
                  child: const Text('Reset', style: TextStyle(color: AppColors.errorRed)),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          _SectionLabel('About'),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About CyberCards', style: textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  'CyberCards helps you learn cybersecurity fundamentals through short, '
                  'interactive flashcards — phishing, password security, malware, social '
                  'engineering, and everyday online safety.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Version 1.0.0', style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, AppState app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.large)),
        title: const Text('Reset Progress?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This will erase your learning progress and cannot be undone.',
          style: TextStyle(color: AppColors.darkTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              app.resetProgress();
              Navigator.of(context).pop();
            },
            child: const Text('Reset', style: TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm, left: 4),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.w700),
      ),
    );
  }
}
