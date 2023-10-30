import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

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
    int i = 0;

    final gameProv =
        Provider.of<GameViewModel>(context, listen: false).gameCard!.length;
    Timer.periodic(Duration(milliseconds: 1200), (timer) {
      i++;
      print({
        "g1": getTime,
        "s": (i),
        "totalCard": gameProv,
        "total:": (1 / ((gameProv * 3))),
        "width": context.mediaQuery.size.width,
        "Çıkan sayı": (context.mediaQuery.size.width) * ((1 / (gameProv * 3)))
      });

      try {
        if ((getTime - context.dynamicW(0.05).abs()) < 0) {
          setTime = 0;
          setIsActiveTimer = false;
          timer.cancel(); //stop timer
          notifyListeners();
        }
        if (timer.isActive) {
          setTime =
              context.dynamicW(1 / (gameProv * 3)); // 36 = 360px*0.1 // 10sn x
        } else {
          print("timer is cancel");
          setIsActiveTimer = false;
          timer.cancel();
        }
      } catch (e) {
        // print({"why timer hata": e});
      }
    });
  }
}
