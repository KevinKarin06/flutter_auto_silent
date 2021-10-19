import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:flutter/services.dart';

class GeofenceService {
  static const _platform = const MethodChannel('app.geofeonce.channel');
  Future<void> addGeofence(LocationModel model) async {
    try {
      var result = await _platform.invokeMethod(
        'addGeofence',
        <String, dynamic>{
          'uuid': model.uuid,
          'latitude': model.latitude,
          'longitude': model.longitude,
        },
      );
      if (result == true) {
        DbHelper().createLocation(model);
      } else {
        return Future.error('Failed to add Location please try again');
      }
    } on PlatformException catch (exception) {
      print(exception);
      return Future.error('Ooops Something went wrong please try again');
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
        DbHelper().deleteLocation(model.id);
      } else {
        return Future.error('Failed to add Location please try again');
      }
    } on PlatformException catch (exception) {
      print(exception);
      return Future.error('Ooops Something went wrong please try again');
    }
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
}
