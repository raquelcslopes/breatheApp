import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmotionCard extends StatelessWidget {
  final String asset;
  final String mood;
  final VoidCallback onTap;
  final bool isSelected;
  final Color isSelectedBgColor;
  final Color isSelectedBorderColor;

  const EmotionCard({
    super.key,
    required this.asset,
    required this.mood,
    required this.onTap,
    required this.isSelectedBgColor,
    required this.isSelectedBorderColor,

    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
            color: isSelected ? isSelectedBgColor : AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: isSelected
                ? Border.all(color: isSelectedBorderColor, width: 1.5)
                : Border.all(color: AppColors.border.withAlpha(20), width: 1.5),
          ),
          child: Column(
            children: [
              Image.asset(asset, height: 40),
              SizedBox(height: 10),
              Text(mood, style: context.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
