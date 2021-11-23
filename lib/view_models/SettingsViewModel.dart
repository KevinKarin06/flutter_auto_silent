import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/SettingsService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingsViewModel extends BaseViewModel {
  final SettingsService _settingsService = GetIt.I<SettingsService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final List<String> locales = ['fr', 'en'];

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

  bool getNotifyOnEntry() {
    return _settingsService.getNotifyOnEntry();
  }

  bool getNotifyOnExit() {
    return _settingsService.getNotifyOnExit();
  }

  setNotifyOnEntry(bool b) async {
    try {
      await _settingsService.setNotifyOnEntry(b);
    } catch (e) {
      _dialogService.showError('msg');
    }
    notifyListeners();
  }

  setNotifyOnExit(bool b) async {
    try {
      await _settingsService.setNotifyOnExit(b);
    } catch (e) {
      _dialogService.showError('msg');
    }
    notifyListeners();
  }
}
