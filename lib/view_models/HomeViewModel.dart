import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/DatabaseService.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final GeofenceService _geofenceService = GetIt.I<GeofenceService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  //
  bool multiSelect = false;
  bool showCancelIcon = false;
  List<LocationModel> _selected = List.empty(growable: true);
  List<LocationModel> locations = List.empty(growable: true);
  List<LocationModel> _tempLocations = List.empty(growable: true);
  List<String> _menuItems = ['settings', 'about'];
  int deleted = 0;

  @override
  Future<List<LocationModel>> futureToRun() async {
    Logger().d('Futre to run');
    locations = await _databaseService.getLocations();
    _tempLocations.addAll(locations);
    return locations;
  }

  void refresh() {
    notifyListeners();
  }

  void setMultiSelect(bool b) {
    this.multiSelect = b;
    notifyListeners();
  }

  void setShowCancelIcon(bool b) {
    this.showCancelIcon = b;
    notifyListeners();
  }

  List<LocationModel> get selected => _selected;

  List<String> get menuItems => _menuItems;

  void _checkMultiSelect() {
    if (_selected.isEmpty) {
      setMultiSelect(false);
    }
    notifyListeners();
  }

  void _cancelMultiSelect() {
    _selected.clear();
    setMultiSelect(false);
  }

  void cancelSelection() {
    _cancelMultiSelect();
  }

  void filterLocation(String query) {
    this.locations.clear();
    locations.addAll(_tempLocations);
    query = query.toLowerCase();
    if (query.isNotEmpty) {
      setShowCancelIcon(true);
    } else {
      setShowCancelIcon(false);
    }
    this.locations = locations.where((LocationModel model) {
      return model.title.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  List<LocationModel> getFilteredList() => _tempLocations;

  void selectAll() {
    if (_selected.length == locations.length) {
      _cancelMultiSelect();
    } else {
      _selected.clear();
      _selected.addAll(locations);
      notifyListeners();
    }
  }

  bool isSelected(LocationModel model) {
    return _selected.contains(model);
  }

  void handleItemTap(LocationModel model) {
    if (multiSelect) {
      if (!_selected.contains(model)) {
        _selected.add(model);
        notifyListeners();
      } else {
        _selected.remove(model);
        print(_selected.length);
        _checkMultiSelect();
      }
    } else {
      _navigationService.navigateToLocationDetails(AppRouter.details, model);
    }
  }

  bool handleBackButtonPressed() {
    if (multiSelect) {
      _cancelMultiSelect();
      return false;
    } else {
      return true;
    }
  }

  void handleOnLongPress(LocationModel model) {
    if (!multiSelect) {
      _selected.add(model);
      setMultiSelect(true);
    } else
      _cancelMultiSelect();
  }

  void deleteAllSelected() {
    _dialogService.deleteDialog();
  }

  void bactDelete() async {
    // _dialogService.loadingDialog();
    try {
      selected.forEach((LocationModel locationModel) async {
        await _geofenceService.removeGeofence(locationModel);
        this.locations.remove(locationModel);
        notifyListeners();
      });
    } catch (e) {
      _dialogService.showError(e.toString());
    }
    this.cancelSelection();
    notifyListeners();
  }

  void addLocation() {
    _dialogService.addLocationDialog();
  }

  void handleMenuItemClick(String item) {
    switch (item) {
      case '0':
        _navigationService.navigateToSettings(AppRouter.setting);
        break;
      case '1':
        _navigationService.navigateToSettings(AppRouter.about);
        break;
      default:
    }
  }
}
