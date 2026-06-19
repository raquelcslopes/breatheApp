import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';

import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/care_team/presentation/widgets/add_edit_contact.dart';
import 'package:breathe/features/care_team/presentation/widgets/person_card.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CareTeamScreen extends ConsumerWidget {
  const CareTeamScreen({super.key});

  Future<void> _makePhoneCall(BuildContext context, String contact) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await launchUrl(Uri(scheme: 'tel', path: '+351$contact'));
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

  Future<void> _sendMessage(BuildContext context, String phoneNumber) async {
    try {
      await launchUrl(Uri(scheme: 'sms', path: '+351$phoneNumber'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  Future<void> _sendEmail(BuildContext context, String email) async {
    try {
      await launchUrl(Uri(scheme: 'mailto', path: email));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final provider = ref.watch(contactsProvider);

    return provider.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>
          Center(child: Text(l10n.errorLoadingContacts(e.toString()))),
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
                    l10n.yourPeopleTitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.yourPeopleSubtitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.primary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => AddEditContactSheet.show(context),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addSomeone),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.trustedPersonHint,
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(color: context.colors.surface),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.careTeamTitle,
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.careTeamSubtitle,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        ...contacts.map((contact) {
                          final hasContact =
                              contact.phoneNumber?.isNotEmpty ?? false;
                          final hasEmail = contact.email?.isNotEmpty ?? false;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: PersonCard(
                              name: contact.name,
                              doctorType: contact.role,
                              onTapEdit: () => AddEditContactSheet.show(
                                context,
                                contact: contact,
                              ),
                              onTapCall: hasContact
                                  ? () => _makePhoneCall(
                                      context,
                                      contact.phoneNumber!,
                                    )
                                  : null,
                              onTapMessage: hasContact
                                  ? () => _sendMessage(
                                      context,
                                      contact.phoneNumber!,
                                    )
                                  : null,
                              onTapEmail: hasEmail
                                  ? () => _sendEmail(context, contact.email!)
                                  : null,
                            ),
                          );
                        }),

                        SizedBox(
                          width: double.infinity,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            dashPattern: const [10, 5],
                            strokeWidth: 2,
                            color: const Color(
                              0xFF909188,
                            ).withValues(alpha: 0.6),
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        AddEditContactSheet.show(context),
                                    icon: const Icon(Icons.add),
                                    style: IconButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side: BorderSide(
                                        color: Color(
                                          0xFF909188,
                                        ).withValues(alpha: 0.3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    l10n.addSomeone.toUpperCase(),
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          letterSpacing: 4.8,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
