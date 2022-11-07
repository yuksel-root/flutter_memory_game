import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double dynamicWidth(double val) => mediaQuery.size.width * val;
  double dynamicHeight(double val) => mediaQuery.size.height * val;
}
