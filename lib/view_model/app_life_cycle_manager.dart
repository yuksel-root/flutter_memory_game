import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/notifier/timeState_provider.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:flutter_memory_game/view_model/sound_view_model.dart';
import 'package:provider/provider.dart';

class AppLifeCycleManager extends StatefulWidget {
  final Widget child;
  const AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  State<AppLifeCycleManager> createState() => _AppLifeCycleManagerState();
}

class _AppLifeCycleManagerState extends State<AppLifeCycleManager>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final timeProv = Provider.of<TimerProvider>(context, listen: false);
    final gameProv = Provider.of<GameViewModel>(context, listen: false);
    final soundProv = Provider.of<SoundViewModel>(context, listen: false);

    switch (state) {
      case AppLifecycleState.detached:
        print('LifeCycleState = $state');
        break;
      case AppLifecycleState.inactive:
        print('LifeCycleState = $state');

        break;
      case AppLifecycleState.paused:
        print('LifeCycleState = $state');
        if (timeProv.getTimeState != TimeState.timerFinish) {
          context.read<TimerProvider>().stopTimer(context, reset: false);
        }

        print(timeProv.getTimeState);
        break;
      case AppLifecycleState.resumed:
        print('LifeCycleState = $state');

        break;

      default:
    }
  }
}
