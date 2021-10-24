import 'dart:io';

import 'package:autosilentflutter/Constants.dart';
import 'package:autosilentflutter/Utils.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/GeocoderService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/widgets/PermissionDialog.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:dialog_context/dialog_context.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

class LocationService {
  final GeocoderService _geocoderService = GetIt.I<GeocoderService>();
  final NavigationService _navigationServcie = GetIt.I<NavigationService>();
  Future<LocationModel> getCurrentPosition() async {
    try {
      bool serviceEnabled = false;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        //return Future.error('Location Service Not Enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          DialogContext().showDialog(builder: (context) {
            return PermissionDialog(
              onGrant: () async {
                await Geolocator.requestPermission();
              },
            );
          });
          // return Future.error('Location Permission Refused');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        DialogContext().showDialog(builder: (context) {
          return PermissionDialog(
            onGrant: () async {
              await Geolocator.openAppSettings();
            },
          );
        });
      }

      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
        if (info.version.sdkInt >= Constants.ANDROID_10) {
          if (permission != LocationPermission.always) {
            DialogContext().showDialog(builder: (context) {
              return PermissionDialog(
                msg:
                    'You need to set Location permission to always for the app to work',
                onGrant: () async {
                  await Geolocator.openAppSettings();
                },
              );
            });
          }
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5));
      if (await DataConnectionChecker().hasConnection) {
        Address address = await _geocoderService.getAdresseFromLatLon(
            position.latitude, position.longitude);
        String subtitle =
            '${address.thoroughfare}, ${address.adminArea}, ${address.countryName}';
        String title = address.featureName;
        LocationModel model = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          title: title,
          subtitle: subtitle,
          uuid: Utils.generateuuid(),
        );
        _navigationServcie.navigateToLocationDetails(AppRouter.details, model);
        return model;
      } else {
        return Future.error(
            'Please make sure you have a working Internet connection and try again');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
