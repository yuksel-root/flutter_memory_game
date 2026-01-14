import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

//-- GameState Variables -- //
enum TimeState {
  timerEmpty,
  timerActive,
  timerPaused,
  timerFinish,
  timerReset,
  timerError,
}

class TimerProvider with ChangeNotifier {
  late TimeState? _timeState;
  late double _time = 0;
  late bool _isActiveTimer;
  Timer? timer;
  late bool _isPaused;
  late bool _isTimeFinish;

  TimerProvider() {
    _timeState = TimeState.timerEmpty;
    _time = 0;
    _isActiveTimer = false;
    _isPaused = false;
    _isTimeFinish = false;
  }

  TimeState get getTimeState => _timeState!;
  set setTimeState(TimeState newState) {
    _timeState = newState;
  }

  bool get getIsActiveTimer => _isActiveTimer;
  double get getTime => _time;
  bool get getIsPaused => _isPaused;

  set setIsPaused(bool setPause) {
    _isPaused = setPause;
    notifyListeners();
  }

  bool get getTimeFinish => _isTimeFinish;

  set setTimeFinish(bool setFinish) {
    _isTimeFinish = setFinish;
    notifyListeners();
  }

  set setIsActiveTimer(bool setTimer) {
    _isActiveTimer = setTimer;
    notifyListeners();
  }

  set setTime(double newTime) {
    _time -= newTime;
    notifyListeners();
  }

  void resetTimer(BuildContext context) {
    if (!context.mounted) return;
    print("Timer reset F");
    setTime = context.dynamicW(0.9);
  }

  void stopTimer(BuildContext context, {bool reset = true}) {
    if (!context.mounted) return;
    if (reset) {
      print("timer reset");
      resetTimer(context);
      setTimeState = TimeState.timerReset;
      timer!.cancel();
      notifyListeners();
    } else {
      print("timer paused else");
      setTimeState = TimeState.timerPaused;
      timer!.cancel();
      notifyListeners();
    }
  }

  void startTime(BuildContext context, {bool reset = true}) async {
    if (!context.mounted) return;
    if (getTimeState == TimeState.timerFinish ||
        getTimeState == TimeState.timerEmpty ||
        getTimeState == TimeState.timerReset) {
      print("initTime");
      _time = context.dynamicW(0.9);
    }

    final gameProv = Provider.of<GameViewModel>(
      context,
      listen: false,
    ).gameCard!.length;
    timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
      try {
        if ((getTime - context.dynamicW(0.05).abs()) < 0) {
          context.read<TimerProvider>().stopTimer(context, reset: true);
          setTimeState = TimeState.timerFinish;
        }
        if (timer!.isActive) {
          setTimeState = TimeState.timerActive;
          setTime = context.dynamicW(1 / (gameProv * 3));
        } else {
          if (getTimeState == TimeState.timerPaused) {
            print("timer paused button else ");
            stopTimer(context, reset: false);
          }
        }
      } catch (e) {
        setTimeState = TimeState.timerError;
        print(e);
      }
    });
  }
}

 /*
      print({
        "g1": getTime,
        "s": (i),
        "totalCard": gameProv,
        "total:": (1 / ((gameProv * 3))),
        "width": context.mediaQuery.size.width.abs(),
        "Çıkan sayı":
            ((context.mediaQuery.size.width) * ((1 / (gameProv * 3)))).toInt()
      });
      */