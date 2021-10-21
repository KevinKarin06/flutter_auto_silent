import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToSettings(String routeName) async {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAbout(String routeName) async {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToLocationDetails(
      String routeName, LocationModel model) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: model);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
