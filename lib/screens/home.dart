import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/screens/settings.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  // Future<void> _addCurrentLocation() async {
  //   UIBlock.block(context);
  //   try {
  //     LocationModel model = await helper.getCurrentPosition();
  //     await _geofenceHelper.addGeofence(model);
  //     await _loadLocations();
  //     UIBlock.unblock(context);
  //     DialogContext().showSnackBar(
  //       snackBar: snackBar(error: false, msg: 'Added Succesfully'),
  //     );
  //   } catch (e) {
  //     UIBlock.unblock(context);
  //     DialogContext().showSnackBar(
  //       snackBar: snackBar(error: true, msg: e.toString()
  //           // msg:
  //           //     'Failed to add Location please try again make sure you have a worknig internet connection'
  //           ),
  //     );
  //     print('From Home Screen: ' + e);
  //   }
  // }

  // Future<void> _addFetchedCurrentLocation(LocationModel model) async {
  //   UIBlock.block(context);
  //   try {
  //     await _geofenceHelper.addGeofence(model);
  //     await _loadLocations();
  //     UIBlock.unblock(context);
  //     DialogContext().showSnackBar(
  //       snackBar: snackBar(error: false, msg: 'Added Succesfully'),
  //     );
  //   } catch (e) {
  //     UIBlock.unblock(context);
  //     DialogContext().showSnackBar(
  //       snackBar: snackBar(error: true, msg: e.toString()),
  //     );
  //     print(e);
  //   }
  // }

  // Future<void> _updateLocations(LocationModel model) async {
  //   UIBlock.block(context);
  //   try {
  //     await _dbHelper.updateLocation(model);
  //     await _loadLocations();
  //     UIBlock.unblock(context);
  //   } catch (e) {
  //     UIBlock.unblock(context);
  //     print(e);
  //   }
  // }

  // Future<void> _batchDelete(List<LocationModel> models) async {
  //   int deleted = models.length;
  //   UIBlock.block(context);
  //   try {
  //     for (int i = 0; i < models.length; i++) {
  //       await _geofenceHelper.removeGeofence(models[i]);
  //     }
  //     _cancelMultiSelect();
  //     _loadLocations();
  //     UIBlock.unblock(context);
  //     DialogContext().showSnackBar(
  //       snackBar: snackBar(
  //           error: false,
  //           msg: '$deleted ${deleted > 1 ? 'Locations' : 'Location'} Removed'),
  //     );
  //   } catch (e) {
  //     UIBlock.unblock(context);
  //     DialogContext()
  //         .showSnackBar(snackBar: snackBar(error: true, msg: e.toString()));
  //     print(e);
  //   }
  // }
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Rebuild Trigerred');
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (BuildContext context, MainViewModel vModel, Widget child) =>
          WillPopScope(
        onWillPop: () async {
          return Future.delayed(
            Duration(milliseconds: 100),
            () => vModel.handleBackButtonPressed(),
          );
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: vModel.multiSelect
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
              : PreferredSize(
                  preferredSize: Size(0, 0),
                  child: Container(),
                ),
          floatingActionButton: MaterialButton(
            height: 56.0,
            minWidth: 56.0,
            onPressed: () {
              vModel.addLocation();
            },
            color: Colors.cyan,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: !vModel.isBusy
                        ? Container(
                            child: vModel.data.isNotEmpty
                                ? ListView.builder(
                                    itemCount: vModel.data.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          vModel.handleItemTap(
                                              vModel.data[index]);
                                        },
                                        onLongPress: () {
                                          vModel.handleOnLongPress(
                                              vModel.data[index]);
                                        },
                                        selected: vModel
                                            .isSelected(vModel.data[index]),
                                        selectedTileColor: Colors.grey[300],
                                        title: Text(
                                          vModel.data[index].title
                                              .toUpperCase(),
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        subtitle: Text(
                                          vModel.data[index].subtitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        minVerticalPadding: 8.0,
                                        trailing: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        leading: Align(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0,
                                          child: Icon(
                                            !vModel.selected.contains(
                                                    vModel.data[index])
                                                ? Icons.place_rounded
                                                : Icons.check_circle_rounded,
                                            size: 28.0,
                                          ),
                                        ),
                                      );
                                    })
                                : Container(
                                    child: Center(
                                      child: AnimatedTextKit(
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            'No Locations Added Yet',
                                          ),
                                          TypewriterAnimatedText(
                                            'Add Locations to get Started',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                  !vModel.multiSelect
                      ? FloatingSearchBar(
                          elevation: 10.0,
                          // padding: EdgeInsets.symmetric(horizontal: 8.0),

                          hint: 'search'.tr(),
                          leadingActions: [
                            FloatingSearchBarAction(
                              showIfOpened: false,
                              child: CircularButton(
                                icon: const Icon(Icons.place_rounded),
                                onPressed: () {},
                              ),
                            ),
                          ],
                          scrollPadding:
                              const EdgeInsets.only(top: 16, bottom: 56),
                          transitionDuration: const Duration(milliseconds: 800),
                          transitionCurve: Curves.easeInOut,
                          physics: const BouncingScrollPhysics(),
                          axisAlignment: isPortrait ? 0.0 : -1.0,
                          openAxisAlignment: 0.0,
                          width: isPortrait ? 600 : 500,
                          debounceDelay: const Duration(milliseconds: 500),
                          onQueryChanged: (query) {
                            vModel.filterLocation(query);
                            print(vModel.filteredLocations.length);
                          },
                          // Specify a custom transition to be used for
                          // animating between opened and closed stated.
                          transition: CircularFloatingSearchBarTransition(),
                          actions: [
                            FloatingSearchBarAction(
                              showIfOpened: false,
                              child: CircularButton(
                                tooltip: 'settings'.tr(),
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsScreen()),
                                  );
                                },
                              ),
                            ),
                            FloatingSearchBarAction.searchToClear(
                              showIfClosed: false,
                            ),
                          ],
                          builder: (context, transition) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Material(
                                color: Colors.white,
                                elevation: 4.0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: ListView.builder(
                                      itemCount:
                                          vModel.filteredLocations.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                            title: Text(vModel
                                                .filteredLocations[index]
                                                .title));
                                      }),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
