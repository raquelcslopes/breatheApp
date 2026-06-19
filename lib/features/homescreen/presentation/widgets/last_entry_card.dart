import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LastEntryCard extends StatelessWidget {
  final String lastEntry;
  final VoidCallback onTap;

  const LastEntryCard({
    super.key,
    required this.lastEntry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: const Color(0xFF302826).withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF302826).withValues(alpha: 0.10),
              blurRadius: 36,
              offset: const Offset(0, 16),
            ),
          ],
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
                  l10n.recentEntry,
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
