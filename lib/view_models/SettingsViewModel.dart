import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/SettingsService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsViewModel extends BaseViewModel {
  final SettingsService _settingsService = GetIt.I<SettingsService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final List<String> locales = ['fr', 'en'];
  bool notifyOnEntry = true;
  bool notifyOnExit = true;
  //
  void toggleDarkMode(bool themeMode) {
    _settingsService.setTheme(themeMode);
  }

  bool getTheme() {
    ThemeModel theme = _settingsService.getTheme();
    return theme.themeMode == ThemeMode.light;
  }

  void setLanguage() {
    _dialogService.localDialog();
  }

  Locale getCurrentLocale() {
    return _settingsService.getLocale();
  }

  void setLocale(String locale) {
    _settingsService.setLocale(locale);
  }

  bool selectedLocale(String locale) {
    Locale lang = Locale(locale);
    return lang == getCurrentLocale();
  }

  Future<void> getNotifyOnEntry() async {
    notifyOnEntry = await runBusyFuture(_settingsService.getNotifyOnEntry());
  }

  Future<void> getNotifyOnExit() async {
    notifyOnExit = await runBusyFuture(_settingsService.getNotifyOnExit());
  }

  setNotifyOnEntry(bool b) {
    runBusyFuture(_settingsService.setNotifyOnEntry(b));
    getNotifyOnEntry();
  }

  setNotifyOnExit(bool b) {
    runBusyFuture(_settingsService.setNotifyOnExit(b));
    getNotifyOnExit();
  }
}
