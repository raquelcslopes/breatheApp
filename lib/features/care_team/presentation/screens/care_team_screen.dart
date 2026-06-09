import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';

import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/care_team/presentation/add_edit_contact.dart';
import 'package:breathe/features/care_team/presentation/widgets/person_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CareTeamScreen extends ConsumerWidget {
  const CareTeamScreen({super.key});

  Future<void> _makePhoneCall(BuildContext context, String contact) async {
    try {
      await launchUrl(Uri(scheme: 'tel', path: '+351$contact'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    }
  }

  Future<void> _sendMessage(BuildContext context, String phoneNumber) async {
    try {
      await launchUrl(Uri(scheme: 'sms', path: '+351$phoneNumber'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    }
  }

  Future<void> _sendEmail(BuildContext context, String email) async {
    try {
      await launchUrl(Uri(scheme: 'mailto', path: email));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('CARE TEAM'),
            TextButton(
              onPressed: () => AddEditContactSheet.show(context),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: provider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading  your contacts $e')),
        data: (contacts) {
          if (contacts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add_alt,
                      size: 56,
                      color: context.colors.primary.withAlpha(120),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Your people, in one place',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Add the people who support you — a doctor, a therapist, a friend you trust.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => AddEditContactSheet.show(context),
                      icon: Icon(Icons.add),
                      label: const Text('Add someone'),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'One of them can be your trusted person — the one you reach first in a hard moment.',
                      style: context.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: ListView.separated(
                itemCount: contacts.length,
                separatorBuilder: (context, index) =>
                    const Padding(padding: EdgeInsetsGeometry.only(bottom: 10)),
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  final hasContact = contact.phoneNumber?.isNotEmpty ?? false;
                  final hasEmail = contact.email?.isNotEmpty ?? false;

                  return PersonCard(
                    name: contact.name,
                    doctorType: contact.role,
                    onTapEdit: () =>
                        AddEditContactSheet.show(context, contact: contact),
                    onTapCall: hasContact
                        ? () => _makePhoneCall(context, contact.phoneNumber!)
                        : null,
                    onTapMessage: hasContact
                        ? () => _sendMessage(context, contact.phoneNumber!)
                        : null,
                    onTapEmail: hasEmail
                        ? () => _sendEmail(context, contact.email!)
                        : null,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
