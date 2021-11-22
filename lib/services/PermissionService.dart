import 'dart:io';

import 'package:autosilentflutter/constants/constants.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

class PermissionService {
  final DialogService _dialogService = GetIt.I<DialogService>();
  //
  Future<bool> requestLocationPermision() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    //check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    //check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //if not granted request again
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    }
    //if denied show rationale
    if (permission == LocationPermission.denied) {
      _dialogService.showPermissionDialog('permission_required', () async {
        await Geolocator.requestPermission();
      });
    }
    //permission denied forever go to setting
    if (permission == LocationPermission.deniedForever) {
      _dialogService.showPermissionDialog('permission_required', () async {
        await Geolocator.openAppSettings();
      });
    }
    //android 10 and above
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt >= Constants.ANDROID_10) {
        if (permission != LocationPermission.always) {
          _dialogService.showPermissionDialog('permission_required_always',
              () async {
            await Geolocator.openAppSettings();
          });
        }
      }
    }
    //check status again
    permission = await Geolocator.checkPermission();
    //
    return permission == LocationPermission.always;
  }

  //dnd = don not disturb
  void requestDndPersmission() {}
}
