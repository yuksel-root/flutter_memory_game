import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/view/game_view.dart';
import 'package:flutter_memory_game/view/splash_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings? settings) {
    switch (settings?.name) {
      case NavigationConstants.splashView:
        return pageNavigate(const SplashView());
      case NavigationConstants.homeView:
        return pageNavigate(TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 5),
          builder: <double>(context, value, child) {
            return ShaderMask(
              blendMode: BlendMode.modulate,
              shaderCallback: (rect) {
                return RadialGradient(
                  colors: const [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  radius: value * 5,
                ).createShader(rect);
              },
              child: child,
            );
          },
          child: const GameView(),
        ));

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
