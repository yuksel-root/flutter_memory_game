import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

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
    print({"w: ": width});
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage("assets/icons_png/hg.png"),
          height: context.dynamicH(0.042),
          width: context.dynamicW(0.06),
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
