import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/view/home_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings? settings) {
    print('Generating route: ${settings?.name}');

    switch (settings?.name) {
      case NavigationConstants.HOME_VIEW:
        print("HomeView");
        return pageNavigate(const HomeView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Route is  not Found'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute pageNavigate(Widget widget) => MaterialPageRoute(
        builder: (context) => widget,
      );
}
