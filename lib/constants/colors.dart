import 'package:autosilentflutter/services/SettingsService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppColors {
  final SettingsService _settingsService = GetIt.I<SettingsService>();
  Color appBarColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.dark
        ? Color(0x42000000)
        : Colors.cyan;
  }

  Color customSwitchBorderColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.dark
        ? Colors.cyan
        : Colors.cyan;
  }

  Color customSwitchTextColor(bool selected) {
    if (!selected) {
      return _settingsService.getTheme().themeMode == ThemeMode.dark
          ? Colors.white
          : Colors.black;
    } else
      return _settingsService.getTheme().themeMode == ThemeMode.dark
          ? Colors.white
          : Colors.black;
  }

  Color customSwitchLabelColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.light
        ? Colors.black
        : Colors.cyan;
  }

  Color errorColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.light
        ? Colors.red
        : Colors.red.shade300;
  }
}
