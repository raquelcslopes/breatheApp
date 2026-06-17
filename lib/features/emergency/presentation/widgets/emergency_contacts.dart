import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/emergency/data/emergency_contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsWidget extends StatelessWidget {
  final EmergencyContact contact;
  final bool isINEM;

  const EmergencyContactsWidget({
    super.key,
    required this.contact,
    required this.isINEM,
  });

  Future<void> _makePhoneCall(
    BuildContext context,
    EmergencyContact contact,
  ) async {
    try {
      await launchUrl(Uri(scheme: 'tel', path: '+351${contact.phoneNumber}'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error has occurred'),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        border: Border.all(
          color: context.colors.outlineVariant,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface.withValues(alpha: 0.09),
            blurRadius: 60,
            spreadRadius: -8,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isINEM
                  ? context.colors.error
                  : context.colors.primary.withAlpha(40),
              child: isINEM
                  ? Icon(
                      Icons.sos_rounded,
                      color: context.colors.errorContainer,
                    )
                  : Icon(Icons.favorite_border, color: context.colors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: context.textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(contact.description, style: context.textTheme.bodySmall),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => _makePhoneCall(context, contact),
              label: Icon(
                Icons.phone_outlined,
                color: isINEM ? context.colors.error : context.colors.primary,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
