import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/drawer.dart';

import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/care_team/presentation/widgets/add_edit_contact.dart';
import 'package:breathe/features/care_team/presentation/widgets/person_card.dart';
import 'package:dotted_border/dotted_border.dart';
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
        SnackBar(
          content: Text('Error: $e'),
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
    final provider = ref.watch(contactsProvider);

    return Scaffold(
      drawer: CustomDrawer(),
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

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'lib/assets/background.png',
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        context.colors.surface.withAlpha(100),
                        context.colors.surface.withAlpha(200),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 35, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Care Team',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Your support network, all in one place',
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
                              final hasEmail =
                                  contact.email?.isNotEmpty ?? false;

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
                                      ? () =>
                                            _sendEmail(context, contact.email!)
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
                                        'Add someone'.toUpperCase(),
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
