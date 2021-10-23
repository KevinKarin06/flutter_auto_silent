import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/services/SearchService.dart';
import 'package:get_it/get_it.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class MainViewModel extends FutureViewModel {
  final DbHelper _dbHelper = GetIt.I<DbHelper>();
  final GeofenceService _geofenceService = GetIt.I<GeofenceService>();
  final SearchBarService _searchBarService = GetIt.I<SearchBarService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  //
  bool multiSelect = false;
  bool showCamcelIcon = false;
  List<LocationModel> selected = List.empty(growable: true);
  List<LocationModel> locations = List.empty(growable: true);
  List<LocationModel> filteredLocations = List.empty(growable: true);
  List<String> _menuItems = ['settings'.tr(), 'about'.tr()];

  @override
  Future<List<LocationModel>> futureToRun() async {
    locations = await _dbHelper.getLocations();
    filteredLocations.addAll(locations);
    return locations;
  }

  void setMultiSelect(bool b) {
    this.multiSelect = b;
    notifyListeners();
  }

  void setShowCancelIcon(bool b) {
    this.showCamcelIcon = b;
    notifyListeners();
  }

  List<LocationModel> getSelected() => selected;

  FloatingSearchBarController getController() =>
      _searchBarService.floatingSearchBarController();

  List<String> getMenuItems() => _menuItems;

  void openSearchBar() {
    _searchBarService.open();
  }

  void closeSearchBar() {
    _searchBarService.close();
    setShowCancelIcon(false);
  }

  void clearSearchBarText() {
    _searchBarService.clearText();
  }

  void _checkMultiSelect() {
    if (selected.isEmpty) {
      setMultiSelect(false);
    }
    notifyListeners();
  }

  void _cancelMultiSelect() {
    selected.clear();
    setMultiSelect(false);
  }

  void cancelSelection() {
    _cancelMultiSelect();
  }

  void filterLocation(String query) {
    query = query.toLowerCase();
    if (query.isNotEmpty) {
      setShowCancelIcon(true);
    } else {
      setShowCancelIcon(false);
      this.locations = filteredLocations;
    }
    this.locations = locations.where((LocationModel model) {
      return model.title.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  List<LocationModel> getFilteredList() => filteredLocations;

  void selectAll() {
    if (selected.length == locations.length) {
      _cancelMultiSelect();
    } else {
      selected.clear();
      selected.addAll(locations);
      notifyListeners();
    }
  }

  bool isSelected(LocationModel model) {
    return selected.contains(model);
  }

  void handleItemTap(LocationModel model) {
    if (multiSelect) {
      if (!selected.contains(model)) {
        selected.add(model);
        notifyListeners();
      } else {
        selected.remove(model);
        print(selected.length);
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
      selected.add(model);
      setMultiSelect(true);
    } else
      _cancelMultiSelect();
  }

  void deleteAllSelected() {
    selected.forEach((LocationModel model) async {
      await _geofenceService.removeGeofence(model);
    });
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
