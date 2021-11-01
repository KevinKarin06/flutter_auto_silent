import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/DatabaseService.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/LocationDetailService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/view_models/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationDetailViewModel extends BaseViewModel {
  final LocationDetailService _locationDetailService =
      GetIt.I<LocationDetailService>();
  final GeofenceService _geofenceService = GetIt.I<GeofenceService>();
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();

  //
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();
  bool isDirty = false;
  LocationModel _model;
  LocationModel _clonedModel;
  //
  void initialise() {
    _model = _locationDetailService.getModel();
    if (_model.id != null) {
    } else {
      setIsDirty(true);
    }
    this._clonedModel = LocationModel.clone(_model);
    _locationController.text = _model.title;
    _radiusController.text = _model.radius.toString();
  }

  TextEditingController getRadiusController() => _radiusController;
  TextEditingController getLocationController() => _locationController;

  void _checkIsDirty() {
    if (_model.id != null) {
      if (_clonedModel.title == _model.title &&
          _clonedModel.radius == _model.radius &&
          _clonedModel.justOnce == _model.justOnce) {
        isDirty = false;
      } else
        isDirty = true;
    }
    notifyListeners();
  }

  void setIsDirty(bool b) {
    this.isDirty = b;
    notifyListeners();
  }

  void clearChanges() {
    if (_model == _clonedModel) {
      if (_model.id == null) {
        _navigationService.goBack();
      }
    }
    setRadius(_clonedModel.radius.toString());
    setJustOnce(_clonedModel.justOnce);
    setTitle(_clonedModel.title);
    _locationController.text = _clonedModel.title;
    _radiusController.text = _clonedModel.radius.toString();
  }

  LocationModel getModel() => _model;

  void setTitle(String value) {
    this._model.title = value;
    _checkIsDirty();
  }

  void setRadius(String val) {
    if (val != null && val.isNotEmpty) {
      int value = int.parse(val);
      if (value > 0 && value >= 200 && value <= 1500) {
        this._model.radius = value;
        _checkIsDirty();
      }
    }
  }

  void setJustOnce(bool b) {
    _model.justOnce = b;
    _checkIsDirty();
  }

  bool getJustOnce() {
    return _model.justOnce;
  }

  validateLocation(String value) {
    if (value == null || value.isEmpty) {
      return 'location_validation'.tr();
    }
    return null;
  }

  validateRaduis(String val) {
    if (val == null || val.isEmpty) {
      return 'radius_validation_null'.tr();
    }
    int value = int.parse(val);
    if (value < 0 || value < 200) {
      return 'radius_validation_wrong'.tr();
    }
    return null;
  }

  void clearControllers() {
    _locationController.dispose();
    _radiusController.dispose();
  }

  void _refreshModel() {
    _clonedModel = LocationModel.clone(_model);
  }

  void saveLocation() async {
    _dialogService.loadingDialog();
    try {
      if (_model.id != null) {
        await _databaseService.updateLocation(_model);
      } else {
        await _geofenceService.addGeofence(_model);
        GetIt.I<MainViewModel>().locations.add(_model);
      }
      _dialogService.showSuccess('msg');
    } catch (e) {
      _dialogService.stopLading();
      _dialogService.showError(e.toString());
    }
    _dialogService.stopLading();
    _refreshModel();
    setIsDirty(false);
  }

  void onDelete(LocationModel model) {
    _dialogService.deleteDialog();
  }
}
