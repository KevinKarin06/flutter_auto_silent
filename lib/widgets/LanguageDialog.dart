import 'package:autosilentflutter/view_models/SettingsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (BuildContext context, SettingsViewModel sModel, Widget child) =>
          WillPopScope(
        onWillPop: () async => true,
        child: SimpleDialog(
          title: Center(
            child: Text(
              'select_locale'.tr(),
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          children: [
            ...sModel.locales.asMap().entries.map((e) {
              return RadioListTile(
                toggleable: true,
                title: Text(e.value).tr(),
                value: e.value,
                groupValue: true,
                selected: sModel.selectedLocale(e.value),
                onChanged: (bool) {
                  sModel.setLocale(bool);
                  Navigator.pop(context);
                },
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
