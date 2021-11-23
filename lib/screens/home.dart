import 'package:autosilentflutter/screens/loading.dart';
import 'package:autosilentflutter/screens/no_location.dart';
import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchBar _searchBar;
  //
  _MyHomePageState() {
    _searchBar = new SearchBar(
      setState: setState,
      onChanged: (String val) {
        GetIt.I<HomeViewModel>().filterLocation(val);
      },
      buildDefaultAppBar: (BuildContext context) => AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text('app_name').tr(),
        ),
        actions: [
          AnimatedSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
            ) =>
                ScaleTransition(
              scale: animation,
              child: child,
            ),
            duration: Duration(milliseconds: 500),
            child: GetIt.I<HomeViewModel>().multiSelect
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          tooltip: 'delete'.tr(),
                          icon: Icon(Icons.delete_rounded),
                          onPressed: () {
                            GetIt.I<HomeViewModel>().deleteAllSelected();
                          }),
                      IconButton(
                          tooltip: 'select_all'.tr(),
                          icon: Icon(
                            GetIt.I<HomeViewModel>().selected.length ==
                                    GetIt.I<HomeViewModel>().locations.length
                                ? Icons.check_circle_rounded
                                : Icons.check_circle_outline_rounded,
                          ),
                          onPressed: () {
                            GetIt.I<HomeViewModel>().selectAll();
                          })
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _searchBar.getSearchAction(context),
                      PopupMenuButton(
                          onSelected: (String selected) {
                            GetIt.I<HomeViewModel>()
                                .handleMenuItemClick(selected);
                            print(selected);
                          },
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context) {
                            return GetIt.I<HomeViewModel>()
                                .menuItems
                                .asMap()
                                .entries
                                .map((entry) {
                              return PopupMenuItem<String>(
                                value: entry.key.toString(),
                                child: Text(entry.value).tr(),
                              );
                            }).toList();
                          }),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    Logger().d("HomeViewModelBeingRebuilt", 'Yep');
    return ViewModelBuilder<HomeViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => GetIt.I<HomeViewModel>(),
      onDispose: (model) {
        Logger().d("HomeViewModelBeingDispose", 'Yep');
      },
      builder: (BuildContext context, HomeViewModel vModel, Widget child) =>
          WillPopScope(
        onWillPop: () async {
          return Future.delayed(
            Duration(milliseconds: 100),
            () => vModel.handleBackButtonPressed(),
          );
        },
        child: Scaffold(
          // appBar: CustomAppBar(),
          appBar: _searchBar.build(context),
          floatingActionButton: FloatingActionButton(
            tooltip: 'add_location'.tr(),
            onPressed: () {
              vModel.addLocation();
            },
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(6.0),
            //   ),
            // ),
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Center(
                child: !vModel.isBusy && vModel.dataReady
                    ? Container(
                        child: vModel.locations.isNotEmpty
                            ? ListView.builder(
                                itemCount: vModel.locations.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      vModel.handleItemTap(
                                          vModel.locations[index]);
                                    },
                                    onLongPress: () {
                                      vModel.handleOnLongPress(
                                          vModel.locations[index]);
                                    },
                                    selected: vModel
                                        .isSelected(vModel.locations[index]),
                                    selectedTileColor: Colors.grey[200],
                                    title: Text(
                                      vModel.locations[index].title
                                          .toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      vModel.locations[index].subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    minVerticalPadding: 8.0,
                                    minLeadingWidth: 24.0,
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                    leading: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0,
                                      child: Icon(
                                        !vModel.selected.contains(
                                                vModel.locations[index])
                                            ? Icons.place_rounded
                                            : Icons.check_circle_rounded,
                                        size: 28.0,
                                      ),
                                    ),
                                  );
                                })
                            : NoLocationScreen(),
                      )
                    : LoadingScreen()),
          ),
        ),
      ),
    );
  }
}
