import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class ScoreBoard extends StatelessWidget {
  final String title;
  final String info;
  const ScoreBoard({Key? key, required this.title, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(context.dynamicWidth(0.0125)),
        padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.007), //5px = 5/700px
          horizontal: context.dynamicWidth(0.0125), //5px = 5/400px
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            context.dynamicWidth(0.025), //10px
          ),
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0, //max text size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.007), //5px
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(info,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
