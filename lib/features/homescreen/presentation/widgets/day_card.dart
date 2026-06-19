import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.date,
    required this.selected,
    this.blur = 30,
  });

  final DateTime date;
  final bool selected;
  final double blur;

  String weekdayLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat(
      'EEE',
      locale,
    ).format(date).replaceAll('.', '').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    final textColor = selected
        ? context.colors.onPrimary
        : context.colors.inversePrimary;

    return ClipRRect(
      borderRadius: radius,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: const SizedBox.shrink(),
            ),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colors.surface.withAlpha(63),
                    context.colors.surface.withAlpha(38),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: selected ? 1 : 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colors.primary,
                      context.colors.primary.withAlpha(220),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border: Border.all(
                    color: context.colors.surface.withAlpha(20),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weekdayLabel(context),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textColor,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${date.day}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
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
          ),
        ],
      ),
    );
  }
}
