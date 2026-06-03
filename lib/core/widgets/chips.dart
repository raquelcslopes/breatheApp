import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? bgColor;
  final Color? borderColor;
  final IconData? icon;

  const CustomChip({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
    this.bgColor,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(10),
        curve: Curves.bounceOut,
        decoration: BoxDecoration(
          color: isSelected ? bgColor : AppColors.surface,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: isSelected ? 1.5 : 0.5,
            color: isSelected
                ? borderColor ?? Colors.white
                : AppColors.border.withAlpha(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 14), SizedBox(width: 7), Text(label)],
        ),
      ),
    );
  }
}
