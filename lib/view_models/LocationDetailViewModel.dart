import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/DatabaseService.dart';
import 'package:autosilentflutter/services/DialogService.dart';
import 'package:autosilentflutter/services/GeofenceService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationDetailViewModel extends BaseViewModel {
  //
  final GeofenceService _geofenceService = GetIt.I<GeofenceService>();
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final DialogService _dialogService = GetIt.I<DialogService>();
  final NavigationService _navigationService = GetIt.I<NavigationService>();

  //
  final TextEditingController _locationController = TextEditingController();
  bool isDirty = false;
  LocationModel _model;
  LocationModel _clonedModel;
  //
  void initialise(LocationModel model) {
    _model = model;
    if (_model.id == null) {
      setIsDirty(true);
    }
    this._clonedModel = LocationModel.clone(_model);
    _locationController.text = _model.title;
    Logger().d('default model', _model.toMap());
  }

  TextEditingController get locationController => _locationController;

  void _checkIsDirty() {
    if (_model.id != null) {
      if (_clonedModel.title == _model.title &&
          _clonedModel.radius == _model.radius &&
          _clonedModel.justOnce == _model.justOnce &&
          _clonedModel.deleyTime == _model.deleyTime) {
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
    if (_model.id == null) {
      _navigationService.goBack();
    }
    setRadius(_clonedModel.radius);
    setJustOnce(_clonedModel.justOnce);
    setTitle(_clonedModel.title);
    setDelayTime(_clonedModel.deleyTime);
    _locationController.text = _clonedModel.title;
  }

  LocationModel get model => _model;

  void setTitle(String value) {
    this._model.title = value;
    _checkIsDirty();
  }

  setDelayTime(int delayTime) {
    this._model.deleyTime = delayTime;
    _checkIsDirty();
  }

  void setRadius(int value) {
    if (value != null && value > 100) {
      if (value > 0 && value >= 200 && value <= 1500) {
        this._model.radius = value;
        _checkIsDirty();
      }
    }
  }

  void setRadiusOld(String val) {
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
  }

  void _refreshModel() {
    _clonedModel = LocationModel.clone(_model);
    setIsDirty(false);
  }

  void saveLocation() async {
    _dialogService.loadingDialog();
    try {
      if (_model.id != null) {
        await _databaseService.updateLocation(_model);
      } else {
        int id = await _geofenceService.addGeofence(_model);
        _model.id = id;
        GetIt.I<HomeViewModel>().locations.insert(0, model);
      }
      _dialogService.showSuccess('msg');
    } catch (e) {
      _dialogService.stopLading();
      _dialogService.showError(e.toString());
    }
    _dialogService.stopLading();
    _refreshModel();
    GetIt.I<HomeViewModel>().refresh();
  }

  void onDelete(LocationModel model) {
    GetIt.I<HomeViewModel>().selected.add(model);
    _dialogService.deleteDialog();
  }
}
