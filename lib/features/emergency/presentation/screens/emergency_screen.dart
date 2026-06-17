import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/widgets/drawer.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/emergency/domain/emergency_provider.dart';
import 'package:breathe/features/emergency/presentation/widgets/add_trusted_person.dart';
import 'package:breathe/features/emergency/presentation/widgets/emergency_contacts.dart';
import 'package:breathe/features/emergency/presentation/widgets/make_phone_call.dart';
import 'package:breathe/features/emergency/presentation/widgets/send_message.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final trustedContactsProvider = ref.watch(trustedContactProvider);
    final allContactsProvider = ref.watch(contactsProvider);
    final emergencyProvider = ref.watch(emergencyContactsProvider);

    return Scaffold(
      drawer: CustomDrawer(),
      body: trustedContactsProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(l10n.errorTrustedNumbers(e.toString()))),
        data: (contact) {
          if (contact == null) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: DottedBorder(
                color: context.colors.outlineVariant.withAlpha(80),
                strokeWidth: 0.5,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: Container(
                  height: 210,
                  padding: const EdgeInsets.all(20),
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
                          l10n.noTrustedPersonYet,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.chooseTrustedPerson,
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
                              icon: const Icon(Icons.person_add_alt),
                              label: Text(l10n.addFromCareTeam),
                            );
                          },
                          error: (e, _) => Center(
                            child: Text(l10n.errorWithDetails(e.toString())),
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          final hasPhoneNumber = contact.phoneNumber != null;

          return Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 35, 18, 18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.emergencyTitle,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.emergencySubtitle,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 40),

                        Text(
                          l10n.reachTrustedPerson.toUpperCase(),
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        hasPhoneNumber
                            ? MakePhoneCall(contact: contact)
                            : const SizedBox.shrink(),

                        const SizedBox(height: 40),

                        Text(
                          l10n.orSendMessage.toUpperCase(),
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          l10n.messageReadyToSend,
                          style: context.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10),
                        SendMessage(contact: contact),

                        const SizedBox(height: 40),
                        Container(
                          height: 0.5,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                context.colors.outline,
                                context.colors.outline,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.2, 0.8, 1.0],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        Text(
                          l10n.talkToSomeone,
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        emergencyProvider.when(
                          data: (emergencyContacts) {
                            if (emergencyContacts.isEmpty) {
                              return Center(child: Text(l10n.anErrorOccurred));
                            }
                            return Column(
                              children: emergencyContacts.map((
                                emergencyContact,
                              ) {
                                final isINEM =
                                    emergencyContact.phoneNumber == '112';
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: EmergencyContactsWidget(
                                    contact: emergencyContact,
                                    isINEM: isINEM,
                                  ),
                                );
                              }).toList(),
                            );
                          },
                          error: (e, _) => Center(
                            child: Text(l10n.errorWithDetails(e.toString())),
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      color: context.colors.primary,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
