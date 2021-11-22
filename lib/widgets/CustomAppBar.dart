import 'package:autosilentflutter/constants/colors.dart';
import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends ViewModelWidget<HomeViewModel>
    with PreferredSizeWidget {
  final double appBarElevation = 4.0;

  @override
  Widget build(BuildContext context, HomeViewModel vModel) {
    Logger().d('Custom AppBar', 'Rebuilt');
    return SafeArea(
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(scale: animation, child: child),
        duration: Duration(milliseconds: 500),
        child: vModel.multiSelect
            ? Material(
                color: AppColors().appBarColor(),
                elevation: appBarElevation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'back'.tr(),
                              onPressed: () {
                                vModel.cancelSelection();
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 24.0,
                              width: 24.0,
                              child: Center(
                                child: Text(
                                  vModel.selected.length.toString(),
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                tooltip: 'delete'.tr(),
                                icon: Icon(Icons.delete_rounded),
                                onPressed: () {
                                  vModel.deleteAllSelected();
                                }),
                            IconButton(
                                tooltip: 'select_all'.tr(),
                                icon: Icon(
                                  vModel.selected.length ==
                                          vModel.locations.length
                                      ? Icons.check_circle_rounded
                                      : Icons.check_circle_outline_rounded,
                                ),
                                onPressed: () {
                                  vModel.selectAll();
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                child: FloatingSearchAppBar(
                  elevation: appBarElevation,
                  padding: EdgeInsets.only(left: 16.0),
                  color: AppColors().appBarColor(),
                  debounceDelay: Duration(milliseconds: 500),
                  height: kToolbarHeight,
                  onQueryChanged: (String val) {
                    Logger().d('message', val);
                    vModel.filterLocation(val);
                  },
                  onSubmitted: (String val) {
                    vModel.filterLocation(val);
                  },
                  controller: vModel.getController(),
                  hint: 'search'.tr(),
                  hideKeyboardOnDownScroll: true,
                  title: Text(
                    'app_name'.tr(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  alwaysOpened: false,
                  actions: [
                    FloatingSearchBarAction(
                      showIfOpened: vModel.showCancelIcon,
                      showIfClosed: false,
                      child: CircularButton(
                        tooltip: 'clear'.tr(),
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          vModel.clearSearchBarText();
                        },
                      ),
                    ),
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
                            vModel.handleMenuItemClick(selected);
                            print(selected);
                          },
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context) {
                            return vModel.menuItems
                                .asMap()
                                .entries
                                .map((entry) {
                              return PopupMenuItem<String>(
                                value: entry.key.toString(),
                                child: Text(entry.value).tr(),
                              );
                            }).toList();
                          }),
                    )
                  ],
                  body: Container(),
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, kToolbarHeight);
}
