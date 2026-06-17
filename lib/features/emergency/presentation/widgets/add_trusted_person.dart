import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/features/care_team/presentation/widgets/add_edit_contact.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTrustedPerson extends ConsumerStatefulWidget {
  final List<CareTeamContact> list;

  const AddTrustedPerson({super.key, required this.list});

  static Future<void> show(
    BuildContext context,
    List<CareTeamContact> contactList,
  ) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.onTertiary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) => AddTrustedPerson(list: contactList),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTrustedPersonState();
}

class _AddTrustedPersonState extends ConsumerState<AddTrustedPerson> {
  String? isSelectedId;

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

  Future<void> _setAsTrustedPerson(CareTeamContact contact) async {
    final l10n = AppLocalizations.of(context)!;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final changedContact = contact.copyWith(isTrustedPerson: true);

    try {
      await ref
          .read(careTeamProvider)
          .editContact(uid, contact.id, changedContact);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.savedAsTrustedPerson)));
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
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
    final contacts = ref.watch(contactsProvider);

    return contacts.when(
      data: (contacts) {
        if (contacts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              l10n.noContactsToChoose,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.chooseTrustedPersonTitle,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.trustedPersonSubtitle,
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  ...contacts.map((contact) {
                    final isSelected = contact.id == isSelectedId;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        color: isSelected
                            ? context.colors.onTertiary
                            : context.colors.surface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: context.colors.outline),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: ListTile(
                          onTap: () => setState(() {
                            isSelectedId = contact.id;
                          }),
                          title: Text(
                            contact.name,
                            style: context.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            l10n.roleLabel(contact.role),
                            style: context.textTheme.bodySmall,
                          ),
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: context.colors.tertiary.withAlpha(
                              40,
                            ),
                            child: Text(
                              _getFirstLetters(contact.name),
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colors.tertiary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.colors.primary
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 0.5,
                                color: context.colors.outline,
                              ),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: context.colors.surface,
                                    size: 14,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          selectedColor: context.colors.onTertiary,
                          selected: isSelected,
                        ),
                      ),
                    );
                  }),

                  SizedBox(
                    width: double.infinity,
                    child: DottedBorder(
                      color: context.colors.outlineVariant.withAlpha(80),
                      strokeWidth: 0.5,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      child: Center(
                        child: TextButton.icon(
                          onPressed: () => AddEditContactSheet.show(context),
                          label: Text(
                            l10n.addNewContact,
                            style: TextStyle(
                              color: context.colors.outlineVariant,
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: context.colors.outlineVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSelectedId == null
                          ? null
                          : () {
                              final selectedContact = contacts.firstWhere(
                                (c) => c.id == isSelectedId,
                              );

                              _setAsTrustedPerson(selectedContact);
                            },
                      child: Text(l10n.setAsTrustedPerson),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, _) =>
          Center(child: Text(l10n.errorLoadingContacts(e.toString()))),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
