import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/local_storage/local_storage_manager.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

class SplashViewModel extends ChangeNotifier {
  bool isFirstInit = true;
  final NavigationService _navigation = NavigationService.instance;
  late LocalStorageManager _storageManager;
  double _imageOpacity = 0;
  SplashViewModel() {
    _storageManager = LocalStorageManager.instance;

    setIsFirstInit();

    Future.delayed(const Duration(seconds: 4)).then((value) {
      _navigation.navigateToPageClear(path: NavigationConstants.homeView);
    });
  }

  void setOpacity() {
    _imageOpacity = 1;
    notifyListeners();
  }

  get getOpacity => _imageOpacity;

  void setIsFirstInit() {
    isFirstInit = !isFirstInit;
    firstInitSave();
    notifyListeners();
  }

  Future<void> firstInitSave() async {
    _storageManager.setBool("isFirstInit", isFirstInit);
    //print(await _storageManager.getAllValues);
  }
}
