import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends ViewModelWidget<MainViewModel>
    with PreferredSizeWidget {
  final double appBarElevation = 4.0;
  @override
  Widget build(BuildContext context, MainViewModel vModel) {
    print('AnimatedSwitcher Rebuilt...');
    return SafeArea(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: vModel.multiSelect
            ? Material(
                color: Colors.yellow[100],
                elevation: appBarElevation,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                vModel.cancelSelection();
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              color: Colors.red,
                              child: Text(
                                vModel.selected.length.toString(),
                                style: TextStyle(fontSize: 16.0),
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
                                  vModel.selected.length == vModel.data.length
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
                  height: kToolbarHeight,
                  onQueryChanged: (String val) {
                    vModel.filterLocation(val);
                  },
                  onSubmitted: (String val) {
                    vModel.filterLocation(val);
                  },
                  elevation: appBarElevation,
                  leadingActions: [
                    FloatingSearchBarAction(
                      showIfClosed: false,
                      showIfOpened: true,
                      child: CircularButton(
                        tooltip: 'back'.tr(),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          vModel.closeSearchBar();
                        },
                      ),
                    ),
                  ],
                  controller: vModel.getController(),
                  hint: 'app_name'.tr(),
                  hideKeyboardOnDownScroll: true,
                  title: Text(
                    'app_name'.tr(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  alwaysOpened: false,
                  actions: [
                    FloatingSearchBarAction(
                      showIfOpened: true,
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
                          // initialValue: choices[_selection],
                          itemBuilder: (BuildContext context) {
                            return vModel
                                .getMenuItems()
                                .asMap()
                                .entries
                                .map((entry) {
                              return PopupMenuItem<String>(
                                value: entry.key.toString(),
                                child: Text(entry.value),
                              );
                            }).toList();
                          }),
                    )
                  ],
                  body: null,
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, kToolbarHeight);
}
