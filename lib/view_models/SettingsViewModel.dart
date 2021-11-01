import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/SettingsService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsViewModel extends MultipleFutureViewModel {
  final SettingsService _settingsService = GetIt.I<SettingsService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final List<String> locales = ['fr', 'en'];
  static const String _NotifyOnEntry = 'notifyOnEntry';
  static const String _NotifyOnExit = 'notifyOnExit';
  static const String _ActionOnEntry = 'actionOnEntry';
  //
  void toggleDarkMode(bool themeMode) {
    _settingsService.setTheme(themeMode);
    notifyListeners();
  }

  bool getTheme() {
    ThemeModel theme = _settingsService.getTheme();
    return theme.themeMode == ThemeMode.light;
  }

  void setLanguage() {
    _dialogService.localeDialog();
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

  bool get fetchedNotifyOnEntry => dataMap[_NotifyOnEntry];
  bool get fetchedNotifyOnExit => dataMap[_NotifyOnExit];
  bool get fetchedActionOnEntry => dataMap[_ActionOnEntry];

  bool get fetchtingNotifyOnEntry => busy(_NotifyOnEntry);
  bool get fetchtingNotifyOnExit => busy(_NotifyOnExit);
  bool get fetchtingActionOnEnrty => busy(_ActionOnEntry);

  Future<bool> getNotifyOnEntry() async {
    return await _settingsService.getNotifyOnEntry();
  }

  Future<bool> getNotifyOnExit() async {
    return await _settingsService.getNotifyOnExit();
  }

  Future<bool> getActionOnEntry() async {
    return await _settingsService.getNotifyOnExit();
  }

  setNotifyOnEntry(bool b) async {
    await _settingsService.setNotifyOnEntry(b);
  }

  setNotifyOnExit(bool b) async {
    await _settingsService.setNotifyOnExit(b);
    notifyListeners();
  }

  @override
  Map<String, Future Function()> get futuresMap => {
        _NotifyOnEntry: getNotifyOnEntry,
        _NotifyOnExit: getNotifyOnExit,
        _ActionOnEntry: getActionOnEntry
      };
}
