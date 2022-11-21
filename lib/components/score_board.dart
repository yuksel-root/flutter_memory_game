import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class ScoreBoard extends StatelessWidget {
  final String title;
  final String info;
  const ScoreBoard({Key? key, required this.title, required this.info})
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
          context.dynamicHeight(0.002) * context.dynamicWidth(0.004)), //2*2 4px
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.002) *
            context.dynamicWidth(0.004), //2*2 4px
        horizontal: context.dynamicHeight(0.002) *
            context.dynamicWidth(0.004), //2*2 4px
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF551a8b).withOpacity(0.5),
            const Color(0xFF8b008b).withOpacity(0.5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 1.0],
          tileMode: TileMode.repeated,
        ),
        borderRadius: BorderRadius.circular(
          context.dynamicHeight(0.004) * context.dynamicWidth(0.006), //3*3 9px
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
                  fontSize: context.dynamicHeight(0.007) *
                      context.dynamicWidth(0.01), //5*5 25px
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.dynamicHeight(0.0010), //5px
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
              fontSize:
                  context.dynamicHeight(0.007) * context.dynamicWidth(0.01),
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
