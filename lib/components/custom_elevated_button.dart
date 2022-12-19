import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';

class CustomBtn extends StatelessWidget {
  final Function onPressFunc;
  final Gradient bgGradient;
  final Gradient iconGradient;
  final IconData iconName;
  final BorderRadius borderRadius;
  final double iconSize;
  const CustomBtn({
    Key? key,
    required this.onPressFunc,
    required this.bgGradient,
    required this.iconGradient,
    required this.iconName,
    required this.borderRadius,
    required this.iconSize,
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
        child: GradientWidget(
            widget: Icon(
              iconName,
              size: iconSize,
            ),
            gradient: iconGradient),
      ),
    );
  }
}
