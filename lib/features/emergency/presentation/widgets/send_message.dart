import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
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
  final String _message =
      "Hi, I'm going through a really hard moment and could use some support. Could you reach out when you're able to?";
  bool _shareLocation = false;
  //--------------------- FUNCTIONS ---------------------
  @override
  void initState() {
    _messageController = TextEditingController(text: _message);
    super.initState();
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
    try {
      String message = _messageController.text;

      if (_shareLocation) {
        final position = await _getCurrentLocation();

        if (position != null) {
          message +=
              '\n\nMy current location:\nhttps://maps.google.com/?q=${position.latitude},${position.longitude}';
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const Text(
              'Share my location',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
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
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.outline, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5728281C),
            offset: Offset(0, 8),
            blurRadius: 5,
            spreadRadius: -9,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(
                fontStyle: FontStyle.italic,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              readOnly: isReadOnly,
              maxLines: 4,
              controller: _messageController,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            _shareMyLocation(),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: () => setState(() {
                    isReadOnly = false;
                  }),
                  label: Text('Edit'),
                  icon: Icon(Icons.edit),
                ),
                ElevatedButton.icon(
                  onPressed: () => _sendMessageTo(widget.contact),
                  label: Text('Send message to ${widget.contact.name}'),
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
