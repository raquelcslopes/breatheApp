import 'dart:ui';

import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryPreview extends ConsumerStatefulWidget {
  final JournalEntry entry;
  final bool isReadOnly;
  final TextEditingController controller;

  const EntryPreview({
    super.key,
    required this.entry,
    required this.isReadOnly,
    required this.controller,
  });

  @override
  ConsumerState<EntryPreview> createState() => _EntryPreviewState();
}

class _EntryPreviewState extends ConsumerState<EntryPreview> {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 15,
  );
  final double borderRadius = 20;
  final double blur = 12;
  final Color tint = AppColors.background;
  final int fillAlpha = 80;

  //--------------------- FUNCTIONS ---------------------

  //--------------------- WIDGETS ---------------------

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            splashColor: tint.withAlpha(26),
            highlightColor: tint.withAlpha(13),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: radius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    tint.withAlpha(fillAlpha + 13),
                    tint.withAlpha((fillAlpha * 0.5).round()),
                  ],
                ),
                border: Border.all(color: tint.withAlpha(64), width: 1),
              ),
              child: DefaultTextStyle.merge(
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                ),
                child: TextFormField(
                  readOnly: widget.isReadOnly,
                  controller: widget.controller,
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
