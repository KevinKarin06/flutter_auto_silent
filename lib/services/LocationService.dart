import 'package:autosilentflutter/Utils.dart';
import 'package:autosilentflutter/constants/errors.dart';
import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/DataConnectionService.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeocoderService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/services/PermissionService.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class LocationService {
  final GeocoderService _geocoderService = GetIt.I<GeocoderService>();
  final NavigationService _navigationServcie = GetIt.I<NavigationService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final PermissionService _permissionService = GetIt.I<PermissionService>();
  final DataConnectionService _dataConnectionService =
      GetIt.I<DataConnectionService>();
  //
  Future<void> getCurrentPosition() async {
    try {
      if (await _permissionService.requestLocationPermision()) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        if (await _dataConnectionService.internetAvalaible()) {
          Address address = await _geocoderService.getAdresseFromLatLon(
            position.latitude,
            position.longitude,
          );
          String subtitle =
              '${address.thoroughfare}, ${address.adminArea}, ${address.countryName}';
          String title = address.featureName;
          //
          LocationModel model = LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
            title: title,
            subtitle: subtitle,
            uuid: Utils.generateuuid(),
          );
          //navigate to location details
          _navigationServcie.navigateToLocationDetails(
              AppRouter.details, model);
        } else
          return Future.error(AppError.NO_INTERNET);
      } else
        return Future.error(AppError.PERMISSION_DENIED);
    } catch (e) {
      Logger().d('Error ', e);
      return Future.error(e.toString());
    }
  }
}
