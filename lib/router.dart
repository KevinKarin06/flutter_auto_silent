import 'package:autosilentflutter/screens/about.dart';
import 'package:autosilentflutter/screens/intro.dart';
import 'package:autosilentflutter/screens/location_details.dart';
import 'package:autosilentflutter/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/LocationModel.dart';

class AppRouter {
  static const String home = '/';
  static const String setting = '/settings';
  static const String about = '/about';
  static const String details = '/details';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Intro());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case details:
        LocationModel model = settings.arguments as LocationModel;
        return MaterialPageRoute(builder: (_) => LocationDetails());
        break;
      default:
        return MaterialPageRoute(builder: (_) => Intro());
    }
  }
}
