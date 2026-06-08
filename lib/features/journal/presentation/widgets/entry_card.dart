import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/problems.dart';
import 'package:flutter/material.dart';

class EntryCard extends StatefulWidget {
  final Color color;
  final String mood;
  final DateTime date;
  final String text;
  final List<Problems> problems;
  final VoidCallback onTap;

  const EntryCard({
    super.key,
    required this.color,
    required this.mood,
    required this.date,
    required this.text,
    required this.problems,
    required this.onTap,
  });

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

  Widget _problemChips(Problems problem, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: context.colors.secondary.withAlpha(80),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(problem.title, style: context.textTheme.bodyMedium),
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
          color: context.colors.surface,
          border: Border.all(color: context.colors.outline),
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
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: widget.color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: widget.color,
                                minRadius: 6,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Feeling ${widget.mood}',
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _getHour(widget.date),
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.text,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurface.withAlpha(120),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 3.0,
                        children: widget.problems.map((p) {
                          return _problemChips(p, context);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
