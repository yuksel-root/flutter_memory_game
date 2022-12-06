import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/local_storage/local_storage_manager.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

class SplashViewModel extends ChangeNotifier {
  bool isFirstInit = true;
  final NavigationService _navigation = NavigationService.instance;
  late LocalStorageManager _storageManager;

  SplashViewModel() {
    _storageManager = LocalStorageManager.instance;

    setIsFirstInit();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      _navigation.navigateToPageClear(path: NavigationConstants.homeView);
    });
  }
  void setIsFirstInit() {
    isFirstInit = !isFirstInit;
    firstInitSave();
    notifyListeners();
  }

  Future<void> firstInitSave() async {
    _storageManager.setBool("isFirstInit", isFirstInit);
    print(await _storageManager.getAllValues);
  }
}
