import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/extensions/text_style.dart';
import 'package:breathe/core/models/moods.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/ruled_painter.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EntryScreen extends ConsumerWidget {
  final String entryId;

  const EntryScreen({super.key, required this.entryId});

  Color _convertMoodToColor(BuildContext context, String? moodKey) {
    final m = moods.where((m) => m.key == moodKey);

    return m.isEmpty ? context.colors.surface : m.first.bgColor;
  }

  Widget _date(BuildContext context, JournalEntry entry) {
    final formattedDate = DateFormat(
      'EEEE, d MMMM, HH:mm',
      'en_US',
    ).format(entry.createdAt);

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: _convertMoodToColor(context, entry.moodKey),
          minRadius: 6,
        ),
        const SizedBox(width: 5),
        Text(formattedDate, style: context.textTheme.bodySmall),
      ],
    );
  }

  Widget _title(BuildContext context, JournalEntry entry) {
    final hour = entry.createdAt.hour;
    final partOfDay = hour < 12
        ? 'morning'
        : (hour < 18 ? 'afternoon' : 'evening');

    final day = DateFormat('EEEE').format(entry.createdAt);
    return Text('$day, $partOfDay', style: context.textTheme.titleLarge);
  }

  Widget _ruledText(BuildContext context, JournalEntry entry) {
    if (entry.text.isEmpty) {
      return CustomPaint(
        painter: const RuledPaperPainter(lineHeight: 30),
        child: Text('No notes added', style: AppTextStyles.diaryBody),
      );
    }
    return CustomPaint(
      painter: const RuledPaperPainter(lineHeight: 30),
      child: Text(entry.text, style: AppTextStyles.diaryBody),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entry = ref.watch(entryProvider(entryId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Entry'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: entry.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) =>
              const Center(child: Text("Could't load entry, please try agian")),
          data: (obj) {
            if (obj == null) {
              return Center(child: Text('Entry not found'));
            }
            return Stack(
              children: [
                Positioned(
                  left: 52,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1.4,
                    color: AppColors.primary.withValues(alpha: 0.22),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _date(context, obj),
                      const SizedBox(height: 5),
                      _title(context, obj),
                      const SizedBox(height: 15),
                      _ruledText(context, obj),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          style: context.textTheme.bodySmall,
                          children: [
                            const TextSpan(
                              text: 'On my mind today: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${obj.problemKeys.join(', ')}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
