import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePhoneCall extends StatelessWidget {
  const MakePhoneCall({super.key});

  Future<void> _callHelpLine(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await launchUrl(Uri(scheme: 'tel', path: '1411'));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorWithDetails(e.toString())),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => _callHelpLine(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFA53A28), Color(0xFF8C2F20)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8C2F20).withValues(alpha: 0.28),
              offset: const Offset(0, 10),
              blurRadius: 24,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => _callHelpLine(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color(
                  0xFFFEFAE0,
                ).withValues(alpha: 0.16),
                foregroundColor: const Color(0xFFFEFAE0),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: const CircleBorder(),
                minimumSize: const Size(54, 54),
              ),
              child: const Icon(Icons.phone_outlined, size: 26),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1411',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: const Color(0xFFFEFAE0),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    l10n.confSubtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFFEFAE0),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.colors.surfaceContainer.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
