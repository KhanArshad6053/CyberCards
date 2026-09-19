import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, anim, __) => const RootScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _Ring(scale: 0.6 + t * 0.4, opacity: 1 - t, color: AppColors.primaryCyan),
                      _Ring(scale: 0.4 + t * 0.3, opacity: (1 - t) * 0.8, color: AppColors.secondaryPurple),
                      Opacity(
                        opacity: t.clamp(0, 1),
                        child: Transform.scale(
                          scale: 0.8 + 0.2 * t,
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppColors.primaryCyan, AppColors.secondaryPurple],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryCyan.withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.shield_rounded,
                                color: Colors.white, size: 46),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Opacity(
                  opacity: t.clamp(0, 1),
                  child: const Text(
                    'CyberCards',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Opacity(
                  opacity: t.clamp(0, 1),
                  child: const Text(
                    'Learn. Protect. Stay Secure.',
                    style: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double scale;
  final double opacity;
  final Color color;

  const _Ring({required this.scale, required this.opacity, required this.color});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.clamp(0, 1),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.6), width: 1.5),
          ),
        ),
      ),
    );
  }
}
