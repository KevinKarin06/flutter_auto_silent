import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:autosilentflutter/helpers/GeocoderHelper.dart';
import 'package:autosilentflutter/helpers/GeofenceHelper.dart';
import 'package:autosilentflutter/services/GeocoderService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
void setUp() {
  print('Register Singletones');
  serviceLocator.registerFactory<GeocoderService>(() => GeocoderService());
  serviceLocator.registerLazySingleton<DbHelper>(() => DbHelper());
  serviceLocator
      .registerLazySingleton<GeofenceService>(() => GeofenceService());
  // serviceLocator.registerLazySingleton<GeocoderHelper>(() => GeofenceHelper());
}
