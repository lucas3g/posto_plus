import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posto_plus/app/shared/stores/app_store.dart';
import 'package:posto_plus/app/utils/navigation_service.dart';

class ThemeModeController {
  static ThemeMode get themeMode =>
      NavigationService.navigatorKey.currentContext!
          .watchModular<AppStore>((store) => store.themeMode)
          .themeMode
          .value;
  static AppStore get appStore => NavigationService.navigatorKey.currentContext!
      .watchModular<AppStore>((store) => store.themeMode);
}
