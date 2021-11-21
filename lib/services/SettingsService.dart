import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsService {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final hiveBox = Hive.box('settings');
  //
  void setTheme(bool themeMode) async {
    if (themeMode) {
      getThemeManager(_navigationService.navigatorKey.currentContext)
          .setThemeMode(ThemeMode.light);
    } else
      getThemeManager(_navigationService.navigatorKey.currentContext)
          .setThemeMode(ThemeMode.dark);
  }

  Future<void> setNotifyOnEntry(bool value) async {
    await hiveBox.put('notify_on_entry', value);
  }

  Future<void> setNotifyOnExit(bool value) async {
    await hiveBox.put('notify_on_exit', value);
  }

  Future<void> setActionOnEnrty(bool value) async {
    await hiveBox.put('action_on_entry', value);
  }

  void setLocale(String locale) {
    Locale lang = Locale(locale);
    _navigationService.navigatorKey.currentContext.setLocale(lang);
  }

  //
  Locale getLocale() {
    return _navigationService.navigatorKey.currentContext.locale;
  }

  ThemeModel getTheme() {
    return getThemeManager(_navigationService.navigatorKey.currentContext)
        .getSelectedTheme();
  }

  bool getNotifyOnEntry() {
    return hiveBox.get('notify_on_entry', defaultValue: true);
  }

  bool getNotifyOnExit() {
    return hiveBox.get('notify_on_exit', defaultValue: true);
  }

  bool getActionOnEnrty() {
    return hiveBox.get('action_on_entry', defaultValue: true);
  }

  int getTransitionDwellTime() {
    return hiveBox.get('dwell_time', defaultValue: 15);
  }

  //
  Future<void> reset() async {}
}
