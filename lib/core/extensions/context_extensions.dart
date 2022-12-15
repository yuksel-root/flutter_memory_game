import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double dynamicW(double val) => mediaQuery.size.width * val;
  double dynamicH(double val) => mediaQuery.size.height * val;
}
