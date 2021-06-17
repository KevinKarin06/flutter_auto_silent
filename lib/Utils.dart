import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Future<bool> isConnected() async {
    bool connected = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } on SocketException catch (_) {}
    return connected;
  }

  static String generateuuid() {
    return Uuid().v4();
  }

  static String capitalize(String string) {
    string = string.trim();
    if (string.length <= 1) return string.toUpperCase();
    var words = string.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }
}
