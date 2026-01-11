import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

//-- HomeState Variables -- //
enum HomeState { empty, loading, completed, error }

class HomeViewModel extends ChangeNotifier {
  late NavigationService _navigation;
  late HomeState? _state;

  HomeViewModel() {
    _navigation = NavigationService.instance;
    _state = HomeState.empty;
  }

  void navigateToPageClear(String path) {
    _navigation.navigateToPageClear(path: path, data: []);
  }

  void clickStageMode() {
    navigateToPageClear(NavigationConstants.levelView);
  }

  void clickArcadeMode() {
    navigateToPageClear(NavigationConstants.gameView);
  }
}
