import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/role.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/core/widgets/custom_elevated_button.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEditContactSheet extends ConsumerStatefulWidget {
  final CareTeamContact? contact;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;
  final int fillAlpha;

  const AddEditContactSheet({
    super.key,
    this.contact,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 18,
    this.blur = 12,
    this.fillAlpha = 31,
  });

  static Future<void> show(BuildContext context, {CareTeamContact? contact}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) => AddEditContactSheet(contact: contact),
    );
  }

  @override
  ConsumerState<AddEditContactSheet> createState() =>
      _AddEditContactSheetState();
}

class _AddEditContactSheetState extends ConsumerState<AddEditContactSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  String? _selectedRole;
  late bool _isTrusted;
  late bool _hasConsent;

  //--------------------- FUNCTIONS ---------------------
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _phoneController = TextEditingController(text: widget.contact?.phoneNumber);
    _emailController = TextEditingController(text: widget.contact?.email);

    _selectedRole = widget.contact?.role;
    _isTrusted = widget.contact?.isTrustedPerson ?? false;
    _hasConsent = widget.contact?.hasPermissionToAcessInfo ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    final l10n = AppLocalizations.of(context)!;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final isEmpty =
        _nameController.text.trim().isEmpty || _selectedRole == null;
    if (uid == null || isEmpty) return;

    final contact = CareTeamContact(
      id: '',
      name: _nameController.text,
      role: _selectedRole!,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
      isTrustedPerson: _isTrusted,
      hasPermissionToAcessInfo: _hasConsent,
    );

    try {
      await ref.read(careTeamProvider).saveContact(uid, contact);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.contactCreated),
            backgroundColor: AppColors.primary,
            showCloseIcon: true,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.couldntSaveContact(e.toString())),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  Future<void> _changeContact(CareTeamContact oldContact) async {
    final l10n = AppLocalizations.of(context)!;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final isEmpty =
        _nameController.text.trim().isEmpty || _selectedRole == null;
    if (uid == null || isEmpty) return;

    final contactId = oldContact.id;

    final newContact = CareTeamContact(
      id: contactId,
      name: _nameController.text,
      role: _selectedRole!,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
      isTrustedPerson: _isTrusted,
      hasPermissionToAcessInfo: _hasConsent,
    );

    try {
      await ref.read(careTeamProvider).editContact(uid, contactId, newContact);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.contactChanged),
            backgroundColor: AppColors.primary,
            showCloseIcon: true,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.couldntSaveChanges(e.toString())),
          backgroundColor: AppColors.errorContainer,
        ),
      );
    }
  }

  Future<void> _deleteContact(String contactId) async {
    final l10n = AppLocalizations.of(context)!;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.deleteContactTitle),
          content: Text(l10n.actionCannotBeUndone),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                l10n.delete,
                style: const TextStyle(color: AppColors.errorContainer),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      try {
        await ref.read(careTeamProvider).deleteContact(uid, contactId);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.contactDeleted)));
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorWithDetails(e.toString()))),
        );
      }
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _trustPerson() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer.withValues(alpha: 0.4),
        border: Border.all(
          color: const Color(0xFF464840).withValues(alpha: 0.3),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(Icons.star_outline, color: context.colors.tertiaryFixed),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.trustedPersonTitle,
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  l10n.trustedPersonDescription,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch(
            value: _isTrusted,
            onChanged: (e) => setState(() {
              _isTrusted = e;
            }),
          ),
        ],
      ),
    );
  }

  Widget _consent() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer.withValues(alpha: 0.4),
        border: Border.all(
          color: const Color(0xFF464840).withValues(alpha: 0.3),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(Icons.share, color: context.colors.tertiaryFixed),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.shareSummariesTitle,
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  l10n.shareSummariesDescription,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch(
            value: _hasConsent,
            onChanged: (e) => setState(() {
              _hasConsent = e;
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final radius = BorderRadius.circular(widget.borderRadius);
    final hasNoContact = widget.contact == null;

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            splashColor: context.colors.surface.withAlpha(26),
            highlightColor: context.colors.surface.withAlpha(13),
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: radius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colors.surface.withAlpha(widget.fillAlpha + 13),
                    context.colors.surface.withAlpha(
                      (widget.fillAlpha * 0.5).round(),
                    ),
                  ],
                ),
                border: Border.all(
                  color: context.colors.surface.withAlpha(64),
                  width: 1,
                ),
              ),
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontWeight: FontWeight.w600),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hasNoContact
                                    ? l10n.createContact
                                    : l10n.editContactTitle,
                                style: context.textTheme.headlineSmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.close_rounded),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          Text(
                            l10n.fieldName,
                            style: context.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 13),
                          TextField(
                            controller: _nameController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: context.colors.primary.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              hint: Text(l10n.fieldName),
                            ),
                          ),
                          const SizedBox(height: 32),

                          Text(
                            l10n.fieldRole,
                            style: context.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 13),
                          Wrap(
                            runSpacing: 5,
                            spacing: 5,
                            children: roles.map((role) {
                              final isSelected = _selectedRole == role.key;
                              return ChoiceChip(
                                label: Text(
                                  l10n.roleLabel(role.key),
                                  style: context.textTheme.bodySmall,
                                ),
                                selected: isSelected,
                                onSelected: (_) =>
                                    setState(() => _selectedRole = role.key),
                                labelStyle: TextStyle(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                selectedColor: context.colors.onPrimary,
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: const Color(
                                      0xFF464840,
                                    ).withValues(alpha: 0.3),
                                    strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                ),
                                showCheckmark: false,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 32),

                          Text(
                            l10n.fieldPhone,
                            style: context.textTheme.labelLarge,
                          ),
                          const SizedBox(height: 13),
                          TextField(
                            controller: _phoneController,
                            maxLines: 1,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: context.colors.primary.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              hint: const Text('000 000 000'),
                            ),
                          ),
                          const SizedBox(height: 32),

                          Text(
                            l10n.fieldEmail,
                            style: context.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 13),
                          TextField(
                            controller: _emailController,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: context.colors.primary.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              hint: const Text('email@example.com'),
                            ),
                          ),
                          const SizedBox(height: 48),

                          _trustPerson(),
                          const SizedBox(height: 16),

                          _consent(),
                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              child: CustomElevatedButton(
                                onTap: hasNoContact
                                    ? _saveContact
                                    : () => _changeContact(widget.contact!),
                                label: hasNoContact
                                    ? l10n.createContact
                                    : l10n.saveChanges,
                              ),
                            ),
                          ),

                          hasNoContact
                              ? const SizedBox.shrink()
                              : Align(
                                  alignment: Alignment.center,
                                  child: TextButton.icon(
                                    onPressed: () => _deleteContact(
                                      widget.contact?.id ?? '',
                                    ),
                                    label: Text(
                                      l10n.removeFromCareTeam,
                                      style: TextStyle(
                                        color: context.colors.error,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.delete_forever_outlined,
                                      color: context.colors.error,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
