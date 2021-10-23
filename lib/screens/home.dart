import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/screens/settings.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:autosilentflutter/widgets/CustomAppBar.dart';
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
          appBar: CustomAppBar(),
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
                                    selectedTileColor: Colors.grey[300],
                                    title: Text(
                                      vModel.locations[index].title
                                          .toUpperCase(),
                                    ),
                                    subtitle: Text(
                                      vModel.locations[index].subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    minVerticalPadding: 8.0,
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
