import 'package:autosilentflutter/services/ApiService.dart';
import 'package:autosilentflutter/services/DataConnectionService.dart';
import 'package:autosilentflutter/services/DatabaseService.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeocoderService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/LocationDetailService.dart';
import 'package:autosilentflutter/services/LocationService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/services/PermissionService.dart';
import 'package:autosilentflutter/services/SearchService.dart';
import 'package:autosilentflutter/services/SettingsService.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setUp() {
  print('Register Singletones');
  locator.registerFactory<GeocoderService>(() => GeocoderService());
  locator.registerLazySingleton<LocationDetailService>(
      () => LocationDetailService());
  locator.registerLazySingleton<GeofenceService>(() => GeofenceService());
  locator.registerLazySingleton<SearchBarService>(() => SearchBarService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<SettingsService>(() => SettingsService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<MainViewModel>(() => MainViewModel());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<PermissionService>(() => PermissionService());
  locator.registerLazySingleton<DataConnectionService>(
      () => DataConnectionService());
}
