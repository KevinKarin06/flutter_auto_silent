import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:autosilentflutter/helpers/GeofenceHelper.dart';
import 'package:autosilentflutter/helpers/LocationHelper.dart';
import 'package:autosilentflutter/screens/location_details.dart';
import 'package:autosilentflutter/styles/styles.dart';
import 'package:autosilentflutter/widgets/ConfirmDialog.dart';
import 'package:autosilentflutter/widgets/CustomFab.dart';
import 'package:autosilentflutter/widgets/DetailDialog.dart';
import 'package:autosilentflutter/widgets/MySnackBar.dart';
import 'package:dialog_context/dialog_context.dart';
import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool load = true;
  bool _multiselect = false;
  bool _willPop = true;
  LocationHelper helper;
  DbHelper _dbHelper;
  GeofenceHelper _geofenceHelper;
  List<LocationModel> _locations;
  List<LocationModel> _selected;

  Future<void> _addCurrentLocation() async {
    UIBlock.block(context);
    try {
      LocationModel model = await helper.getCurrentPosition();
      await _geofenceHelper.addGeofence(model);
      await _loadLocations();
      UIBlock.unblock(context);
      DialogContext().showSnackBar(
        snackBar: snackBar(error: false, msg: 'Added Succesfully'),
      );
    } catch (e) {
      UIBlock.unblock(context);
      DialogContext().showSnackBar(
        snackBar: snackBar(error: true, msg: e.toString()
            // msg:
            //     'Failed to add Location please try again make sure you have a worknig internet connection'
            ),
      );
      print('From Home Screen: ' + e);
    }
  }

  Future<void> _addFetchedCurrentLocation(LocationModel model) async {
    UIBlock.block(context);
    try {
      await _geofenceHelper.addGeofence(model);
      await _loadLocations();
      UIBlock.unblock(context);
      DialogContext().showSnackBar(
        snackBar: snackBar(error: false, msg: 'Added Succesfully'),
      );
    } catch (e) {
      UIBlock.unblock(context);
      DialogContext().showSnackBar(
        snackBar: snackBar(error: true, msg: e.toString()),
      );
      print(e);
    }
  }

  Future<void> _loadLocations() async {
    try {
      List<LocationModel> models = await _dbHelper.getLocations();
      setState(() {
        _locations = models;
        load = false;
      });
    } catch (e) {
      setState(() {
        load = false;
      });
      print(e);
    }
  }

  Future<void> _updateLocations(LocationModel model) async {
    UIBlock.block(context);
    try {
      await _dbHelper.updateLocation(model);
      await _loadLocations();
      UIBlock.unblock(context);
    } catch (e) {
      UIBlock.unblock(context);
      print(e);
    }
  }

  Future<void> _batchDelete(List<LocationModel> models) async {
    int deleted = models.length;
    UIBlock.block(context);
    try {
      for (int i = 0; i < models.length; i++) {
        await _geofenceHelper.removeGeofence(models[i]);
      }
      _cancelMultiSelect();
      _loadLocations();
      UIBlock.unblock(context);
      DialogContext().showSnackBar(
        snackBar: snackBar(
            error: false,
            msg: '$deleted ${deleted > 1 ? 'Locations' : 'Location'} Removed'),
      );
    } catch (e) {
      UIBlock.unblock(context);
      DialogContext()
          .showSnackBar(snackBar: snackBar(error: true, msg: e.toString()));
      print(e);
    }
  }

  void _cancelMultiSelect() {
    _selected.clear();
    setState(() {
      _multiselect = false;
    });
  }

  void _checkMultiSelect() {
    if (_selected.isEmpty) {
      setState(() {
        _multiselect = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLocations();
    });
    helper = LocationHelper();
    _dbHelper = DbHelper();
    _geofenceHelper = GeofenceHelper();
    _locations = List.empty(growable: true);
    _selected = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Rebuild Trigerred');
    _checkMultiSelect();
    return WillPopScope(
      onWillPop: () async {
        if (_multiselect) {
          setState(() {
            _selected.clear();
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Auto Silent'),
          actions: [
            _multiselect
                ? Container(
                    child: Center(
                      child: Text(
                        _selected.length.toString(),
                        style: selecte_count,
                      ),
                    ),
                  )
                : Container(),
            _multiselect
                ? IconButton(
                    tooltip: 'Delete',
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmDialog(
                          onDelete: _batchDelete,
                          model: _selected,
                          onCancel: _cancelMultiSelect,
                        ),
                      );
                    })
                : Container(),
            _multiselect
                ? IconButton(
                    tooltip: 'Select All',
                    icon: Icon(
                      _selected.length == _locations.length
                          ? Icons.check_circle_rounded
                          : Icons.check_circle_outline_rounded,
                    ),
                    onPressed: () {
                      if (_selected.length == _locations.length) {
                        _cancelMultiSelect();
                      } else {
                        _selected.clear();
                        setState(() {
                          _selected.addAll(_locations);
                        });
                      }
                      print(_selected);
                    })
                : Container(),
            // IconButton(
            //   tooltip: 'switch theme',
            //   icon: Icon(Icons.lightbulb_outline_rounded),
            //   onPressed: () {
            //     DialogContext().showSnackBar(
            //       snackBar: snackBar(error: false, msg: 'Test Mode'),
            //     );
            //     print('change from dark mode to clear mode');
            //   },
            // ),
          ],
          elevation: 0.0,
        ),
        floatingActionButton: CustomFab(
          Icons.add,
          getCurrent: () {
            _addCurrentLocation();
          },
          onSearchResult: (LocationModel model) {
            _addFetchedCurrentLocation(model);
          },
          willPop: _willPop,
        ),
        body: SafeArea(
          child: Center(
            child: !load
                ? Container(
                    child: _locations.isNotEmpty
                        ? ListView.builder(
                            itemCount: _locations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  if (_multiselect) {
                                    if (!_selected
                                        .contains(_locations[index])) {
                                      setState(() {
                                        _selected.add(_locations[index]);
                                      });
                                    } else {
                                      setState(() {
                                        _selected.remove(_locations[index]);
                                      });
                                    }
                                    print('multi select mode enabled');
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => LocationDetails(
                                                model: _locations[index])));
                                    // Widget dialog = DetailDialog(
                                    //   model: _locations[index],
                                    //   onUpdate: _updateLocations,
                                    // );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => dialog,
                                    // );
                                  }
                                },
                                onLongPress: () {
                                  setState(() {
                                    _multiselect = true;
                                  });
                                  _selected.add(_locations[index]);
                                  print(_selected);
                                },
                                selected: _selected.contains(_locations[index]),
                                selectedTileColor: Colors.grey[300],
                                title: Text(
                                  _locations[index].title.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  _locations[index].subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                minVerticalPadding: 8.0,
                                trailing: Icon(Icons.arrow_forward_ios_rounded),
                                leading: Icon(
                                  !_selected.contains(_locations[index])
                                      ? Icons.location_on_rounded
                                      : Icons.check_circle_rounded,
                                  size: 28.0,
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
                                    textStyle: noLocation,
                                  ),
                                  TypewriterAnimatedText(
                                    'Add Locations to get Started',
                                    textStyle: noLocation,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
