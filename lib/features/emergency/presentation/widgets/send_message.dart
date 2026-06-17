import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class SendMessage extends StatefulWidget {
  final CareTeamContact contact;

  const SendMessage({super.key, required this.contact});

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
      if (!context.mounted) return;
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
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(width: 10),
            Text(l10n.shareMyLocation, style: context.textTheme.bodyMedium),
          ],
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

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: context.colors.outlineVariant,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface.withValues(alpha: 0.09),
            blurRadius: 60,
            spreadRadius: -8,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              style: context.textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.ellipsis,
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
              maxLines: 3,
              controller: _messageController,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            _shareMyLocation(),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ElevatedButton.icon(
                  onPressed: () => _sendMessageTo(widget.contact),
                  label: Text(l10n.sendMessageTo(widget.contact.name)),
                  icon: const Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
