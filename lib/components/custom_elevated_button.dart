import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final Function onPressFunc;
  final Gradient bgGradient;
  final BorderRadius borderRadius;
  final Widget child;
  const CustomBtn({
    Key? key,
    required this.onPressFunc,
    required this.bgGradient,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return circleButton(context);
  }

  ElevatedButton circleButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        onPressFunc();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: bgGradient,
        ),
        child: child,
      ),
    );
  }
}
