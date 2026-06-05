import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MiniCalendar extends StatefulWidget {
  const MiniCalendar({super.key});

  @override
  State<MiniCalendar> createState() => _MiniCalendarState();
}

class _MiniCalendarState extends State<MiniCalendar> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      currentDay: DateTime.now(),

      daysOfWeekHeight: 18,
      rowHeight: 36,

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        headerPadding: EdgeInsets.symmetric(vertical: 4),
        titleTextStyle: TextStyle(
          fontSize: 14,
          color: context.colors.onSurface,
        ),
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),

      calendarStyle: CalendarStyle(
        cellMargin: EdgeInsets.all(2),
        todayDecoration: BoxDecoration(
          color: AppColors.forestDeep,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: Colors.white),
        defaultTextStyle: TextStyle(
          fontSize: 12,
          color: context.colors.onSurface,
        ),
        weekendTextStyle: TextStyle(
          fontSize: 12,
          color: context.colors.onSurface,
        ),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 10, color: context.colors.onSurface),
        weekendStyle: TextStyle(fontSize: 10, color: context.colors.onSurface),
      ),

      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
    );
  }
}
