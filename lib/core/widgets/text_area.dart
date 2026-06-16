import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;
  final int fillAlpha;

  const CustomTextArea({
    super.key,
    required this.controller,
    this.hint = 'Write freely about today…',
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    this.borderRadius = 20,
    this.blur = 12,
    this.fillAlpha = 80,
  });

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
            splashColor: context.colors.surface.withAlpha(26),
            highlightColor: context.colors.surface.withAlpha(13),
            child: Container(
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
                  controller: controller,
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: TextInputAction.newline,
                  style: context.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintText: hint,
                    hintStyle: context.textTheme.headlineMedium?.copyWith(
                      color: context.colors.outline,
                      fontSize: 16,
                    ),
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
