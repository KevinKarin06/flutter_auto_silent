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
          SimpleDialog(
        children: [
          Container(
            height: 50,
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_searching_rounded),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'current_location'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1,
          ),
          Container(
            height: 50,
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.place_rounded),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'search_location'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        title: Center(
          child: Text(
            'add_location'.tr(),
          ),
        ),
      ),
    );
  }
}
