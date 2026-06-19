import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/features/homescreen/presentation/widgets/horizontal_calendar.dart';
import 'package:breathe/features/homescreen/presentation/widgets/last_entry_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/daily_ckecin_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/statistics_card.dart';
import 'package:breathe/features/journey/domain/journey_provider.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // --------------------- WIDGETS ---------------------

  Widget _date(BuildContext context, AppLocalizations l10n) {
    final now = DateTime.now();
    final hour = now.hour;
    final partOfDay = hour < 12
        ? 'morning'
        : (hour < 18 ? 'afternoon' : 'evening');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.greeting(partOfDay), style: context.textTheme.headlineMedium),
        Text(
          l10n.homeSubtitle,
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final providerMood = ref.watch(watchEntriesProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('lib/assets/background.png', fit: BoxFit.cover),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.22, 0.55, 0.88, 1.0],
                colors: [
                  context.colors.surface.withValues(alpha: 0.55),
                  context.colors.surface.withValues(alpha: 0.05),
                  context.colors.surface.withValues(alpha: 0.15),
                  context.colors.surface.withValues(alpha: 0.60),
                  context.colors.surface.withValues(alpha: 0.80),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _date(context, l10n),
                      const SizedBox(height: 20),
                      const HorizontalCalendar(),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: const DailyCheckInCard(),
                      ),
                      const SizedBox(height: 40),
                      providerMood.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Row(
                              children: [
                                Expanded(
                                  child: StatisticsCard(
                                    records: [],
                                    onTap: () =>
                                        context.push(AppRoute.journeyPath),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: LastEntryCard(
                                    onTap: () =>
                                        context.push(AppRoute.journalPath),
                                    lastEntry: l10n.noRecentRecords,
                                  ),
                                ),
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(
                                child: StatisticsCard(
                                  records: data,
                                  onTap: () =>
                                      context.push(AppRoute.journeyPath),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: LastEntryCard(
                                  onTap: () =>
                                      context.push(AppRoute.journalPath),
                                  lastEntry: data.last.text,
                                ),
                              ),
                            ],
                          );
                        },
                        error: (e, _) => Center(
                          child: Text(l10n.errorWithDetails(e.toString())),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
