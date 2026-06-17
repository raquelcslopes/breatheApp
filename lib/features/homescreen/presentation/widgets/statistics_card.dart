import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  final List<JournalEntry> records;
  final VoidCallback onTap;

  const StatisticsCard({super.key, required this.records, required this.onTap});

  String? _topMoodKey(List<JournalEntry> list) {
    final moodKeys = list.map((e) => e.moodKey).whereType<String>();

    if (moodKeys.isEmpty) return null;

    final counts = <String, int>{};
    for (final key in moodKeys) {
      counts[key] = (counts[key] ?? 0) + 1;
    }

    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final topKey = _topMoodKey(records);

    return InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.analytics_outlined,
                color: context.colors.surfaceContainer,
              ),
              Text(
                l10n.weeklyIndex,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                topKey == null ? '' : l10n.moodLabel(topKey),
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),

              Text(
                l10n.commonMood,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.surfaceDim,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
