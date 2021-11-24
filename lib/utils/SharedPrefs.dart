import 'package:autosilentflutter/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
      _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool get notifyOnEntry =>
      _sharedPrefs.getBool(Constants.NOTIFY_ON_ENTRY) ?? true;
  bool get notifyOnExit =>
      _sharedPrefs.getBool(Constants.NOTIFY_ON_EXIT) ?? true;

  Future<void> setnotifyOnEntry(bool val) async {
    await _sharedPrefs.setBool(Constants.NOTIFY_ON_ENTRY, val);
  }

  Future<void> setnotifyOnExit(bool val) async {
    await _sharedPrefs.setBool(Constants.NOTIFY_ON_EXIT, val);
  }
}
