import 'package:flutter/material.dart';
import 'package:posto_plus/app/core_module/services/themeMode/theme_mode_service.dart';

class AppStore {
  final IThemeMode _service;

  AppStore(this._service) {
    init();
  }

  final themeMode = ValueNotifier(ThemeMode.dark);

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    saveThemeMode();
  }

  void init() {
    final model = _service.getThemeMode();

    themeMode.value = _getThemeModeByName(model.themeModeName);
  }

  Future saveThemeMode() async {
    await _service.saveThemeMode(themeMode.value.name);
  }

  ThemeMode _getThemeModeByName(String name) {
    return ThemeMode.values.firstWhere((mode) => mode.name == name);
  }
}
