import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/homescreen/presentation/widgets/mini_calendar.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() {
    return _CalendarCardState();
  }
}

class _CalendarCardState extends State<CalendarCard> {
  double _scale = 1.0;

  Widget _calendarLegend() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.psychology,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Psychology appointment',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.psychiatrist,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Psychiatrist appointment',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gp,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'General practitioner appointment',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.96),
        onTapUp: (_) => setState(() => _scale = 1.0),
        onTapCancel: () => setState(() => _scale = 1.0),
        onTap: () {},
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
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
                  MiniCalendar(),
                  SizedBox(height: 10),
                  _calendarLegend(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
