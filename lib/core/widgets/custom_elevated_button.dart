import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onTap;
  final String label;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: -3,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.1),
            blurRadius: 6,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: context.colors.onPrimary,
          ),
        ),
      ),
    );
  }
}
