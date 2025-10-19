import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.home_rounded,
      Icons.compare_rounded,
      Icons.settings_rounded,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onItemSelected(i),
            child: Icon(
              items[i],
              color: selected ? AppColors.neonBlue : Colors.white70,
              size: selected ? 34 : 28,
            ),
          );
        }),
      ),
    );
  }
}
