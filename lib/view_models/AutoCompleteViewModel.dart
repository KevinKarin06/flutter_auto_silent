import 'dart:async';
import 'dart:io';

import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/ApiService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:uiblock/uiblock.dart';

class AutoCompleteViewModel extends BaseViewModel {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final FloatingSearchBarController _floatingBarController =
      FloatingSearchBarController();
  Timer _debounce;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ApiService _apiService = GetIt.I<ApiService>();

  List<LocationModel> suggestions = List.empty(growable: true);
  List<LocationModel> _temp = List.empty(growable: true);

  Future<void> suggest(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () async {
      Logger().d(query);
      _temp = await runBusyFuture(_apiService.photonSearch(query));

      _temp.forEach((element) {
        suggestions.add(element);
      });
    });
  }

  // List<LocationModel> get suggestions => suggestions;
  GlobalKey<AnimatedListState> get listKey => _listKey;

  void onItemTap(LocationModel model) {
    _navigationService.navigateToLocationDetailsAndReplace(
        AppRouter.details, model);
  }

  void onBackIconPressded() {
    _navigationService.goBack();
  }

  void cleanUp() {
    _debounce?.cancel();
  }
}
