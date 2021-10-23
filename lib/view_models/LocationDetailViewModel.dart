import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/services/LocationDetailService.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class LocationDetailViewModel extends BaseViewModel {
  final LocationDetailService _locationDetailService =
      GetIt.I<LocationDetailService>();
  bool isDirty = false;
  LocationModel model;
  LocationModel clonedModel;
  void initialise() {
    model = _locationDetailService.getModel();
  }

  void set(LocationModel m) {
    this.model = m;
    this.clonedModel = LocationModel.clone(model);
    print(model);
    print(clonedModel == model);
  }

  bool validateTitle(String value) {
    return value.isNotEmpty;
  }

  LocationModel get() => model;

  void update() {
    this.model.title = 'New Title';
    notifyListeners();
  }
}
