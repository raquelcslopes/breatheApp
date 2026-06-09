import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String doctorType;
  final Function() onTapEdit;
  final Function()? onTapCall;
  final Function()? onTapMessage;
  final Function()? onTapEmail;

  const PersonCard({
    super.key,
    required this.name,
    required this.doctorType,
    required this.onTapEdit,
    required this.onTapCall,
    required this.onTapMessage,
    required this.onTapEmail,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colors.surface,
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onTapEdit,
              child: Icon(Icons.edit_note_rounded, size: 20),
            ),
          ),

          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: context.colors.tertiary.withAlpha(40),
                    child: Text(
                      _getFirstLetters(name),
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colors.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctorType[0].toUpperCase() + doctorType.substring(1),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: onTapCall,
                    label: Text('Call'),
                    icon: Icon(Icons.phone_in_talk_outlined),
                  ),
                  OutlinedButton.icon(
                    onPressed: onTapMessage,
                    label: Text('Message'),
                    icon: Icon(Icons.chat_bubble_outline_rounded),
                  ),
                  OutlinedButton.icon(
                    onPressed: onTapEmail,
                    label: Text('Email'),
                    icon: Icon(Icons.email_outlined),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
