import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/LocationService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class LocationViewModel extends BaseViewModel {
  final DialogService _dialogService = GetIt.I<DialogService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final LocationService _locationService = GetIt.I<LocationService>();

  void searchLocationOnline() {
    _navigationService.navigateToAutoComplete();
  }

  void addCurrentLocation() async {
    _dialogService.loadingDialog();
    try {
      await _locationService.getCurrentPosition();
    } catch (e) {
      _dialogService.showError(e.toString());
    }
    _dialogService.stopLading();
  }

  void confirmDialog() {
    _dialogService.deleteDialog();
  }
}
