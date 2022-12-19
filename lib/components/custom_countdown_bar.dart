import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';

class CustomCountDownBar extends StatelessWidget {
  final double? width;
  final double value;
  final double totalValue;
  const CustomCountDownBar(
      {Key? key, this.width, required this.value, required this.totalValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomCountDownBar(totalValue: totalValue, value: value, width: width);
    double ratio = value / totalValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientWidget(
          gradient: SweepGradient(colors: [
            Color(0xFF9400D3),
            Color(0xFF4B0082),
            Color(0xFF0000FF),
            Color(0xFF00FF00),
            Color(0xFFFFFF00),
            Color(0xFFFF7F00),
            Color(0xFFFF0000),
          ]),
          widget: const Icon(size: 50, Icons.hourglass_full_sharp),
        ),
        SizedBox(
          width: 5,
        ),
        Stack(
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 3,
                child: AnimatedContainer(
                  height: 10,
                  width: width! * ratio,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: (ratio < 0.3)
                        ? Colors.red
                        : (ratio < 0.6)
                            ? Colors.amber[400]
                            : Colors.lightGreen,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
