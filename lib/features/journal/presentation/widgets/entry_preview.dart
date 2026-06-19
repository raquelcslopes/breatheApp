import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryPreview extends ConsumerWidget {
  final JournalEntry entry;
  final bool isReadOnly;
  final TextEditingController controller;

  const EntryPreview({
    super.key,
    required this.entry,
    required this.isReadOnly,
    required this.controller,
  });

  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 15,
  );
  final double borderRadius = 20;
  final double blur = 12;
  final int fillAlpha = 80;

  //--------------------- WIDGETS ---------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = BorderRadius.circular(borderRadius);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.surface.withAlpha(fillAlpha + 13),
            context.colors.surface.withAlpha((fillAlpha * 0.5).round()),
          ],
        ),
        border: Border.all(
          color: context.colors.surface.withAlpha(64),
          width: 1,
        ),
      ),
      child: DefaultTextStyle.merge(
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w300,
        ),
        child: TextFormField(
          readOnly: isReadOnly,
          controller: controller,
          autofocus: true,
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          textInputAction: TextInputAction.newline,
          style: context.textTheme.bodyLarge,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.transparent,
            isDense: true,
            contentPadding: EdgeInsets.zero,

            filled: false,
          ),
        ),
      ),
    );
  }
}
