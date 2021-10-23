import 'package:autosilentflutter/view_models/DialogViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class AddLocationDialog extends StatelessWidget {
  const AddLocationDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DialogViewModel(),
      builder: (BuildContext context, DialogViewModel dModel, Widget child) =>
          WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'add_location'.tr(),
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
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
                          onTap: () {},
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
        ),
      ),
    );
  }
}
