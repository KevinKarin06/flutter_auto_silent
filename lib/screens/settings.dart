import 'package:autosilentflutter/view_models/SettingsViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (SettingsViewModel model) {},
      builder: (BuildContext context, SettingsViewModel sModel, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr()),
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  //reset settings
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('reset_settings').tr(),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Divider(),
                ListTile(
                  title: Text('language').tr(),
                  subtitle: Text(
                    sModel.getCurrentLocale().toString(),
                  ).tr(),
                  onTap: () {
                    sModel.setLanguage();
                  },
                  minLeadingWidth: 20.0,
                  leading: Align(
                    widthFactor: 0,
                    child: Icon(Icons.language_rounded),
                  ),
                  minVerticalPadding: 8.0,
                ),
                Divider(),
                CustomSwitch(
                  leftText: 'dark'.tr(),
                  rightText: 'light'.tr(),
                  label: 'theme'.tr(),
                  defaultValue: sModel.getTheme(),
                  onValueChanged: (val) {
                    sModel.toggleDarkMode(val);
                  },
                ),
                CustomSwitch(
                  leftText: 'no'.tr(),
                  rightText: 'yes'.tr(),
                  label: 'notify_on_entry'.tr(),
                  defaultValue: sModel.getNotifyOnEntry(),
                  onValueChanged: (val) {
                    sModel.setNotifyOnEntry(val);
                  },
                ),
                CustomSwitch(
                  leftText: 'no'.tr(),
                  rightText: 'yes'.tr(),
                  label: 'notify_on_exit'.tr(),
                  defaultValue: sModel.getNotifyOnExit(),
                  onValueChanged: (val) {
                    sModel.setNotifyOnExit(val);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
