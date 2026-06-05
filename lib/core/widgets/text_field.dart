import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final IconData? icon;
  final String placeholder;
  final bool? obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.placeholder,
    this.icon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboard,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: const Color.fromARGB(255, 165, 159, 138),
            ),
            labelText: placeholder,
            prefixIcon: Icon(
              icon,
              size: 18,
              color: const Color.fromARGB(255, 165, 159, 138),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 0,
            ),
          ),
        ),
      ),
    );
  }
}
