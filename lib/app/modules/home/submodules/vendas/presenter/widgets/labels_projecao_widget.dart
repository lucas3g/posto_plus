import 'package:flutter/material.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';

class LabelsProjecaoWidget extends StatelessWidget {
  final String title;
  final double litros;
  final double venda;

  const LabelsProjecaoWidget({
    Key? key,
    required this.title,
    required this.litros,
    required this.venda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: ThemeModeController.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Text(
          '${litros.Litros()} LT',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          venda.reais(),
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
