import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/alert_dialog.dart';
import 'package:flutter_memory_game/components/custom_dialog.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

class TimeState with ChangeNotifier {
  double _time = 0;
  late NavigationService _navigation;

  TimeState() {
    _navigation = NavigationService.instance;
  }

  double get getTime => _time;

  set setTime(double newTime) {
    _time -= newTime;
    notifyListeners();
  }

  void initTime(BuildContext context) async {
    _time = context.dynamicW(0.9);
    print({" t: ": _time});

    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if ((getTime - 200) < 0) {
        setTime = 0;
        notifyListeners();
        CustomAlertDialog alert = CustomAlertDialog(
          score: 0,
          tries: 0,
          content: "Time is Over",
          title: "STAGE 5",
          continueButtonText: "NEXT",
          continueFunction: () {
            _navigation.navigateToPageClear(
                path: NavigationConstants.gameView, data: []);
          },
        );
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        timer.cancel();
      }
      if (getTime < 1) {
        timer.cancel();
      }
      if (timer.isActive) {
        setTime = 200;
      }
    });
  }

  void setDefaultTime(double time) {
    _time = time;
  }
}
