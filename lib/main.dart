import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/navigation/navigation_route.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_memory_game/core/notifier/provider_list.dart';
import 'package:flutter_memory_game/view/game_view.dart';
import 'package:flutter_memory_game/view/home_view.dart';
import 'package:flutter_memory_game/view/levels_view.dart';
import 'package:flutter_memory_game/view/splash_view.dart';
import 'package:flutter_memory_game/view_model/app_life_cycle_manager.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  await _init();

  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: const MainApp(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLifeCycleManager(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        home: const HomeView(),
      ),
    );
  }
}
