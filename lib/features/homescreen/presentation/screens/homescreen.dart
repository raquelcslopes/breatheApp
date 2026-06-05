import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/homescreen/presentation/widgets/calendar_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/emergency_person.dart';
import 'package:breathe/features/homescreen/presentation/widgets/navigation_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/new_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ----------------- FUNCTIONS -----------------
  void _go(BuildContext context, String path) {
    context.push(path);
  }

  // ----------------- WIDGETS -----------------

  Widget _myAppBar(BuildContext context) {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      'en_US',
    ).format(DateTime.now());

    return Text(
      formattedDate,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
    );
  }

  String _greeting([DateTime? now]) {
    final hour = (now ?? DateTime.now()).hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _exploreSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('EXPLORE', style: context.textTheme.titleMedium),
            const SizedBox(width: 10),
            Expanded(child: Divider(radius: BorderRadius.circular(5))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AnimatedCard(
                title: 'Journal',
                subtitle: 'All your entries',
                onTap: () => _go(context, AppRoute.journalPath),
                color: AppColors.slateBlue,
                icon: Icons.document_scanner_outlined,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: AnimatedCard(
                title: 'History',
                subtitle: 'How you been',
                onTap: () => _go(context, AppRoute.summaryPath),
                color: AppColors.clay,
                icon: Icons.history,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _peopleSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('YOUR PEOPLE', style: context.textTheme.titleMedium),
            const SizedBox(width: 10),
            Expanded(child: Divider(radius: BorderRadius.circular(5))),
          ],
        ),
        const SizedBox(height: 10),
        EmergencyPerson(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _myAppBar(context)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_greeting(), style: context.textTheme.headlineMedium),
                const SizedBox(height: 20),
                const CalendarCard(),
                const SizedBox(height: 15),
                const NewEntryCard(),
                const SizedBox(height: 20),
                _exploreSection(context),
                const SizedBox(height: 20),
                _peopleSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
