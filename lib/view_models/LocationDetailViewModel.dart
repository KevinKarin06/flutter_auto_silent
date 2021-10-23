import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/LocationDetailService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationDetailViewModel extends BaseViewModel {
  final LocationDetailService _locationDetailService =
      GetIt.I<LocationDetailService>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();
  bool isDirty = false;
  LocationModel model;
  LocationModel clonedModel;
  //
  void initialise() {
    model = _locationDetailService.getModel();
    this.clonedModel = LocationModel.clone(model);
    _locationController.text = model.title;
    _radiusController.text = model.radius.toString();
  }

  TextEditingController getRadiusController() => _radiusController;
  TextEditingController getLocationController() => _locationController;

  void _checkIsDirty() {
    if (clonedModel == model) {
      isDirty = false;
    } else
      isDirty = true;
    notifyListeners();
  }

  void setIsDirty(bool b) {
    this.isDirty = b;
    notifyListeners();
  }

  void clearChanges() {
    setRadius(clonedModel.radius.toString());
    setJustOnce(clonedModel.justOnce);
    setTitle(clonedModel.title);
    _locationController.text = clonedModel.title;
    _radiusController.text = clonedModel.radius.toString();
  }

  LocationModel getModel() => model;

  void setTitle(String value) {
    this.model.title = value;
    _checkIsDirty();
  }

  void setRadius(String val) {
    if (val != null && val.isNotEmpty) {
      int value = int.parse(val);
      if (value > 0 && value >= 200) {
        this.model.radius = value;
        _checkIsDirty();
      }
    }
  }

  void setJustOnce(bool b) {
    model.justOnce = b;
    _checkIsDirty();
  }

  bool getJustOnce() {
    return model.justOnce;
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

  void saveLocation() {
    Logger().d('Model To Save', model.toMap());
  }
}
