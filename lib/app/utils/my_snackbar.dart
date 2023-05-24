import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:posto_plus/app/utils/navigation_service.dart';

class MySnackBar {
  final String title;
  final String message;
  final ContentType type;

  MySnackBar({
    required this.title,
    required this.message,
    required this.type,
  }) {
    _showSnackBar();
  }

  _showSnackBar() {
    late SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: '   $title',
        message: '     $message',
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
