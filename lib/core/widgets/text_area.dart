import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextArea({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      autofocus: true,
      cursorColor: AppColors.forestDeep,
      cursorWidth: 2,
      minLines: 4,
      maxLines: 20,
      controller: controller,
      decoration: const InputDecoration(
        fillColor: Colors.transparent,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText:
            'Take your time. Writing is just for you — only if it feels right',
        border: InputBorder.none,
      ),
    );
  }
}
