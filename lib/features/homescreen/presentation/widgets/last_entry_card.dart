import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LastEntryCard extends StatelessWidget {
  final String lastEntry;

  const LastEntryCard({super.key, required this.lastEntry});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.colors.outline.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.auto_stories_outlined,
                  color: context.colors.primary,
                ),
                Text(
                  'Recent Entry',
                  style: TextStyle(
                    color: context.colors.surfaceDim,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              '"$lastEntry"',
              style: TextStyle(fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
