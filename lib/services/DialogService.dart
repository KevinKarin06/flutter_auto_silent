import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/services/ProgressDialog.dart';
import 'package:autosilentflutter/widgets/AddLocationDialog.dart';
import 'package:autosilentflutter/widgets/ConfirmDialog.dart';
import 'package:autosilentflutter/widgets/LanguageDialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:one_context/one_context.dart';

class DialogService {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  //
  void addLocationDialog() {
    OneContext().showDialog(
      builder: (BuildContext context) => AddLocationDialog(),
    );
  }

  void deleteDialog() {
    OneContext().showDialog(
      builder: (BuildContext context) => ConfirmDialog(),
    );
  }

  void localeDialog() {
    OneContext()
        .showDialog(builder: (BuildContext context) => LanguageDialog());
  }

  void loadingDialog() {
    OneContext().showProgressIndicator();
  }

  void stopLading() {
    OneContext().hideProgressIndicator();
  }

  void showSuccess() {
    OneContext()
        .showSnackBar(builder: (_) => SnackBar(content: Text('success')));
  }

  void showError() {
    OneContext()
        .showSnackBar(builder: (_) => SnackBar(content: Text('success')));
  }
}
