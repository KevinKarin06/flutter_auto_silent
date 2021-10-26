import 'package:autosilentflutter/view_models/AddLocationDialogViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class AddLocationDialog extends StatelessWidget {
  const AddLocationDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => AddLocationDialogViewModel(),
      builder: (BuildContext context, AddLocationDialogViewModel dModel,
              Widget child) =>
          WillPopScope(
        onWillPop: () async {
          return Future.delayed(
            Duration(milliseconds: 100),
            () => Future.value(true),
          );
        },
        child: SimpleDialog(
          title: Center(
            child: Text(
              'add_location'.tr(),
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Divider(
                    height: 0,
                  ),
                  Container(
                    height: 50,
                    child: InkWell(
                      child: Center(
                        child: Text(
                          'current_location'.tr(),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                  Container(
                    height: 50,
                    child: InkWell(
                      child: Center(
                        child: Text(
                          'search_location'.tr(),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        dModel.searchLocationOnline();
                      },
                    ),
                  ),
                  Divider(
                    height: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
