import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/view/game_view.dart';
import 'package:flutter_memory_game/view/home_view.dart';
import 'package:flutter_memory_game/view/levels_view.dart';
import 'package:flutter_memory_game/view/splash_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings? settings) {
    switch (settings?.name) {
      case NavigationConstants.splashView:
        return pageNavigate(const SplashView(), settings!);
      case NavigationConstants.homeView:
        return pageNavigate(const HomeView(), settings!);
      case NavigationConstants.gameView:
        return pageNavigate(const GameView(), settings!);
      case NavigationConstants.levelView:
        return pageNavigate(const LevelsView(), settings!);

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Route is  not Found'),
            ),
          ),
          settings: settings,
        );
    }
  }

  static MaterialPageRoute pageNavigate(
          Widget widget, RouteSettings? settings) =>
      MaterialPageRoute(
        builder: (context) => widget,
        settings: settings,
      );
}
