import 'package:breathe/core/extensions/context_extensions.dart';
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
    return TextFormField(
      controller: controller,
      expands: true,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      textInputAction: TextInputAction.newline,
      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,

        isDense: true,
        contentPadding: EdgeInsets.zero,

        fillColor: Colors.transparent,
        filled: false,

        hintText: hint,
        hintStyle: context.textTheme.headlineMedium?.copyWith(
          color: context.colors.outline,
          fontSize: 16,
        ),
      ),
    );
  }
}
