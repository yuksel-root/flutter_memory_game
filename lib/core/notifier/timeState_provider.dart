import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

class TimeState with ChangeNotifier {
  double _time = 0;
  bool _isActiveTimer = true;
  Timer? timer;
  bool _isPaused = false;
  bool _isTimeFinish = false;

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

  void resetTimer(BuildContext context) => setTime = context.dynamicW(0.9);

  void stopTimer(BuildContext context, {bool reset = true}) {
    if (reset) {
      resetTimer(context);
      setIsPaused = false;
      setIsActiveTimer = false;
      setTimeFinish = false;
      timer!.cancel();
      notifyListeners();
    } else {
      setIsPaused = true;
      setIsActiveTimer = false;
      timer!.cancel();
      notifyListeners();
    }
  }

  void startTime(BuildContext context, {bool reset = true}) async {
    int i = 0;
    print("T C");
    print(context);
    print("T C");
    if (reset && getTimeFinish == false && getIsPaused == false) {
      _time = context.dynamicW(0.9);
    }

    final gameProv =
        Provider.of<GameViewModel>(context, listen: false).gameCard!.length;
    timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
      try {
        if ((getTime - context.dynamicW(0.05).abs()) < 0) {
          stopTimer(context, reset: true);
          setTimeFinish = true;
        }
        if (timer!.isActive) {
          setTime = context.dynamicW(1 / (gameProv * 3));
        } else {
          stopTimer(context, reset: false);
        }
      } catch (e) {
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