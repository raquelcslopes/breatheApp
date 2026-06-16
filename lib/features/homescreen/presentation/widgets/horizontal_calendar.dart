import 'package:flutter/material.dart';
import 'day_card.dart';

class HorizontalCalendar extends StatelessWidget {
  const HorizontalCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final days = List.generate(
      7,
      (index) => now.subtract(Duration(days: 3 - index)),
    );

    return SizedBox(
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = days[index];

          final isSelected =
              date.day == now.day &&
              date.month == now.month &&
              date.year == now.year;

          return DayCard(date: date, selected: isSelected);
        },
      ),
    );
  }
}
