import 'package:autosilentflutter/view_models/AutoCompleteViewModel.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class AutoCompleteLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AutoCompleteViewModel(),
      builder:
          (BuildContext context, AutoCompleteViewModel vModel, Widget child) =>
              Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr()),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}
