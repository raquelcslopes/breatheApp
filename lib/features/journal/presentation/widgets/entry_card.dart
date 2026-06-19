import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/utils/capitalize.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:flutter/material.dart';

class EntryCard extends StatefulWidget {
  final JournalEntry entry;
  final Function() onTap;

  const EntryCard({required this.entry, super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _EntryCardState();
  }
}

class _EntryCardState extends State<EntryCard> {
  double _scale = 1.0;

  String _getHour(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Widget _problemChips(String problem, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.05),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.20),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(capitalize(problem), style: context.textTheme.bodySmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.colors.outline,
            width: 0.05,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.1),
              offset: Offset(0, 20),
              blurRadius: 25,
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.1),
              offset: Offset(0, 8),
              blurRadius: 10,
              spreadRadius: -6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Feeling ${capitalize(widget.entry.moodKey ?? '-')}',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    _getHour(widget.entry.createdAt),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.secondary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                widget.entry.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.justify,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.entry.problemKeys.map((problem) {
                  return _problemChips(problem, context);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
