import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class TimeState with ChangeNotifier {
  double _time = 0;
  bool _isActiveTimer = true;

  bool get getIsActiveTimer => _isActiveTimer;
  double get getTime => _time;

  set setIsActiveTimer(bool setTimer) {
    _isActiveTimer = setTimer;
    notifyListeners();
  }

  set setTime(double newTime) {
    _time -= newTime;
    notifyListeners();
  }

  void initTime(BuildContext context) async {
    _time = context.dynamicW(0.9);

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      // print({"g1": getTime});
      if ((getTime - context.dynamicW(0.05)) < 0) {
        setTime = 0;
        setIsActiveTimer = false;
        timer.cancel(); //stop timer
        notifyListeners();
      }

      if (timer.isActive) {
        setTime = context.dynamicW(0.1);
      } else {
        print("timer is cancel");
        setIsActiveTimer = false;
      }
    });
  }
}
