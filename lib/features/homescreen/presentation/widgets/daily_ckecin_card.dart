import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DailyCheckInCard extends StatelessWidget {
  const DailyCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.w600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.dark_mode_outlined),
            Text(l10n.checkInTitle, style: context.textTheme.headlineSmall),
            Text(l10n.checkInSubtitle, style: context.textTheme.bodyMedium),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomElevatedButton(
                label: l10n.writeSomething,
                onTap: () => context.push(AppRoute.journalNewPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
