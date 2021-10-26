import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/LocationService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class AddLocationDialogViewModel extends BaseViewModel {
  final DialogService _dialogService = GetIt.I<DialogService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final LocationService _locationService = GetIt.I<LocationService>();

  void searchLocationOnline() {
    _navigationService.navigateToAutoComplete();
  }

  void addCurrentLocation() {
    _locationService.getCurrentPosition();
  }

  void confirmDialog() {
    _dialogService.deleteDialog();
  }
}
