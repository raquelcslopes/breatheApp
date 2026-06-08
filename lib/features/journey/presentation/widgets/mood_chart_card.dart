import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journey/presentation/widgets/mood_chart.dart';
import 'package:flutter/material.dart';

class MoodChartCard extends StatelessWidget {
  final List<JournalEntry> entries;

  const MoodChartCard({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 20, 15, 5),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: Colors.transparent),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MoodChart(
              weekStart: DateTime.now().subtract(const Duration(days: 6)),
              entries: entries,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
