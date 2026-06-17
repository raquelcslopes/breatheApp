import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String doctorType;
  final Function() onTapEdit;
  final Function()? onTapCall;
  final Function()? onTapMessage;
  final Function()? onTapEmail;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;
  final int fillAlpha;

  const PersonCard({
    super.key,
    required this.name,
    required this.doctorType,
    required this.onTapEdit,
    required this.onTapCall,
    required this.onTapMessage,
    required this.onTapEmail,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 18,
    this.blur = 12,
    this.fillAlpha = 31,
  });

  String _getFirstLetters(String name) {
    final cleaned = name.trim().replaceFirst(
      RegExp(r'^(dr|dra|sr|sra|prof|enf|enfª|enf)\.?\s+', caseSensitive: false),
      '',
    );

    final parts = cleaned
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

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
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: onTapEdit,
                        child: Icon(Icons.edit_note_rounded, size: 20),
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.colors.primaryFixedDim
                                      .withValues(alpha: 0.2),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: context.colors.onPrimary,
                                child: Text(
                                  _getFirstLetters(name),
                                  style: context.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    name,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.roleLabel(doctorType).toUpperCase(),
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w100,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton.icon(
                              onPressed: onTapCall,
                              label: Text(
                                l10n.actionCall.toUpperCase(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              icon: Icon(Icons.phone_in_talk_outlined),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1,
                                  color: context.colors.outline.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: onTapMessage,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1,
                                  color: context.colors.outline.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              label: Text(
                                l10n.actionMessage.toUpperCase(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              icon: Icon(Icons.chat_bubble_outline_rounded),
                            ),
                            OutlinedButton.icon(
                              onPressed: onTapEmail,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1,
                                  color: context.colors.outline.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              label: Text(
                                l10n.actionEmail.toUpperCase(),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              icon: Icon(Icons.email_outlined),
                            ),
                          ],
                        ),
                      ],
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
