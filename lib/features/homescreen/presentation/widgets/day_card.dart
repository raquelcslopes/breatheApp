import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  const DayCard({super.key, required this.date, required this.selected});

  final DateTime date;
  final bool selected;

  String get weekday {
    const names = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return names[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 56,
      decoration: BoxDecoration(
        color: selected
            ? context.colors.primary
            : context.colors.surfaceContainerLow.withAlpha(65),
        borderRadius: BorderRadius.circular(20),
        border: selected
            ? null
            : Border.all(color: context.colors.outline.withAlpha(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weekday,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: selected
                  ? context.colors.onPrimary
                  : context.colors.inversePrimary,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${date.day}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: selected
                  ? context.colors.onPrimary
                  : context.colors.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          if (selected) ...[
            const SizedBox(height: 4),

            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.onPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
