import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;

  const CustomTextArea({
    super.key,
    required this.controller,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: AppColors.border.withAlpha(20), width: 0.5),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        minLines: 4,
        maxLines: 20,
        controller: controller,
        decoration: InputDecoration(
          labelText: placeholder,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
