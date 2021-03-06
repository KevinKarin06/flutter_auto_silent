import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToSettings(String routeName) async {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAbout(String routeName) async {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAutoComplete() async {
    return navigatorKey.currentState.pushNamed(AppRouter.searchLocation);
  }

  Future<dynamic> navigateToLocationDetails(
      String routeName, LocationModel model) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: model);
  }

  Future<dynamic> navigateToLocationDetailsAndReplace(
      String routeName, LocationModel model) async {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: model);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
