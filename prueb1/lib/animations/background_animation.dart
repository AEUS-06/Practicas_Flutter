import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.neonBlue.withOpacity(0.15 + 0.1 * _controller.value),
                AppColors.neonPink.withOpacity(0.1 + 0.1 * (1 - _controller.value)),
                AppColors.background,
              ],
              radius: 1.4,
              center: Alignment(
                0.3 * (1 - _controller.value),
                -0.3 * _controller.value,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
