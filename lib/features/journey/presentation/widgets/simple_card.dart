import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final String title;
  final String text;

  const SimpleCard({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: AppColors.borderSoft, width: 0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5728281C),
            offset: Offset(0, 8),
            blurRadius: 7,
            spreadRadius: -9,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
