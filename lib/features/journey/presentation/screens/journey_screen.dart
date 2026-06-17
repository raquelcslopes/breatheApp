import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journey/domain/journey_provider.dart';
import 'package:breathe/features/journey/presentation/widgets/factors_bar.dart';
import 'package:breathe/features/journey/presentation/widgets/mood_chart_card.dart';
import 'package:breathe/features/journey/presentation/widgets/note_card.dart';
import 'package:breathe/features/journey/presentation/widgets/simple_card.dart';
import 'package:breathe/l10n/app_localizations.dart';
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
  String _formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('d MMMM', locale).format(date);
  }

  String? _topMoodKey(List<JournalEntry> list) {
    final moodKeys = list.map((e) => e.moodKey).whereType<String>();
    if (moodKeys.isEmpty) return null;
    final counts = <String, int>{};
    for (final key in moodKeys) {
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  int _daysLoggedCount(List<JournalEntry> list) {
    final dates = list
        .map(
          (e) => DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day),
        )
        .toSet();
    return dates.length;
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

  //--------------------- WIDGETS ---------------------
  Widget _header(BuildContext context, AppLocalizations l10n) {
    final today = DateTime.now();
    final weekStart = today.subtract(const Duration(days: 6));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.thisWeek, style: context.textTheme.titleLarge),
        Text(
          '${_formatDate(context, weekStart)} - ${_formatDate(context, today)}',
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final entries = ref.watch(watchEntriesProvider);

    return Scaffold(
      drawer: CustomDrawer(),
      body: entries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.couldntLoadJourney)),
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
                      l10n.blankPageTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.blankPageSubtitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push(AppRoute.journalNewPath),
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(l10n.writeFirstEntry),
                    ),
                  ],
                ),
              ),
            );
          }

          final factors = _topFactors(entriesList);
          final maxCount = factors.isEmpty ? 1 : factors.first.value;
          final topMood = _topMoodKey(entriesList);
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'lib/assets/background.png',
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        context.colors.surface.withAlpha(100),
                        context.colors.surface.withAlpha(200),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        _header(context, l10n),
                        const SizedBox(height: 30),
                        MoodChartCard(entries: entriesList),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SimpleCard(
                                title: l10n.mostDays,
                                text: topMood == null
                                    ? l10n.noMoodRecorded
                                    : l10n.moodLabel(topMood),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SimpleCard(
                                title: l10n.daysLogged,
                                text: l10n.daysLoggedValue(
                                  _daysLoggedCount(entriesList),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          l10n.whatWeighedMost,
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        FactorsBar(factors: factors, maxCount: maxCount),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.yourNotes,
                              style: context.textTheme.titleMedium,
                            ),
                            if (entriesList.length > 4)
                              TextButton(
                                onPressed: () =>
                                    context.push(AppRoute.journalPath),
                                child: Text(
                                  l10n.viewAllEntries(entriesList.length),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...entriesList.take(4).map((entry) {
                          return Column(
                            children: [
                              NoteCard(
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
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      color: context.colors.primary,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
