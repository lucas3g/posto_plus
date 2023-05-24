import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:posto_plus/app/app_module.dart';
import 'package:posto_plus/app/app_widget.dart';

Future<void> main() async {
  await initializeDateFormatting(await findSystemLocale(), '');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
