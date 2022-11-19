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
        margin: EdgeInsets.all(context.dynamicHeight(0.002) *
            context.dynamicWidth(0.004)), //2*2 4px
        padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.002) *
              context.dynamicWidth(0.004), //2*2 4px
          horizontal: context.dynamicHeight(0.002) *
              context.dynamicWidth(0.004), //2*2 4px
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.deepPurpleAccent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
          borderRadius: BorderRadius.circular(
            context.dynamicHeight(0.004) *
                context.dynamicWidth(0.006), //3*3 9px
          ),
        ),
        child: Center(
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
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Center(
                  child: Text("  :  $info",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.dynamicHeight(0.007) *
                            context.dynamicWidth(0.01),
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
