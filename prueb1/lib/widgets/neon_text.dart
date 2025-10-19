import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class NeonText extends StatelessWidget {
  final String text;
  final double size;
  const NeonText({super.key, required this.text, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: AppColors.neonBlue,
        shadows: [
          Shadow(
            blurRadius: 20,
            color: AppColors.neonPink.withOpacity(0.8),
          ),
          Shadow(
            blurRadius: 40,
            color: AppColors.neonBlue.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
