import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsService {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('notify_on_entry', value);
  }

  Future<void> setNotifyOnExit(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('notify_on_exit', value);
  }

  Future<void> setActionOnEnrty() async {}
  Future<void> setActionOnExit() async {}
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

  Future<bool> getNotifyOnEntry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('notify_on_entry') ?? true;
  }

  Future<bool> getNotifyOnExit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('notify_on_exit') ?? true;
  }

  Future<void> getActionOnEnrty() async {}
  Future<void> getActionOnExit() async {}
  //
  Future<void> reset() async {}
}
