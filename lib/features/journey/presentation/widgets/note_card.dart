import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/extensions/text_style.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatefulWidget {
  final Color color;
  final DateTime date;
  final String mood;
  final String text;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.color,
    required this.date,
    required this.mood,
    required this.text,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _NoteCardState();
  }
}

class _NoteCardState extends State<NoteCard> {
  double _scale = 1.0;

  String _capitalize(String text) {
    return text.isEmpty
        ? text
        : text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String _getHour(DateTime date) {
    final formatted = DateFormat('EE, d MMMM', 'en_US').format(date);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final m = _capitalize(widget.mood);

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: AppColors.borderSoft),
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
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundColor: widget.color, minRadius: 6),
                    const SizedBox(width: 5),
                    Text(
                      _getHour(widget.date),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' • $m',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.diaryHint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
