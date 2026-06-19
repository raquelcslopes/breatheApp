import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class SendMessage extends StatefulWidget {
  /// Lista de contactos da Care Team (passa-a a partir do provider no ecrã pai).
  final List<CareTeamContact> contacts;

  const SendMessage({super.key, required this.contacts});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  late final TextEditingController _messageController;
  bool isReadOnly = true;
  bool _shareLocation = false;
  bool _prefilled = false;

  //--------------------- FUNCTIONS ---------------------
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_prefilled) {
      _messageController.text = AppLocalizations.of(context)!.presetMessage;
      _prefilled = true;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  /// Abre o modal de contactos; se o utilizador escolher um, envia-lhe a mensagem.
  Future<void> _pickContactAndSend() async {
    final eligible = widget.contacts
        .where((c) => c.phoneNumber != null && c.phoneNumber!.isNotEmpty)
        .toList();

    final selected = await showModalBottomSheet<CareTeamContact>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.colors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ContactPickerSheet(contacts: eligible),
    );

    if (selected == null) return;
    await _sendMessageTo(selected);
  }

  Future<void> _sendMessageTo(CareTeamContact contact) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      String message = _messageController.text;

      if (_shareLocation) {
        final position = await _getCurrentLocation();

        if (position != null) {
          message +=
              '\n\n${l10n.myCurrentLocation}\nhttps://maps.google.com/?q=${position.latitude},${position.longitude}';
        }
      }

      await launchUrl(
        Uri(
          scheme: 'sms',
          path: '+351${contact.phoneNumber}',
          query: encodeQueryParameters({'body': message}),
        ),
      );
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

  Future<Position?> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  //--------------------- WIDGETS ---------------------

  Widget _shareMyLocation() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  l10n.shareMyLocation,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _shareLocation,
          onChanged: (value) => setState(() {
            _shareLocation = value;
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(
              color: context.colors.outline,
              width: 0.05,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  readOnly: isReadOnly,
                  minLines: 2,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _messageController,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                _shareMyLocation(),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(
              color: context.colors.outline,
              width: 0.05,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => setState(() {
                    isReadOnly = false;
                  }),
                  label: Text(l10n.edit),
                  icon: const Icon(Icons.edit),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickContactAndSend,
                    label: Text(
                      l10n.sendMessageTo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    icon: const Icon(Icons.send),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactPickerSheet extends StatelessWidget {
  final List<CareTeamContact> contacts;

  const _ContactPickerSheet({required this.contacts});

  String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (contacts.isEmpty) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.group_outlined,
                color: context.colors.primary,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.noContactsToChoose,
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Text(
              l10n.chooseRecipient,
              style: context.textTheme.titleMedium,
            ),
          ),
          ...contacts.map(
            (c) => ListTile(
              leading: CircleAvatar(
                backgroundColor: context.colors.primary.withValues(alpha: 0.15),
                child: Text(
                  _initials(c.name),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(c.name, style: context.textTheme.bodyLarge),
              subtitle: Text(
                l10n.yourTrustedPerson,
                style: context.textTheme.bodySmall,
              ),
              trailing: Icon(
                Icons.send,
                color: context.colors.primary,
                size: 20,
              ),
              onTap: () => Navigator.pop(context, c),
            ),
          ),
        ],
      ),
    );
  }
}
