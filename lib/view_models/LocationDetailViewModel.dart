import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/LocationDetailService.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationDetailViewModel extends BaseViewModel {
  final LocationDetailService _locationDetailService =
      GetIt.I<LocationDetailService>();
  bool isDirty = false;
  LocationModel _model;
  LocationModel clonedModel;
  void initialise() {
    _model = _locationDetailService.getModel();
    this.clonedModel = LocationModel.clone(_model);
    Logger().d('Initialising', _model.toMap());
    Logger().d('Initialising Cloned', clonedModel.toMap());
  }

  void _checkIsDirty() {
    if (clonedModel == _model) {
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
    // _model = LocationModel.clone(clonedModel);
    setRadius(clonedModel.radius.toString());
    setJustOnce(clonedModel.justOnce);
    setTitle(clonedModel.title);
    Logger().d('Cloned', clonedModel.toMap());
    Logger().d('Original', _model.toMap());
  }

  LocationModel getModel() => _model;

  void setTitle(String value) {
    this._model.title = value;
    notifyListeners();
    _checkIsDirty();
  }

  void setRadius(String val) {
    if (val != null && val.isNotEmpty) {
      int value = int.parse(val);
      if (value > 0 && value >= 200) {
        this._model.radius = value;
        _checkIsDirty();
      }
    }
  }

  void setJustOnce(bool b) {
    this._model.justOnce = b;
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
}
