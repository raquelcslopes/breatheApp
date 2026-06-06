import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FactorsBar extends StatelessWidget {
  const FactorsBar({super.key, required this.factors, required this.maxCount});

  final List<MapEntry<String, int>> factors;
  final int maxCount;

  String _title(String key) =>
      problemsList.firstWhere((p) => p.key == key).title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(20),
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
                    Text(_title(f.key)),
                    Text(
                      '${f.value}',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 9,
                    backgroundColor: AppColors.surfaceAlt,
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
