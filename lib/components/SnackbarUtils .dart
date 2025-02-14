import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackbarMessage(BuildContext context, String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
