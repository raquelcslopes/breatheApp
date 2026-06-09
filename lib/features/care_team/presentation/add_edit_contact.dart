import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/models/role.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/features/care_team/domain/care_team_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEditContactSheet extends ConsumerStatefulWidget {
  final CareTeamContact? contact;

  const AddEditContactSheet({super.key, this.contact});

  static Future<void> show(BuildContext context, {CareTeamContact? contact}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: context.colors.onTertiary,
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
    _nameController = TextEditingController(
      text: widget.contact?.name ?? widget.contact?.name,
    );

    _phoneController = TextEditingController(
      text: widget.contact?.phoneNumber ?? widget.contact?.phoneNumber,
    );

    _emailController = TextEditingController(
      text: widget.contact?.email ?? widget.contact?.email,
    );

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

  Future<void> _saveContact() async {
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
            content: Text("Contact created successfully"),
            backgroundColor: AppColors.moodGood,
            showCloseIcon: true,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't save the contact: $e"),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  Future<void> _changeContact(CareTeamContact oldContact) async {
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
            content: Text("Contact changed successfully"),
            backgroundColor: AppColors.moodGood,
            showCloseIcon: true,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't save changes: $e"),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  Future<void> _deleteContact(String contactId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete contact?'),
          content: const Text(
            'This action cannot be undone. Do you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.danger),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact deleted succssefully')),
          );
          context.pop();
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  //--------------------- WIDGETS ---------------------
  Widget _trustPerson() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.tertiary.withAlpha(40),
        border: Border.all(color: context.colors.tertiary),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [
          Icon(Icons.star, color: context.colors.tertiary),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trusted person',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'First contact in an emergency',
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
            thumbColor: WidgetStatePropertyAll<Color>(context.colors.surface),
          ),
        ],
      ),
    );
  }

  Widget _consent() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.secondary.withAlpha(40),
        border: Border.all(color: AppColors.forest),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [
          Icon(Icons.share, color: AppColors.forest),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share my summaries',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Allow sending check-ins',
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
            thumbColor: WidgetStatePropertyAll<Color>(context.colors.surface),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNoContact = widget.contact == null;

    return SingleChildScrollView(
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
                    hasNoContact ? ' Create contact' : 'Edit contact',
                    style: context.textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: context.colors.onSurface.withAlpha(40),
                  child: Text(
                    hasNoContact ? '' : _getFirstLetters(widget.contact!.name),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text('Name', style: context.textTheme.labelLarge),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: context.colors.outlineVariant,
                  ),
                  hint: Text('Name'),
                ),
              ),
              const SizedBox(height: 20),

              Text('Role', style: context.textTheme.labelLarge),
              const SizedBox(height: 10),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                children: roles.map((role) {
                  final isSelected = _selectedRole == role.key;
                  return ChoiceChip(
                    label: Text(role.name),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedRole = role.key),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? context.colors.onSecondary
                          : const Color.fromARGB(158, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                    selectedColor: context.colors.primary,
                    backgroundColor: context.colors.surface,
                    side: BorderSide(color: context.colors.outline),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Text('Phone number', style: context.textTheme.labelLarge),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: context.colors.outlineVariant,
                  ),
                  hint: Text('000 000 000'),
                ),
              ),
              const SizedBox(height: 20),

              Text('Email', style: context.textTheme.labelLarge),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: context.colors.outlineVariant,
                  ),
                  hint: Text('email@example.com'),
                ),
              ),
              const SizedBox(height: 20),

              _trustPerson(),
              const SizedBox(height: 20),

              _consent(),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: hasNoContact
                      ? _saveContact
                      : () => _changeContact(widget.contact!),
                  child: Text(hasNoContact ? 'Create contact' : 'Save changes'),
                ),
              ),
              const SizedBox(height: 20),

              hasNoContact
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () =>
                            _deleteContact(widget.contact?.id ?? ''),
                        label: Text(
                          'Remove from care team',
                          style: TextStyle(color: AppColors.danger),
                        ),
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
