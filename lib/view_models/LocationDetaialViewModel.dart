import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:stacked/stacked.dart';

class LocationDetailViewModel extends BaseViewModel {
  LocationModel model;
  LocationModel clonedModel;
  void initialise() {
    print('locationn model working');
  }

  bool isDirty = false;

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
