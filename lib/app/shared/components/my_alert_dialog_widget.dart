// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:posto_plus/app/core_module/constants/constants.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/utils/constants.dart';

class MyAlertDialogWidget extends StatefulWidget {
  final String title;
  final String content;
  final String? subContent;
  final Widget? okButton;
  final Widget? cancelButton;

  const MyAlertDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    this.subContent,
    this.okButton,
    this.cancelButton,
  }) : super(key: key);

  @override
  State<MyAlertDialogWidget> createState() => _MyAlertDialogWidgetState();
}

class _MyAlertDialogWidgetState extends State<MyAlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeModeController.themeMode == ThemeMode.dark
          ? backgroundBlack
          : context.myTheme.background,
      elevation: 8,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: context.textTheme.titleMedium,
          ),
          const Divider(),
          Text(
            widget.content,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.subContent ?? '',
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: widget.cancelButton ?? const SizedBox(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: widget.okButton ?? const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
