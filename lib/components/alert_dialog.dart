import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/components/score_board.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class GameAlertView extends StatelessWidget {
  final String title;
  final String content;
  final int score;
  final int tries;
  final Function continueFunction;
  final String continueButtonText;

  const GameAlertView(
      {Key? key,
      required this.title,
      required this.content,
      required this.continueFunction,
      required this.continueButtonText,
      required this.score,
      required this.tries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), //add blur
        child: alertDialogWidget(context));
  }

  GradientWidget alertDialogWidget(BuildContext context) {
    return GradientWidget(
      gradient: LinearGradient(colors: [
        Colors.grey.withOpacity(0.1),
        Colors.white.withOpacity(0.1),
      ]),
      widget: AlertDialog(
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: EdgeInsets.all(
            context.dynamicHeight(0.005) * context.dynamicWidth(0.008)),
        alignment: Alignment.center,
        buttonPadding: EdgeInsets.all(
            context.dynamicHeight(0.005) * context.dynamicWidth(0.008)),
        title: FittedBox(
          fit: BoxFit.contain,
          child: GradientWidget(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000),
              ],
            ),
            widget: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: context.dynamicHeight(0.005) *
                    context.dynamicWidth(0.008), //4*4 16px
                fontFamily: "Greycliff CF Bold",
              ),
            ),
          ),
        ),
        content: contentTextWidget(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.dynamicHeight(0.005) *
                context.dynamicWidth(0.008))), //4*4 16px
        actions: continueButtonWidget(context),
      ),
    );
  }

  FittedBox contentTextWidget(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: [
          GradientWidget(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000),
              ],
            ),
            widget: Text(
              content,
              maxLines: 3,
              style: TextStyle(
                fontSize: context.dynamicHeight(0.005) *
                    context.dynamicWidth(0.008), //4*4 16px
                fontFamily: "Greycliff CF Medium",
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: context.dynamicWidth(0.01),
            children: [
              FittedBox(child: boardScoreWidget(context)),
              FittedBox(
                child: boardTriesWidget(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> continueButtonWidget(BuildContext context) {
    return <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          animationDuration: const Duration(milliseconds: 1000),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: GradientWidget(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000),
              ],
            ),
            widget: Text(
              continueButtonText,
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: context.dynamicHeight(0.007) *
                    context.dynamicWidth(0.01), //5*5 25px
                fontFamily: "Greycliff CF Bold",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onPressed: () {
          continueFunction();
        },
      ),
    ];
  }

  Container boardScoreWidget(BuildContext context) {
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
      child: scoreTextWidget(context),
    );
  }

  Container boardTriesWidget(BuildContext context) {
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
      child: triesTextWidget(context),
    );
  }

  Center triesTextWidget(BuildContext context) {
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
                "Tries",
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
          triesTextWidget(context)
        ],
      ),
    );
  }

  Center scoreTextWidget(BuildContext context) {
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
                "Score",
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
          triesTextWidget(context)
        ],
      ),
    );
  }

  FittedBox scoreFTextWidget(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Center(
        child: Text("  :  $score",
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

  FittedBox triesFTextWidget(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Center(
        child: Text("  :  $tries",
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
