import 'package:flutter/material.dart';

class TextFaildWidget extends StatelessWidget {
  const TextFaildWidget({
    Key? key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.obscure = false,
    this.maxLines = 1,
    this.autofocus = false,
    this.isPrefixIcon = false,
    this.isSuffixIcon = false,
    this.borderRadius = 20,
    this.suffixIconSize = 24,
    this.maxLength,
    this.prefixIcon = Icons.person,
    this.suffixIcon = Icons.person,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscure;
  final double suffixIconSize;
  final double borderRadius;
  final bool isPrefixIcon;
  final bool autofocus;
  final bool isSuffixIcon;
  final TextInputType inputType;
  final IconData suffixIcon;
  final IconData prefixIcon;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscure,
      autofocus: autofocus,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
          // filled: true,
          // fillColor: kcGreyVeryLight,
          focusColor: Colors.red,
          prefixIcon: isPrefixIcon ? Icon(prefixIcon) : const SizedBox(),
          suffixIcon: isSuffixIcon
              ? Icon(suffixIcon, size: suffixIconSize)
              : const SizedBox(),
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
      controller: controller,
    );
  }
}
