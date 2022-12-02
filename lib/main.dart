import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/navigation/navigation_route.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_memory_game/core/notifier/provider_list.dart';
import 'package:flutter_memory_game/view/game_view.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await _init();
  await splash();
  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: const MainApp(),
    ),
  );
}

Future splash() async {
  await Future.delayed(const Duration(milliseconds: 250), () {
    FlutterNativeSplash.remove();
  });
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GameView(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: NavigationConstants.homeView,
    );
  }
}
