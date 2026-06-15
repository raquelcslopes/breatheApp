import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/emergency/data/emergency_contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsWidget extends StatelessWidget {
  final EmergencyContact contact;

  const EmergencyContactsWidget({super.key, required this.contact});

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
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x5728281C),
            offset: Offset(0, 8),
            blurRadius: 5,
            spreadRadius: -9,
          ),
        ],
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline, width: 0.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: context.colors.primary.withAlpha(40),
              child: Icon(Icons.favorite_border, color: context.colors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(contact.description, style: context.textTheme.bodySmall),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: context.colors.primary.withAlpha(40),
              child: TextButton.icon(
                onPressed: () => _makePhoneCall(context, contact),
                label: Icon(
                  Icons.phone_outlined,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
