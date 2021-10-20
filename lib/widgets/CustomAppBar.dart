import 'package:autosilentflutter/screens/settings.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends ViewModelWidget<MainViewModel> {
  @override
  Widget build(BuildContext context, MainViewModel vModel) {
    return vModel.multiSelect
        ? AppBar(
            title: Text(vModel.selected.length.toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                vModel.cancelSelection();
              },
            ),
            actions: [
              vModel.multiSelect
                  ? IconButton(
                      tooltip: 'delete'.tr(),
                      icon: Icon(Icons.delete_rounded),
                      onPressed: () {
                        vModel.deleteAllSelected();
                      })
                  : Container(),
              vModel.multiSelect
                  ? IconButton(
                      tooltip: 'select_all'.tr(),
                      icon: Icon(
                        vModel.selected.length == vModel.data.length
                            ? Icons.check_circle_rounded
                            : Icons.check_circle_outline_rounded,
                      ),
                      onPressed: () {
                        vModel.selectAll();
                      })
                  : Container(),
            ],
            elevation: 0.0,
          )
        : Container(
            child: FloatingSearchAppBar(
              controller: vModel.getController(),
              hint: 'app_name'.tr(),
              hideKeyboardOnDownScroll: true,
              title: Text(
                'app_name'.tr(),
              ),
              alwaysOpened: false,
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    tooltip: 'settings'.tr(),
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {
                      vModel.openSearchBar();
                    },
                  ),
                ),
                FloatingSearchBarAction(
                  child: PopupMenuButton(
                      onSelected: (String selected) {
                        // vModel.handle
                      },
                      padding: EdgeInsets.zero,
                      // initialValue: choices[_selection],
                      itemBuilder: (BuildContext context) {
                        return vModel.getMenuItems().map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      }),
                )
              ],
              // insets: EdgeInsets.symmetric(horizontal: 16.0),
              body: Container(height: kToolbarHeight, color: Colors.red),
            ),
          );
  }
}
