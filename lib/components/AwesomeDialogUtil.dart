import 'dart:async';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AwesomeDialogUtil {
  static Future<void> showInfo(BuildContext context, String title, String message) async {
    return _showDialog(context, title, message, DialogType.info);
  }

  static Future<void> showSuccess(BuildContext context, String title, String message) async {
    return _showDialog(context, title, message, DialogType.success);
  }

  static Future<void> showError(BuildContext context, String title, String message) async {
    return _showDialog(context, title, message, DialogType.error);
  }

  static Future<void> showWarning(BuildContext context, String title, String message) async {
    return _showDialog(context, title, message, DialogType.warning);
  }

  static Future<void> showQuestion(BuildContext context, String title, String message) async {
    return _showDialog(context, title, message, DialogType.question);
  }

  static Future<void> _showDialog(BuildContext context, String title, String message, DialogType dialogType) async {
    Completer<void> completer = Completer<void>();
    try {
      AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.scale,
        title: title,
        desc: message,
        btnOkOnPress: () {
          completer.complete(); // Complete the Completer when the dialog button is pressed
        },
      )..show();
    } catch (e) {
      completer.completeError(e); // Complete with error if an exception occurs
    }
    return completer.future;
  }
}
