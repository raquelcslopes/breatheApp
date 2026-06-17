import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DailyCheckInCard extends StatelessWidget {
  const DailyCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 260,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/log.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.self_improvement),

          const SizedBox(height: 16),

          Text(l10n.checkInTitleLong, style: context.textTheme.headlineSmall),

          const SizedBox(height: 8),

          Text(l10n.checkInStorySubtitle, style: context.textTheme.bodyMedium),

          const Spacer(),

          Align(alignment: Alignment.bottomRight, child: SizedBox(width: 200)),
        ],
      ),
    );
  }
}
