import 'package:autosilentflutter/database/LocationModel.dart';

class LocationDetailService {
  LocationModel _model;
  void setModel(LocationModel model) {
    this._model = model;
  }

  LocationModel getModel() => _model;
}
