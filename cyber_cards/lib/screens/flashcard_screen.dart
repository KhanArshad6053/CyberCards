import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../models/category_model.dart';
import '../models/flashcard_model.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/app_buttons.dart';
import 'completion_screen.dart';

class FlashcardScreen extends StatefulWidget {
  final CategoryModel category;

  const FlashcardScreen({
    super.key,
    required this.category,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;

  int _index = 0;
  bool _revealed = false;
  int? _selectedOption;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  List<FlashCardModel> _cards(AppState app) {
    return app.cardsFor(widget.category.id);
  }

  void _reveal() {
    if (_revealed) return;

    setState(() {
      _revealed = true;
    });

    _flipController.forward();
  }

  void _selectOption(int i, FlashCardModel card) {
    if (_revealed) return;

    setState(() {
      _selectedOption = i;
      _revealed = true;
    });
  }

  void _next(
    AppState app,
    List<FlashCardModel> cards,
  ) {
    if (_index + 1 >= cards.length) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => CompletionScreen(
            category: widget.category,
          ),
        ),
      );
      return;
    }

    setState(() {
      _index++;
      _revealed = false;
      _selectedOption = null;
      _flipController.reset();
    });
  }

  void _previous() {
    if (_index == 0) return;

    setState(() {
      _index--;
      _revealed = false;
      _selectedOption = null;
      _flipController.reset();
    });
  }

  void _markKnown(
    AppState app,
    FlashCardModel card,
  ) {
    app.markKnown(card);
    _next(app, _cards(app));
  }

  void _markStillLearning(
    AppState app,
    FlashCardModel card,
  ) {
    app.markStillLearning(card);
    _next(app, _cards(app));
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final cards = _cards(app);

    if (cards.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No cards in this category yet.'),
        ),
      );
    }

    final card = cards[_index.clamp(0, cards.length - 1)];
    final textTheme = Theme.of(context).textTheme;
    final accent = widget.category.color;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;

            if (velocity < -200 && _revealed) {
              _next(app, cards);
            } else if (velocity > 200) {
              _previous();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                // ---------------- TOP BAR ----------------
                Row(
                  children: [
                    AppIconButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.category.name,
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            '${_index + 1} / ${cards.length}',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 46),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // ---------------- PROGRESS BAR ----------------
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_index + 1) / cards.length,
                    minHeight: 5,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    valueColor: AlwaysStoppedAnimation(accent),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // ---------------- CARD ----------------
                Expanded(
                  child: card.options != null
                      ? _QuizCardBody(
                          card: card,
                          accent: accent,
                          revealed: _revealed,
                          selectedOption: _selectedOption,
                          onSelect: (i) => _selectOption(i, card),
                        )
                      : _FlipCardBody(
                          card: card,
                          accent: accent,
                          controller: _flipController,
                          revealed: _revealed,
                          onTap: _reveal,
                        ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ---------------- ACTION BUTTONS ----------------
                if (_revealed)
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          label: 'Still Learning',
                          icon: Icons.refresh_rounded,
                          accentColor: AppColors.warningOrange,
                          onPressed: () {
                            _markStillLearning(app, card);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: PrimaryButton(
                          label: 'I Know This',
                          icon: Icons.check_rounded,
                          state: ButtonState.success,
                          onPressed: () {
                            _markKnown(app, card);
                          },
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    card.options != null
                        ? 'Choose an answer above'
                        : 'Tap the card to reveal the answer',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// FLIP CARD
// ============================================================

class _FlipCardBody extends StatelessWidget {
  final FlashCardModel card;
  final Color accent;
  final AnimationController controller;
  final bool revealed;
  final VoidCallback onTap;

  const _FlipCardBody({
    required this.card,
    required this.accent,
    required this.controller,
    required this.revealed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final angle = controller.value * math.pi;

          if (angle < math.pi / 2) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(angle),
              child: _buildFront(context),
            );
          }

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(angle - math.pi),
            child: _buildBack(context),
          );
        },
      ),
    );
  }

  // ==========================================================
  // FRONT
  // ==========================================================

  Widget _buildFront(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      glow: true,
      glowColor: accent,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SizedBox(
        width: double.infinity,
        height: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.security_rounded,
                color: accent,
                size: 30,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              card.question,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.darkTextPrimary,
              ),
            ),
            const Spacer(),
            Text(
              'Tap to reveal answer',
              style: textTheme.bodySmall?.copyWith(
                color: accent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // BACK
  // ==========================================================

  Widget _buildBack(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      glow: true,
      glowColor: AppColors.successGreen,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SizedBox(
        width: double.infinity,
        height: 380,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ANSWER',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.successGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                card.answer,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkTextPrimary,
                ),
              ),
              if (card.example != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'EXAMPLE',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card.example!,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.darkTextPrimary,
                  ),
                ),
              ],
              if (card.tip != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'TIP',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryCyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card.tip!,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.darkTextPrimary,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Text(
                  'Tap to flip back',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.darkTextSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// QUIZ CARD
// ============================================================

class _QuizCardBody extends StatelessWidget {
  final FlashCardModel card;
  final Color accent;
  final bool revealed;
  final int? selectedOption;
  final ValueChanged<int> onSelect;

  const _QuizCardBody({
    required this.card,
    required this.accent,
    required this.revealed,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final options = card.options!;
    final correctIndex = card.correctOptionIndex ?? 0;
    final isCorrect = selectedOption == correctIndex;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassCard(
            glow: revealed,
            glowColor: revealed
                ? (isCorrect ? AppColors.successGreen : AppColors.errorRed)
                : accent,
            child: Text(
              card.question,
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.darkTextPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...List.generate(options.length, (i) {
            final isSelected = selectedOption == i;
            final isRight = i == correctIndex;

            Color? borderColor;
            Color? backgroundColor;

            if (revealed) {
              if (isRight) {
                borderColor = AppColors.successGreen;
                backgroundColor = AppColors.successGreen.withOpacity(0.12);
              } else if (isSelected) {
                borderColor = AppColors.errorRed;
                backgroundColor = AppColors.errorRed.withOpacity(0.12);
              }
            }

            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.md,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  AppRadius.medium,
                ),
                onTap: () => onSelect(i),
                child: Container(
                  padding: const EdgeInsets.all(
                    AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppRadius.medium,
                    ),
                    border: Border.all(
                      color: borderColor ?? Colors.white.withOpacity(0.15),
                    ),
                    color: backgroundColor,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: accent.withOpacity(0.15),
                        child: Text(
                          String.fromCharCode(65 + i),
                          style: TextStyle(
                            fontSize: 12,
                            color: accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSpacing.md,
                      ),
                      Expanded(
                        child: Text(
                          options[i],
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.darkTextPrimary,
                          ),
                        ),
                      ),
                      if (revealed && isRight)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.successGreen,
                          size: 20,
                        ),
                      if (revealed && isSelected && !isRight)
                        const Icon(
                          Icons.cancel,
                          color: AppColors.errorRed,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (revealed) ...[
            const SizedBox(height: AppSpacing.sm),
            GlassCard(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCorrect ? 'Correct!' : 'Not quite',
                    style: textTheme.titleMedium?.copyWith(
                      color: isCorrect
                          ? AppColors.successGreen
                          : AppColors.errorRed,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    card.answer,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                  if (card.tip != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Tip: ${card.tip!}',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
