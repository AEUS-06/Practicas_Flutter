import 'package:flutter/material.dart';
import '../widgets/neon_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NeonText(text: "Configuraciones", size: 32),
    );
  }
}
