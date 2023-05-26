import 'package:flutter/material.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:posto_plus/app/modules/home/submodules/cr/domain/entities/cr.dart';
import 'package:posto_plus/app/utils/constants.dart';
import 'package:posto_plus/app/utils/formatters.dart';

class MyListTileCRWidget extends StatefulWidget {
  final CR cr;
  const MyListTileCRWidget({
    Key? key,
    required this.cr,
  }) : super(key: key);

  @override
  State<MyListTileCRWidget> createState() => _MyListTileCRWidgetState();
}

class _MyListTileCRWidgetState extends State<MyListTileCRWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(widget.cr.nome.value),
          ),
          Text(
            widget.cr.valor.value.reais(),
            style: ThemeModeController.themeMode == ThemeMode.dark
                ? context.textTheme.bodyLarge!.copyWith(
                    color: const Color(0xffCB5252),
                    fontWeight: FontWeight.bold,
                  )
                : context.textTheme.bodyLarge!.copyWith(
                    color: context.myTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ],
      ),
    );
  }
}
