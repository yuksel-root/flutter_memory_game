import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class ScoreBoard extends StatelessWidget {
  final String title;
  final String info;
  final Gradient bgGradient;
  const ScoreBoard(
      {Key? key,
      required this.title,
      required this.info,
      required this.bgGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: boardContainerWidget(context),
    );
  }

  Container boardContainerWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
          context.dynamicH(0.002) * context.dynamicW(0.004)), //2*2 4px
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicH(0.002) * context.dynamicW(0.004), //2*2 4px
        horizontal: context.dynamicH(0.002) * context.dynamicW(0.004), //2*2 4px
      ),
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.004) * context.dynamicW(0.006), //3*3 9px
        ),
      ),
      child: titleTextWidget(context),
    );
  }

  Center titleTextWidget(BuildContext context) {
    return Center(
      child: Row(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.dynamicH(0.007) *
                      context.dynamicW(0.01), //5*5 25px
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.dynamicH(0.0010), //5px
          ),
          infoTextWidget(context)
        ],
      ),
    );
  }

  FittedBox infoTextWidget(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Center(
        child: Text("  :  $info",
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.dynamicH(0.007) * context.dynamicW(0.01),
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
