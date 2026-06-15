import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePhoneCall extends StatefulWidget {
  final CareTeamContact contact;

  const MakePhoneCall({super.key, required this.contact});

  @override
  State<StatefulWidget> createState() => _MakePhoneCallState();
}

class _MakePhoneCallState extends State<MakePhoneCall>
    with WidgetsBindingObserver {
  bool _callInProgress = false;

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

  Future<void> _callTrustedPerson(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      await launchUrl(Uri(scheme: 'tel', path: '+351$phoneNumber'));
      setState(() {
        _callInProgress = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _callInProgress) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: context.colors.primary.withAlpha(80),
                  child: Icon(
                    Icons.handshake_rounded,
                    color: context.colors.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You are not alone',
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "If ${widget.contact.name} didn't pick up — that's okay. Someone is ready to talk with you right now.",
                  style: context.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      _callTrustedPerson(context, widget.contact.phoneNumber!),
                  child: Text('Try ${widget.contact.name} again'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5728281C),
            offset: Offset(0, 8),
            blurRadius: 7,
            spreadRadius: -9,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withAlpha(50),
            maxRadius: 25,
            child: Text(
              _getFirstLetters(widget.contact.name),
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contact.name,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text('Your trusted person', style: context.textTheme.bodySmall),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                _callTrustedPerson(context, widget.contact.phoneNumber!),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.outline,
              iconColor: context.colors.primary,
              shape: const CircleBorder(),
            ),
            child: Icon(Icons.phone_outlined, size: 24),
          ),
        ],
      ),
    );
  }
}
