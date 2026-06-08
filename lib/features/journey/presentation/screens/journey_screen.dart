import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journey/domain/journey_provider.dart';
import 'package:breathe/features/journey/presentation/widgets/factors_bar.dart';
import 'package:breathe/features/journey/presentation/widgets/mood_chart_card.dart';
import 'package:breathe/features/journey/presentation/widgets/note_card.dart';
import 'package:breathe/features/journey/presentation/widgets/simple_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class JourneyScreen extends ConsumerStatefulWidget {
  const JourneyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _JourneyScreenState();
  }
}

class _JourneyScreenState extends ConsumerState<JourneyScreen> {
  //--------------------- FUNCTIONS ---------------------
  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('d MMMM', 'en_US').format(date);

    return formattedDate;
  }

  String _capitalize(String text) {
    return text.isEmpty
        ? text
        : text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String? _mostCommonMood(List<JournalEntry> list) {
    final moodKeys = list.map((e) => e.moodKey).whereType<String>();

    if (moodKeys.isEmpty) return null;

    final counts = <String, int>{};
    for (final key in moodKeys) {
      counts[key] = (counts[key] ?? 0) + 1;
    }

    final topKey = counts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    return _capitalize(topKey);
  }

  String _daysLogged(List<JournalEntry> list) {
    final dates = list
        .map(
          (entry) => DateTime(
            entry.createdAt.year,
            entry.createdAt.month,
            entry.createdAt.day,
          ),
        )
        .toSet();

    return '${dates.length} of 7 days';
  }

  List<MapEntry<String, int>> _topFactors(List<JournalEntry> list) {
    final counts = <String, int>{};
    for (final entry in list) {
      for (final key in entry.problemKeys) {
        counts[key] = (counts[key] ?? 0) + 1;
      }
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted;
  }

  Color _getColorMood(JournalEntry entry) {
    final match = moods.where((m) => m.key == entry.moodKey);
    return match.isEmpty ? context.colors.tertiary : match.first.bgColor;
  }

  //--------------------- WIDGETS ---------------------
  Widget _appBar(BuildContext context) {
    final today = DateTime.now();
    final weekStart = today.subtract(const Duration(days: 6));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('This week', style: context.textTheme.titleLarge),
        Text(
          '${_formatDate(weekStart)} - ${_formatDate(today)}',
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(watchEntriesProvider);

    return Scaffold(
      appBar: AppBar(title: _appBar(context)),
      body: entries.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            const Center(child: Text("Couldn't load your journey")),
        data: (entriesList) {
          if (entriesList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_florist_outlined,
                      size: 56,
                      color: context.colors.primary.withAlpha(120),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'A blank page, just for you',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Whenever it feels right, write a few words about your day. Only you will ever see them",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push(AppRoute.journalNewPath),
                      icon: Icon(Icons.edit_outlined),
                      label: const Text('Write your first entry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final factors = _topFactors(entriesList);
          final maxCount = factors.isEmpty ? 1 : factors.first.value;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoodChartCard(entries: entriesList),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SimpleCard(
                            title: 'Most days',
                            text:
                                _mostCommonMood(entriesList) ??
                                'No mood recorded',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SimpleCard(
                            title: 'Days logged',
                            text: _daysLogged(entriesList),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'WHAT WEIGHED MOST',
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    FactorsBar(factors: factors, maxCount: maxCount),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'YOUR NOTES',
                          style: context.textTheme.titleMedium,
                        ),
                        if (entriesList.length > 4)
                          TextButton(
                            onPressed: () => context.push(AppRoute.journalPath),
                            child: Text(
                              'View all ${entriesList.length} entries',
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...entriesList.take(4).map((entry) {
                      return Column(
                        children: [
                          NoteCard(
                            color: _getColorMood(entry),
                            date: entry.createdAt,
                            mood: entry.moodKey ?? '',
                            text: entry.text,
                            onTap: () => context.pushNamed(
                              AppRoute.journalEntry,
                              pathParameters: {'id': entry.id},
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
