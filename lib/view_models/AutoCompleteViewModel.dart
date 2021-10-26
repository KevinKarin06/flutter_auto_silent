import 'dart:async';
import 'dart:io';

import 'package:autosilentflutter/database/LocationModel.dart';
import 'package:autosilentflutter/router.dart';
import 'package:autosilentflutter/services/ApiService.dart';
import 'package:autosilentflutter/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:easy_localization/easy_localization.dart';

class AutoCompleteViewModel extends BaseViewModel {
  final NavigationService _navigationService = GetIt.I<NavigationService>();
  final TextEditingController _searchController = TextEditingController();
  Timer _debounce;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ApiService _apiService = GetIt.I<ApiService>();

  List<LocationModel> _suggestions = List.empty(growable: true);
  String searchResult = 'type_to_search'.tr();

  Future<void> suggest(String query) async {
    searchResult = 'type_to_search'.tr();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 1000), () async {
      Logger().d(query);
      _suggestions = await runBusyFuture(_apiService.photonSearch(query));
      Logger().d("Suggestions", _suggestions);
      if (_suggestions.isNotEmpty) {
        _suggestions = _suggestions.reversed.toList();
      }
      if (_suggestions.isEmpty) {
        searchResult = 'no_search_result'.tr();
      }
    });
  }

  List<LocationModel> get suggestions => _suggestions;
  GlobalKey<AnimatedListState> get listKey => _listKey;
  TextEditingController get searchController => _searchController;

  void onItemTap(LocationModel model) {
    _navigationService.navigateToLocationDetails(AppRouter.details, model);
    // _navigationService.navigateToLocationDetailsAndReplace(
    //     AppRouter.details, model);
  }

  void onBackIconPressded() {
    _navigationService.goBack();
  }

  void clearText() {
    _searchController.clear();
    notifyListeners();
    setBusy(false);
  }

  void cleanUp() {
    _debounce?.cancel();
    _searchController.dispose();
  }
}
