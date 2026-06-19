import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/entry_card.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _dayKey(DateTime d) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(d, now)) return 'today';
    if (_isSameDay(d, yesterday)) return 'yesterday';
    return 'earlier';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(entriesProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(color: context.colors.surface),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.journalTitle,
                  style: context.textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.journalSubtitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),

                entriesAsync.when(
                  data: (data) {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: data.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final e = data[i];
                          final key = _dayKey(e.createdAt);
                          final showHeader =
                              i == 0 || _dayKey(data[i - 1].createdAt) != key;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showHeader)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 10,
                                    left: 4,
                                  ),
                                  child: Text(
                                    l10n.dayLabel(key).toUpperCase(),
                                    style: context.textTheme.labelLarge
                                        ?.copyWith(
                                          color: context.colors.surfaceDim,
                                        ),
                                  ),
                                ),
                              EntryCard(
                                entry: e,
                                onTap: () => context.pushNamed(
                                  AppRoute.journalEntry,
                                  pathParameters: {'id': e.id},
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  error: (e, _) => Center(child: Text('Error: $e')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          right: 24,
          bottom: 24,
          child: FloatingActionButton(
            onPressed: () {
              context.push(AppRoute.journalNewPath);
            },
            backgroundColor: context.colors.primary,
            child: Icon(Icons.edit_outlined, color: context.colors.onPrimary),
          ),
        ),
      ],
    );
  }
}
