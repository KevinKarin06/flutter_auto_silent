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
        : Colors.grey;
  }

  Color customSwitchSelectedTextColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.dark
        ? Colors.white
        : Colors.cyan;
  }

  Color customSwitchUnSelectedTextColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.dark
        ? Colors.white
        : Color(0x42000000);
  }

  Color customSwitchLabelColor() {
    return _settingsService.getTheme().themeMode == ThemeMode.light
        ? Color(0x42000000)
        : Colors.cyan;
  }
}
