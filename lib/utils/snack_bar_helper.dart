import 'package:flutter/material.dart';

class GlobalSnackbar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
