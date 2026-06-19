import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/emergency/domain/emergency_provider.dart';
import 'package:breathe/features/emergency/presentation/widgets/emergency_contacts.dart';
import 'package:breathe/features/emergency/presentation/widgets/make_phone_call.dart';
import 'package:breathe/features/emergency/presentation/widgets/send_message.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final allContacts = ref.watch(contactsProvider);
    final emergencyContacts = ref.watch(emergencyContactsProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.emergencyTitle, style: context.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              l10n.emergencySubtitle,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 40),

            Text(
              l10n.confSubtitle.toUpperCase(),
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            const MakePhoneCall(),

            const SizedBox(height: 40),
            Text(
              l10n.orSendMessage.toUpperCase(),
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 3),
            Text(l10n.messageReadyToSend, style: context.textTheme.bodySmall),
            const SizedBox(height: 10),
            allContacts.when(
              data: (contacts) => SendMessage(contacts: contacts),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text(l10n.errorWithDetails(e.toString()))),
            ),

            const SizedBox(height: 40),
            Text(
              l10n.talkToSomeone.toUpperCase(),
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            emergencyContacts.when(
              data: (lines) {
                if (lines.isEmpty) {
                  return Center(child: Text(l10n.anErrorOccurred));
                }
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainer,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: context.colors.outline,
                      width: 0.05,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < lines.length; i++) ...[
                        if (i > 0)
                          Divider(
                            height: 1,
                            thickness: 0.1,
                            color: context.colors.outline,
                          ),
                        EmergencyContactsWidget(
                          contact: lines[i],
                          isINEM: lines[i].phoneNumber == '112',
                        ),
                      ],
                    ],
                  ),
                );
              },
              error: (e, _) =>
                  Center(child: Text(l10n.errorWithDetails(e.toString()))),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
