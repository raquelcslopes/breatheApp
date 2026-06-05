import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmergencyPerson extends StatefulWidget {
  const EmergencyPerson({super.key});

  @override
  State<EmergencyPerson> createState() => _EmergencyPersonState();
}

class _EmergencyPersonState extends State<EmergencyPerson> {
  Widget _nameInitials(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.danger.withAlpha(80),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        'LT',
        style: context.textTheme.headlineMedium?.copyWith(
          color: AppColors.surface,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _callItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.danger.withAlpha(80),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.phone_outlined, color: AppColors.surface, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.borderSoft, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nameInitials(context),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leonardo  Teixeira',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Trusted person - one tap to call',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              _callItem(),
            ],
          ),
          const SizedBox(height: 10),
          Divider(radius: BorderRadius.circular(5)),
          const SizedBox(height: 10),
          Text(
            'If things feel like too much right now, reaching out can help',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
