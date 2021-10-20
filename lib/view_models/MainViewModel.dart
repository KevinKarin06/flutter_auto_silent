import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/helpers/DbHelper.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:get_it/get_it.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class MainViewModel extends FutureViewModel {
  final DbHelper _dbHelper = GetIt.I<DbHelper>();
  final GeofenceService _geofenceService = GetIt.I<GeofenceService>();
  final FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  bool multiSelect = false;
  List<LocationModel> selected = List.empty(growable: true);
  List<LocationModel> locations = List.empty(growable: true);
  List<LocationModel> filteredLocations = List.empty(growable: true);
  List<String> _menuItems = ['settings'.tr(), 'about'.tr()];
  @override
  Future<List<LocationModel>> futureToRun() async {
    locations = await _dbHelper.getLocations();
    return locations;
  }

  void setMultiSelect(bool b) {
    this.multiSelect = b;
    notifyListeners();
  }

  List<LocationModel> getSelected() => selected;

  FloatingSearchBarController getController() => floatingSearchBarController;

  List<String> getMenuItems() => _menuItems;

  void openSearchBar() {
    this.floatingSearchBarController.open();
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
    filteredLocations = locations.where((LocationModel model) {
      return model.title.contains(query);
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
      print('multi select mode enabled');
    } else {
      print('//Navigate to detail screen');
    }
    print('handle item tap');
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
    selected.add(model);
    setMultiSelect(true);
    print('multiselect');
    print(selected);
  }

  void deleteAllSelected() {
    selected.forEach((LocationModel model) async {
      await _geofenceService.removeGeofence(model);
    });
    notifyListeners();
  }

  void addLocation() {}

  void handleMenuItemClick(String item) {}
}
