import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/features/homescreen/presentation/widgets/horizontal_calendar.dart';
import 'package:breathe/features/homescreen/presentation/widgets/last_entry_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/daily_ckecin_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/statistics_card.dart';
import 'package:breathe/features/journey/domain/journey_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // --------------------- WIDGETS ---------------------

  Widget _date(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final partOfDay = hour < 12
        ? 'morning'
        : (hour < 18 ? 'afternoon' : 'evening');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good $partOfDay', style: context.textTheme.headlineMedium),
        Text(
          'A safe place for your thoughts, feelings, and experiences. Write honestly, reflect gently, and be yourself',
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerMood = ref.watch(watchEntriesProvider);

    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: context.colors.surface,
      body: Stack(
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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 28),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _date(context),
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
                                      child: StatisticsCard(records: []),
                                    ),
                                    const SizedBox(width: 16),
                                    const Expanded(
                                      child: LastEntryCard(
                                        lastEntry:
                                            'No records in the last 7 days',
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return Row(
                                children: [
                                  Expanded(
                                    child: StatisticsCard(records: data),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: LastEntryCard(
                                      lastEntry: data.last.text,
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (e, _) => Center(child: Text('Error: $e')),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
    );
  }
}
