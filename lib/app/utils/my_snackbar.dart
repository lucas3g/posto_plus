import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/navigation_service.dart';

enum TypeSnack { success, error, warning, help }

class MySnackBar {
  final String title;
  final String message;
  final TypeSnack type;
  final int duration;

  MySnackBar({
    required this.title,
    required this.message,
    required this.type,
    this.duration = 4,
  }) {
    _showSnackBar();
  }

  Color _returnBackgroundColor() {
    if (type == TypeSnack.success) {
      return Colors.green.shade800;
    }
    if (type == TypeSnack.error) {
      return ThemeModeController.themeMode == ThemeMode.dark
          ? NavigationService
              .navigatorKey.currentContext!.myTheme.primaryContainer
          : NavigationService.navigatorKey.currentContext!.myTheme.primary;
    }
    if (type == TypeSnack.warning) {
      return Colors.yellow.shade900;
    }

    return Colors.blue.shade800;
  }

  String _returnLottieFile() {
    if (type == TypeSnack.success) {
      return "assets/images/failed.json";
    }
    if (type == TypeSnack.error) {
      return "assets/images/failed.json";
    }
    if (type == TypeSnack.warning) {
      return "assets/images/warning.json";
    }

    return "assets/images/info.json";
  }

  _showSnackBar() {
    late SnackBar snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.fixed,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: title.contains('internet')
                ? 130
                : type == TypeSnack.warning || type == TypeSnack.help
                    ? 100
                    : 90,
            decoration: BoxDecoration(
              color: _returnBackgroundColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 5,
            child: Lottie.asset(
              _returnLottieFile(),
              width: 50,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(
                        NavigationService.navigatorKey.currentContext!)
                    .hideCurrentSnackBar();
              },
              icon: const Icon(Icons.close),
              color: Colors.white,
            ),
          )
        ],
      ),
    );

    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
