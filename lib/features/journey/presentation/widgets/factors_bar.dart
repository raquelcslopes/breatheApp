import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FactorsBar extends StatelessWidget {
  const FactorsBar({super.key, required this.factors, required this.maxCount});

  final List<MapEntry<String, int>> factors;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colors.outline,
          width: 0.05,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        children: factors.map((f) {
          final fraction = f.value / maxCount;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.problemLabel(f.key)),
                    Text(
                      '${f.value}',
                      style: TextStyle(color: context.colors.surfaceDim),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 9,
                    backgroundColor: context.colors.primary.withAlpha(40),
                    valueColor: AlwaysStoppedAnimation(context.colors.primary),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
