import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => GetIt.I<MainViewModel>(),
      builder: (BuildContext context, MainViewModel viewModel, Widget child) =>
          AlertDialog(
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
              plural('confirm_delete', viewModel.selected.length),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.cancelSelection();
              Navigator.pop(context);
            },
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.deleteAllSelected();
            },
            child: Text(
              'delete'.tr(),
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
