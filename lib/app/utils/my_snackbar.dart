import 'package:flutter/material.dart';
import 'package:posto_plus/app/utils/navigation_service.dart';

enum TypeSnack { success, error, warning, help }

class MySnackBar {
  final String title;
  final String message;
  final TypeSnack type;

  MySnackBar({
    required this.title,
    required this.message,
    required this.type,
  }) {
    _showSnackBar();
  }

  Color _returnBackgroundColor() {
    if (type == TypeSnack.success) {
      return Colors.green.shade800;
    }
    if (type == TypeSnack.error) {
      return Colors.red.shade800;
    }
    if (type == TypeSnack.warning) {
      return Colors.amber.shade800;
    }

    return Colors.blue.shade800;
  }

  _showSnackBar() {
    late SnackBar snackBar = SnackBar(
      backgroundColor: _returnBackgroundColor(),
      elevation: 8,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
