import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../../view_model/splash_view_model.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => GameViewModel(),
    ),
    Provider.value(value: NavigationService.instance)
  ];
}
