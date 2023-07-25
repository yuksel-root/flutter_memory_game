import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final int score;
  final int? tries;
  final Function continueFunction;
  final String continueButtonText;
  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.score,
      required this.tries,
      required this.continueFunction,
      required this.continueButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.mediaQuery.size.height;
    final screenWidth = context.mediaQuery.size.width;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Center(
        child: AnimatedContainer(
          height: screenHeight / 1.1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  context.dynamicH(0.005) * context.dynamicW(0.008))),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: containerTitleContentWidget(context, screenWidth),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(context.dynamicH(0.005) *
                              context.dynamicW(0.008)),
                          bottomRight: Radius.circular(context.dynamicH(0.005) *
                              context.dynamicW(0.008)),
                        ),
                      ),
                      width: screenWidth / 1.5,
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                  context.dynamicH(0.005) *
                                      context.dynamicW(0.008),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: columnFirstContentWidget(context),
                                  ),
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 10,
                                    child: columnSecondContentWidget(context),
                                  ),
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 10,
                                    child: columnThirdContentWidget(context),
                                  ),
                                  const Spacer(flex: 1),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 7,
                            child: rowButtonsThirdContentWidget(context),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container containerTitleContentWidget(
      BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
          topLeft: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
        ),
        color: Colors.purple,
      ),
      child: Center(
          child: gradientText(
        context,
        "STAGE 1",
        context.dynamicH(0.01) * context.dynamicW(0.014),
      )),
    );
  }

  Wrap rowButtonsThirdContentWidget(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: [
        FittedBox(
            alignment: Alignment.center,
            child: alertBtn(context, "MENU", Icons.menu)),
        FittedBox(
            alignment: Alignment.center,
            child: alertBtn(context, "RETRY", Icons.replay)),
        FittedBox(
            alignment: Alignment.center,
            child: alertBtn(context, "NEXT", Icons.skip_next)),
      ],
    );
  }

  Container columnFirstContentWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.005) * context.dynamicW(0.008),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            gradientThreeStarXd(
              context,
              context.dynamicH(0.0114) * context.dynamicW(0.016),
            ),
            gradientText(
              context,
              "WELL DONE",
              context.dynamicH(0.01) * context.dynamicW(0.014),
            ),
          ]),
    );
  }

  Container columnThirdContentWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.005) * context.dynamicW(0.008),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            gradientText(
              context,
              "Score:",
              context.dynamicH(0.01) * context.dynamicW(0.014),
            ),
            gradientText(
              context,
              "500",
              context.dynamicH(0.01) * context.dynamicW(0.014),
            ),
          ]),
    );
  }

  GradientWidget gradientText(
      BuildContext context, String text, double fontSize) {
    return GradientWidget(
      gradient: LinearGradient(colors: [
        Colors.pink,
        Colors.redAccent,
        Colors.amber,
      ]),
      widget: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: text,
              style: GoogleFonts.bungeeSpice(),
            ),
          ],
          style: TextStyle(fontSize: fontSize, letterSpacing: 1, shadows: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              offset: Offset(1, 1),
            )
          ]),
        ),
      ),
    );
  }

  Container columnSecondContentWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.005) * context.dynamicW(0.008),
        ),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            gradientText(
              context,
              " Moves: 300 ",
              context.dynamicH(0.007141) * context.dynamicW(0.01),
            ),
            gradientText(
              context,
              "   TIMES: 117 ",
              context.dynamicH(0.00714) * context.dynamicW(0.01),
            ),
            gradientText(
              context,
              " Bonus: 0 ",
              context.dynamicH(0.00714) * context.dynamicW(0.01),
            ),
          ]),
    );
  }

  CustomBtn alertBtn(BuildContext context, String text, IconData iconName) {
    return CustomBtn(
      borderRadius: BorderRadius.circular(
        context.dynamicH(0.005) * context.dynamicW(0.008),
      ),
      bgGradient: LinearGradient(
        colors: [
          Colors.deepPurple.withOpacity(0.5),
          Colors.deepPurpleAccent.withOpacity(0.5),
          Colors.deepPurpleAccent.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      onPressFunc: () {},
      child: Column(
        children: [
          GradientWidget(
            gradient: const SweepGradient(
              colors: [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000),
              ],
              startAngle: 0.9,
              endAngle: 6.0,
              tileMode: TileMode.clamp,
            ),
            widget: Icon(
              iconName,
              size: context.dynamicH(0.01) * context.dynamicW(0.014),
            ),
          ),
          gradientText(
            context,
            text,
            context.dynamicH(0.00714) * context.dynamicW(0.01),
          )
        ],
      ),
    );
  }

  Wrap gradientThreeStarXd(BuildContext context, double starIconSize) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 2,
      children: [
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
        gradientStarWidget(context, starIconSize),
      ],
    );
  }

  GradientWidget gradientStarWidget(BuildContext context, double starIconSize) {
    // ignore: prefer_const_constructors
    return GradientWidget(
      // ignore: prefer_const_constructors
      gradient: const RadialGradient(
        colors: [
          Color(0xFF9400D3),
          Color(0xFF4B0082),
          Color(0xFF0000FF),
          Color(0xFF00FF00),
          Color(0xFFFFFF00),
          Color(0xFFFF7F00),
          Color(0xFFFF0000),
        ],
        center: Alignment(0.0, 0.5),
        tileMode: TileMode.clamp,
      ),

      widget: Icon(
        Icons.star,
        size: starIconSize,
      ),
    );
  }
}
