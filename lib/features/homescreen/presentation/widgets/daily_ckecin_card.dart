import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DailyCheckInCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;
  final int fillAlpha;

  const DailyCheckInCard({
    super.key,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 18,
    this.blur = 12,
    this.fillAlpha = 31,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final radius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            splashColor: context.colors.surface.withAlpha(26),
            highlightColor: context.colors.surface.withAlpha(13),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: radius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colors.surface.withAlpha(fillAlpha + 13),
                    context.colors.surface.withAlpha((fillAlpha * 0.5).round()),
                  ],
                ),
                border: Border.all(
                  color: context.colors.surface.withAlpha(64),
                  width: 1,
                ),
              ),
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontWeight: FontWeight.w600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.dark_mode_outlined),
                    Text(
                      l10n.checkInTitle,
                      style: context.textTheme.headlineSmall,
                    ),
                    Text(
                      l10n.checkInSubtitle,
                      style: context.textTheme.bodyMedium,
                    ),
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
            ),
          ),
        ),
      ),
    );
  }
}
