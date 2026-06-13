import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/emergency/presentation/widgets/add_trusted_person.dart';
import 'package:breathe/features/emergency/presentation/widgets/send_message.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  //--------------------- FUNCTIONS ---------------------
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

  Future<void> _callTrustedPerson(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      await launchUrl(Uri(scheme: 'tel', path: '+351$phoneNumber'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _callTrustedPersonWidget(
    BuildContext context,
    CareTeamContact contact,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.primary,
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withAlpha(50),
            maxRadius: 25,
            child: Text(
              _getFirstLetters(contact.name),
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text('Your trusted person', style: context.textTheme.bodySmall),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _callTrustedPerson(context, contact.phoneNumber!),
            child: Icon(Icons.phone_outlined, size: 24),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.outline,
              iconColor: context.colors.primary,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trustedContactsProvider = ref.watch(trustedContactProvider);
    final allContactsProvider = ref.watch(contactsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('EMERGENCY'),
            Text(
              "You don't have to face this alone",
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: trustedContactsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Error getting your trusted numbers: $e')),
        data: (contact) {
          if (contact == null) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: DottedBorder(
                  color: context.colors.outlineVariant.withAlpha(80),
                  strokeWidth: 0.5,
                  dashPattern: [6, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  child: Container(
                    height: 210,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 25,
                            color: context.colors.primary.withAlpha(120),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No trusted person yet',
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Choose someone from your care team to reach first in a hard moment",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          allContactsProvider.when(
                            data: (contacts) {
                              return ElevatedButton.icon(
                                onPressed: () =>
                                    AddTrustedPerson.show(context, contacts),
                                icon: Icon(Icons.person_add_alt),
                                label: const Text('Add someone from care team'),
                              );
                            },
                            error: (e, _) => Center(child: Text("Error $e")),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          final hasPhoneNumber = contact.phoneNumber != null;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reach your trusted person',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    hasPhoneNumber
                        ? _callTrustedPersonWidget(context, contact)
                        : SizedBox.shrink(),

                    const SizedBox(height: 40),

                    SendMessage(contact: contact),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
