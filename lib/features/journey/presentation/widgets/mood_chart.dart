import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodChart extends StatelessWidget {
  const MoodChart({super.key, required this.weekStart, required this.entries});

  final DateTime weekStart;
  final List<JournalEntry> entries;

  String _dayLabel(int i, String locale) {
    final date = weekStart.add(Duration(days: i));
    return DateFormat('EEE', locale).format(date);
  }

  double? _moodToY(String? key) {
    switch (key) {
      case 'low':
        return 0;
      case 'okay':
        return 1;
      case 'good':
        return 2;
      default:
        return null;
    }
  }

  String? _moodKeyForIndex(int i) {
    switch (i) {
      case 0:
        return 'low';
      case 1:
        return 'okay';
      case 2:
        return 'good';
      default:
        return null;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<FlSpot> _buildSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final entry = entries
          .where((e) => _isSameDay(e.createdAt, day))
          .cast<JournalEntry?>()
          .firstWhere((_) => true, orElse: () => null);

      final y = _moodToY(entry?.moodKey);
      if (y != null) spots.add(FlSpot(i.toDouble(), y));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final spots = _buildSpots();
    final gradientColors = [context.colors.primary, context.colors.tertiary];

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 2,
          gridData: FlGridData(
            show: true,
            drawVerticalLine:
                false, // mudar para true para ficar igual ao sample
            horizontalInterval: 1,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: context.colors.outline, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 44,
                getTitlesWidget: (value, _) {
                  final key = _moodKeyForIndex(value.toInt());
                  return Text(
                    key == null ? '' : l10n.moodLabel(key),
                    style: context.textTheme.bodySmall,
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i > 6) return const SizedBox.shrink();
                  final locale = Localizations.localeOf(context).toString();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      _dayLabel(i, locale),
                      style: context.textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => context.colors.surface,
              getTooltipItems: (touched) => touched.map((s) {
                final key = _moodKeyForIndex(s.y.toInt());
                return LineTooltipItem(
                  key == null ? '' : l10n.moodLabel(key),
                  context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                );
              }).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              preventCurveOverShooting: true,
              gradient: LinearGradient(colors: gradientColors),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 4,
                  color: context.colors.surface,
                  strokeWidth: 2,
                  strokeColor: context.colors.primary,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors
                      .map((c) => c.withValues(alpha: 0.25))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
