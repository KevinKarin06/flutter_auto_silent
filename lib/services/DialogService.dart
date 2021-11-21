import 'package:autosilentflutter/widgets/ConfirmDialog.dart';
import 'package:autosilentflutter/widgets/LanguageDialog.dart';
import 'package:autosilentflutter/widgets/LocationBottomSheet.dart';
import 'package:autosilentflutter/widgets/PermissionDialog.dart';
import 'package:autosilentflutter/widgets/SnackBars.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class DialogService {
  //
  void addLocationDialog() {
    OneContext().showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
        ),
        builder: (BuildContext context) => LocationBottomSheet());
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

  void deleteProgress() {
    OneContext().showProgressIndicator();
    // OneContext().showProgressIndicator(builder: (_) => DeletingDialog());
  }

  void loadingDialog() {
    OneContext().showProgressIndicator();
  }

  void stopLading() {
    OneContext().hideProgressIndicator();
  }

  void showSuccess(String msg) {
    OneContext().showSnackBar(
      builder: (_) => buildSnackBar(msg, type: SnackBarType.success),
    );
  }

  void showError(String msg) {
    OneContext().showSnackBar(
      builder: (_) => buildSnackBar(msg, type: SnackBarType.error),
    );
  }

  void showPermissionDialog(String msg, Function onGrant) {
    OneContext().showDialog(
      builder: (BuildContext context) =>
          PermissionDialog(msg: msg, onGrant: onGrant),
    );
  }
}
