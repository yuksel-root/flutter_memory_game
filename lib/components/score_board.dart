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
      child: Container(
        margin: EdgeInsets.all(context.dynamicWidth(0.06)), // 24/400
        padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.0114),
          horizontal: context.dynamicWidth(0.065),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22.0, //max text size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.0085714),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(info,
                  style: const TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
