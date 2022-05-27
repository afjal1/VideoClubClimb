import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context, {
  required String text,
  Color? backgroundColor = Colors.orange,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
    ),
  );
}
