import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:autosilentflutter/helpers/GeocoderHelper.dart';
import 'package:autosilentflutter/helpers/GeofenceHelper.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeocoderService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/services/SearchService.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
void setUp() {
  print('Register Singletones');
  serviceLocator.registerFactory<GeocoderService>(() => GeocoderService());
  serviceLocator.registerLazySingleton<DbHelper>(() => DbHelper());
  serviceLocator
      .registerLazySingleton<GeofenceService>(() => GeofenceService());
  serviceLocator
      .registerLazySingleton<SearchBarService>(() => SearchBarService());
  serviceLocator
      .registerLazySingleton<NavigationService>(() => NavigationService());
  serviceLocator.registerLazySingleton<DialogService>(() => DialogService());
  // serviceLocator.registerLazySingleton<GeocoderHelper>(() => GeofenceHelper());
}
