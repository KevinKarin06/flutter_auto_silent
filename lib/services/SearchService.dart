import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarService {
  final FloatingSearchBarController _floatingSearchBarController =
      FloatingSearchBarController();

  FloatingSearchBarController floatingSearchBarController() =>
      _floatingSearchBarController;

  void open() {
    _floatingSearchBarController.open();
  }

  void close() {
    _floatingSearchBarController.close();
  }

  void clearText() {
    _floatingSearchBarController.clear();
  }
}
