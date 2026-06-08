import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/router/routes.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewEntryCard extends StatefulWidget {
  const NewEntryCard({super.key});

  @override
  State<NewEntryCard> createState() => _NewEntryCardState();
}

class _NewEntryCardState extends State<NewEntryCard> {
  double _scale = 1.0;

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.forest.withAlpha(80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.edit_outlined, color: AppColors.forest, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () => context.push(AppRoute.journalNewPath),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: context.colors.outline, width: 0.5),
            borderRadius: BorderRadius.circular(15),
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
              _icon(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New journal entry',
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      'Write a few words for today',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
