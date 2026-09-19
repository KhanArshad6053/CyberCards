import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/misc_cards.dart';

class _TipTopic {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;

  const _TipTopic(this.title, this.icon, this.color, this.points);
}

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const _topics = [
    _TipTopic('Passwords', Icons.lock_outline, AppColors.secondaryPurple, [
      'Use strong, unique passwords for every account.',
      "Don't reuse passwords across sites.",
      'Use a password manager to generate and store them.',
    ]),
    _TipTopic('Phishing', Icons.email_outlined, AppColors.primaryCyan, [
      'Check sender addresses carefully.',
      'Verify suspicious links before clicking.',
      "Don't share OTPs with anyone.",
    ]),
    _TipTopic('Social Media', Icons.groups_outlined, AppColors.warningOrange, [
      'Review your privacy settings regularly.',
      "Don't overshare personal information.",
      'Be careful accepting requests from unknown accounts.',
    ]),
    _TipTopic('Public Wi-Fi', Icons.wifi, AppColors.errorRed, [
      'Avoid sensitive transactions on unsecured networks.',
      'Verify network names before connecting.',
      'Use a secure (VPN) connection when possible.',
    ]),
    _TipTopic('Devices', Icons.smartphone_outlined, AppColors.successGreen, [
      'Keep your software and OS updated.',
      'Use screen locks (PIN, biometric, pattern).',
      'Install apps only from trusted sources.',
    ]),
    _TipTopic('Accounts', Icons.verified_user_outlined, AppColors.primaryCyan, [
      'Enable two-factor authentication (2FA).',
      'Review login activity periodically.',
      'Remove access for unknown or old devices.',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Security Tips')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl),
          children: [
            Text('Simple habits that keep you safer online.', style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.lg),
            ..._topics.map((topic) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: TipCard(
                    title: topic.title,
                    body: topic.points.first,
                    icon: topic.icon,
                    color: topic.color,
                    onTap: () => _showDetail(context, topic),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context, _TipTopic topic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xLarge)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(topic.icon, color: topic.color),
                  const SizedBox(width: AppSpacing.md),
                  Text(topic.title, style: textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              ...topic.points.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, color: topic.color, size: 18),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: Text(p, style: textTheme.bodyLarge)),
                      ],
                    ),
                  )),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }
}
