import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated circular progress indicator with a gradient stroke and a
/// centered percentage label — used on Home and the Progress dashboard.
class ProgressRing extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double size;
  final double strokeWidth;
  final Widget? centerLabel;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 140,
    this.strokeWidth = 12,
    this.centerLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress.clamp(0, 1)),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  progress: value,
                  strokeWidth: strokeWidth,
                  trackColor: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.06),
                ),
              ),
              centerLabel ??
                  Text(
                    '${(value * 100).round()}%',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color trackColor;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, track);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweep = Paint()
      ..shader = const SweepGradient(
        colors: [AppColors.primaryCyan, AppColors.secondaryPurple, AppColors.primaryCyan],
        startAngle: 0,
        endAngle: 6.28319,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const start = -1.5708; // -90deg, start at top
    final sweepAngle = 6.28319 * progress;
    canvas.drawArc(rect, start, sweepAngle, false, sweep);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
