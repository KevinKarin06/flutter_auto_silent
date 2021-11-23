import 'dart:isolate';
import 'dart:ui';

import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/DatabaseService.dart';
import 'package:autosilentflutter/services/PermissionService.dart';
import 'package:flutter/services.dart';
import 'package:geofencing/geofencing.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class GeofenceService {
  //
  static const _platform = const MethodChannel('app.geofeonce.channel');
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PermissionService _permissionService = GetIt.I<PermissionService>();
  //
  static void callback(List<String> ids, Location location, GeofenceEvent e) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('geofencing_send_port');
    send.send(e.toString());
  }

  //
  Future<int> addGeofence(LocationModel model) async {
    try {
      if (await _permissionService.requestLocationPermision()) {
        List<GeofenceEvent> triggers = [
          GeofenceEvent.dwell,
          GeofenceEvent.enter,
          GeofenceEvent.exit
        ];
        AndroidGeofencingSettings settings = AndroidGeofencingSettings(
          initialTrigger: <GeofenceEvent>[
            GeofenceEvent.dwell,
            GeofenceEvent.enter,
            GeofenceEvent.exit
          ],
          loiteringDelay: 1000 * 60,
        );
        GeofenceRegion region = GeofenceRegion(
          model.id.toString(),
          model.latitude,
          model.longitude,
          model.radius.toDouble(),
          triggers,
          androidSettings: settings,
        );
        await GeofencingManager.registerGeofence(
          region,
          callback,
        );
        // var result = await _platform.invokeMethod(
        //   'addGeofence',
        //   <String, dynamic>{
        //     'uuid': model.uuid,
        //     'latitude': model.latitude,
        //     'longitude': model.longitude,
        //   },
        // );
        // if (result == true) {
        return await _databaseService.createLocation(model);
        // } else {
        //   return Future.error('goefence_add_failed');
        // }
      } else
        return Future.error('permission_denied');
    } on PlatformException catch (exception) {
      print(exception);
      Logger().d('from plugin', exception.message);
      return Future.error('geofence_platform_exception');
    }
  }

  Future<void> removeGeofence(LocationModel model) async {
    try {
      var result = await _platform.invokeMethod(
        'removeGeofence',
        <String, dynamic>{
          'uuid': model.uuid,
        },
      );
      if (result == true) {
        await _databaseService.deleteLocation(model.id);
      } else {
        return Future.error('Failed to add Location please try again');
      }
    } on PlatformException catch (exception) {
      print(exception);
      return Future.error('Ooops Something went wrong please try again');
    }
  }

  Stream<int> batchRemove(List<LocationModel> list) async* {
    int deleted = 0;
    list.forEach((LocationModel model) async* {
      await removeGeofence(model);
      yield deleted++;
    });
  }

  Future<void> test() async {
    try {
      var result = await _platform.invokeMethod('loaddb');
      print(result);
    } on PlatformException catch (exception) {
      print(exception);
      return Future.error('Ooops Something went wrong please try again');
    }
  }

  static Future<void> syncGeofences() {}
}
