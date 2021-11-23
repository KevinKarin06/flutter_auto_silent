import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsService {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final SharedPrefs prefs = SharedPrefs();
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
    await prefs.setnotifyOnEntry(value);
  }

  Future<void> setNotifyOnExit(bool value) async {
    await prefs.setnotifyOnExit(value);
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
    return prefs.notifyOnEntry;
  }

  bool getNotifyOnExit() {
    return prefs.notifyOnExit;
  }

  //
  Future<void> reset() async {}
}
