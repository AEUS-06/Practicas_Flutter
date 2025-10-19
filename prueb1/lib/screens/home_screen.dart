import 'package:flutter/material.dart';
import '../widgets/glass_background.dart';
import '../widgets/custom_menu.dart';
import 'compare_screen.dart';
import 'settings_screen.dart';
import '../widgets/neon_text.dart';
import '../widgets/neon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final screens = [
    const HomeContent(),
    const CompareScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlassBackground(child: screens[index]),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomMenu(
              selectedIndex: index,
              onItemSelected: (i) => setState(() => index = i),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        NeonText(text: "Neural Compare", size: 42),
        SizedBox(height: 40),
        NeonButton(text: "Iniciar Comparación"),
        NeonButton(text: "Configuración"),
      ],
    );
  }
}
