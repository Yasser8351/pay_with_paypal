import 'package:flutter/material.dart';

class ReceiptConfig {
  final TextConfig title;
  final TextConfig value;
  final Color? backgroundColor;
  final double? borderRadius;
  ReceiptConfig({
    required this.title,
    required this.value,
    this.backgroundColor,
    this.borderRadius,
  });
}

class TextConfig {
  final String data;
  final TextDirection? textDirection;
  final Color? color;
  final FontWeight? fontWeight;
  final bool? copyable;
  final bool amount;
  TextConfig(
    this.data, {
    this.textDirection,
    this.color,
    this.fontWeight,
    this.copyable,
  }) : amount = false;

  TextConfig.title(
    this.data, {
    this.textDirection,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
    this.copyable = false,
  }) : amount = false;

  TextConfig.amount(
    this.data, {
    this.textDirection = TextDirection.ltr,
    this.color = Colors.black,
    this.fontWeight = FontWeight.bold,
    this.copyable = false,
  }) : amount = true;
}
