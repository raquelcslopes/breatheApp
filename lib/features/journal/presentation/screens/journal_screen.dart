import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/widgets/drawer.dart';
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

  String _dayLabel(DateTime d) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDay(d, now)) return 'Today';
    if (_isSameDay(d, yesterday)) return 'Yesterday';
    return 'Earlier';
  }

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

    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('lib/assets/background.png', fit: BoxFit.cover),
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
              padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    l10n.journalTitle,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
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
                          itemCount: data.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, i) {
                            final e = data[i];
                            final label = _dayLabel(e.createdAt);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoute.journalNewPath),
        child: Icon(Icons.add),
      ),
    );
  }
}
