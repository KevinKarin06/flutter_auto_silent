import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/widgets/AddLocationDialog.dart';
import 'package:autosilentflutter/widgets/ConfirmDialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DialogService {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  void addLocationDialog() {
    showDialog(
      context: _navigationService.navigatorKey.currentContext,
      builder: (BuildContext context) => AddLocationDialog(),
    );
  }

  void deleteDialog() {
    showDialog(
      context: _navigationService.navigatorKey.currentContext,
      builder: (BuildContext context) => ConfirmDialog(),
    );
  }
}
