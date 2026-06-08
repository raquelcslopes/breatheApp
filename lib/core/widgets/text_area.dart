import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/extensions/text_style.dart';
import 'package:breathe/core/widgets/ruled_painter.dart';
import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomTextArea({
    super.key,
    required this.controller,
    this.hint = 'Write freely about today…',
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const RuledPaperPainter(lineHeight: 26),
      child: TextField(
        controller: controller,
        autofocus: true,
        maxLines: null,
        minLines: 10,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: context.colors.primary,
        cursorWidth: 2,
        style: AppTextStyles.diaryBody.copyWith(
          color: context.colors.onSurface,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          hintStyle: AppTextStyles.diaryHint,
        ),
      ),
    );
  }
}
