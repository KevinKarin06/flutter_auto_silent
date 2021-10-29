import 'package:autosilentflutter/view_models/SettingsViewModel.dart';
import 'package:autosilentflutter/widgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      disposeViewModel: true,
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (SettingsViewModel model) {
        model.getNotifyOnEntry();
        model.getNotifyOnExit();
      },
      builder: (BuildContext context, SettingsViewModel sModel, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text('settings'.tr()),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: Text('language').tr(),
                  subtitle: Text(
                    sModel.getCurrentLocale().toString(),
                  ).tr(),
                  onTap: () {
                    sModel.setLanguage();
                  },
                  leading: Icon(Icons.language_rounded),
                  minVerticalPadding: 8.0,
                ),
                CustomSwitch(
                  leftText: 'dark'.tr(),
                  rightText: 'light'.tr(),
                  label: 'theme'.tr(),
                  defaultValue: sModel.getTheme(),
                  onValueChanged: (val) {
                    sModel.toggleDarkMode(val);
                  },
                ),
                !sModel.isBusy
                    ? CustomSwitch(
                        leftText: 'no'.tr(),
                        rightText: 'yes'.tr(),
                        label: 'notify_on_entry'.tr(),
                        defaultValue: sModel.notifyOnEntry,
                        onValueChanged: (val) {
                          sModel.setNotifyOnEntry(val);
                        },
                      )
                    : LinearProgressIndicator(),
                !sModel.isBusy
                    ? CustomSwitch(
                        leftText: 'no'.tr(),
                        rightText: 'yes'.tr(),
                        label: 'notify_on_exit'.tr(),
                        defaultValue: sModel.notifyOnExit,
                        onValueChanged: (val) {
                          Logger().d('on_entry', val);
                          sModel.setNotifyOnExit(val);
                        },
                      )
                    : LinearProgressIndicator(),
                CustomSwitch(
                  leftText: 'silent_mode'.tr(),
                  rightText: 'air_plane_mode'.tr(),
                  label: 'action_on_entry'.tr(),
                  defaultValue: sModel.notifyOnExit,
                  onValueChanged: (val) {
                    sModel.setNotifyOnExit(val);
                  },
                ),
                // CustomSwitch(
                //   leftText: 'silent_mode'.tr(),
                //   rightText: 'air_plane_mode'.tr(),
                //   label: 'action_on_exit'.tr(),
                //   defaultValue: sModel.notifyOnExit,
                //   onValueChanged: (val) {
                //     sModel.setNotifyOnExit(val);
                //   },
                // ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('reset_settings').tr(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
