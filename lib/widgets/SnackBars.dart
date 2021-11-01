import 'package:autosilentflutter/theme/theme.dart';
import 'package:flutter/material.dart';

//
SnackBar buildSnackBar(String msg, {SnackBarType type = SnackBarType.success}) {
  return SnackBar(
    backgroundColor:
        type == SnackBarType.success ? AppColors.success : AppColors.error,
    duration: type == SnackBarType.success
        ? Duration(seconds: 2)
        : Duration(seconds: 4),
    content: Text(msg),
  );
}

enum SnackBarType { error, success }
