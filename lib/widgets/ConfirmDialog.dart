import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(
          'delete'.tr(),
        ),
      ),
      elevation: 12,
      content: Container(
        child: Center(
          child: Text(
            plural('confirm_delete', GetIt.I<HomeViewModel>().selected.length),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            GetIt.I<HomeViewModel>().cancelSelection();
            Navigator.pop(context);
          },
          child: Text('cancel'.tr()),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            GetIt.I<HomeViewModel>().bactDelete();
          },
          child: Text(
            'delete'.tr(),
          ),
        ),
      ],
    );
  }
}
