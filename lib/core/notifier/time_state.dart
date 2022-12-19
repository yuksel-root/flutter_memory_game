import 'package:flutter/widgets.dart';

class TimeState with ChangeNotifier {
  double _time = 500;

  double get getTime => _time;

  void setTime(int newTime) {
    _time -= newTime;
    notifyListeners();
  }
}
