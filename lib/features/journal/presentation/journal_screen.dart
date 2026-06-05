import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:breathe/features/journal/presentation/widgets/entry_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  Color _moodColor(String? key) {
    final m = moods.where((m) => m.key == key);
    return m.isEmpty ? AppColors.border : m.first.bgColor;
  }

  String _moodTitle(String? key) {
    final m = moods.where((m) => m.key == key);
    return m.isEmpty ? '—' : m.first.title;
  }

  List<Problems> _problemsFromKeys(List<String> keys) {
    return problemsList.where((p) => keys.contains(p.key)).toList();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(d, now)) return 'Today';
    if (_isSameDay(d, yesterday)) return 'Yesterday';
    return 'Earlier';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(entriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Journal'),
            ElevatedButton(
              onPressed: () => context.push(AppRoute.journalNewPath),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: entriesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => const Center(child: Text("Couldn't load entries")),
          data: (entries) {
            if (entries.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_stories_outlined,
                        size: 56,
                        color: AppColors.forest.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Your journal will live here',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Write a few words about your day, whenever it feels right. '
                        'Only you will see them.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => context.push(AppRoute.journalNewPath),
                        child: const Text('Write your first entry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final e = entries[i];
                final label = _dayLabel(e.createdAt);
                final showHeader =
                    i == 0 || _dayLabel(entries[i - 1].createdAt) != label;

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
                          label.toUpperCase(),
                          style: context.textTheme.labelLarge?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    EntryCard(
                      color: _moodColor(e.moodKey),
                      mood: _moodTitle(e.moodKey),
                      date: e.createdAt,
                      text: e.text,
                      problems: _problemsFromKeys(e.problemKeys),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
