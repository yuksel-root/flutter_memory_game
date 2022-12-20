import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

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
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: containerTitleContentWidget(context, screenWidth),
                ),
                Expanded(
                  child: Container(
                      color: Colors.red,
                      width: screenWidth / 1.5,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 5,
                                    child: columnFirstContentWidget(context),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: columnSecondContentWidget(context),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.indigo,
      ),
      child: Center(
        child: GradientWidget(
          gradient: const LinearGradient(colors: [
            Color(0xFF9400D3),
            Color(0xFF4B0082),
            Color(0xFF0000FF),
            Color(0xFF00FF00),
            Color(0xFFFFFF00),
            Color(0xFFFF7F00),
            Color(0xFFFF0000),
          ]),
          widget: Text(
            "STAGE 0",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.dynamicH(0.01) * context.dynamicW(0.014),
                letterSpacing: 5,
                shadows: [
                  Shadow(
                    offset: Offset(3, 3),
                    blurRadius: 10,
                  ),
                  Shadow(
                    offset: Offset(-3, -3),
                    blurRadius: 10,
                  )
                ],
                color: Colors.deepPurpleAccent.shade100),
          ),
        ),
      ),
    );
  }

  Row rowButtonsThirdContentWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: alertBtn(context, "MENU", Icons.menu)),
        Expanded(child: alertBtn(context, "RETRY", Icons.replay)),
        Expanded(child: alertBtn(context, "NEXT", Icons.skip_next)),
      ],
    );
  }

  Column columnFirstContentWidget(BuildContext context) {
    return Column(children: [
      gradientThreeStarXd(
        context,
        context.dynamicH(0.01) * context.dynamicW(0.014),
      ),
      gradientText(context, "OPEN"),
      gradientText(context, "4"),
      const GradientWidget(
          gradient: LinearGradient(colors: [Colors.white, Colors.yellow]),
          widget: Icon(Icons.star)),
      gradientText(context, "4"),
    ]);
  }

  GradientWidget gradientText(BuildContext context, String text) {
    return GradientWidget(
      gradient: LinearGradient(colors: [
        Colors.grey.shade400,
        Colors.white,
      ]),
      widget: Text(
        "open : 5 ",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.dynamicH(0.00714) * context.dynamicW(0.01),
            letterSpacing: 5,
            shadows: const [
              Shadow(
                offset: Offset(3, 3),
                blurRadius: 10,
              ),
              Shadow(
                offset: Offset(-3, -3),
                blurRadius: 10,
              )
            ],
            color: Colors.deepPurpleAccent.shade100),
      ),
    );
  }

  Column columnSecondContentWidget(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientThreeStarXd(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: gradientText(context, "open : 5 ")),
        ],
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientTwoStarXd(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GradientWidget(
              gradient: LinearGradient(colors: [
                Colors.grey.shade400,
                Colors.white,
              ]),
              widget: Text(
                "open : 7 ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        context.dynamicH(0.00714) * context.dynamicW(0.01),
                    letterSpacing: 5,
                    shadows: const [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      ),
                      Shadow(
                        offset: Offset(-3, -3),
                        blurRadius: 10,
                      )
                    ],
                    color: Colors.deepPurpleAccent.shade100),
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: gradientStarWidget(
                context, context.dynamicH(0.008) * context.dynamicW(0.012)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GradientWidget(
              gradient: LinearGradient(colors: [
                Colors.grey.shade400,
                Colors.white,
              ]),
              widget: Text(
                "open - ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        context.dynamicH(0.00714) * context.dynamicW(0.01),
                    letterSpacing: 5,
                    shadows: const [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      ),
                      Shadow(
                        offset: Offset(-3, -3),
                        blurRadius: 10,
                      )
                    ],
                    color: Colors.deepPurpleAccent.shade100),
              ),
            ),
          ),
        ],
      ),
    ]);
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
      child: FittedBox(
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
                size: context.dynamicH(0.014) * context.dynamicW(0.02),
              ),
            ),
            GradientWidget(
              gradient: const LinearGradient(colors: [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000),
              ]),
              widget: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.dynamicH(0.01) * context.dynamicW(0.014),
                    letterSpacing: 5,
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 10,
                      ),
                      Shadow(
                        offset: Offset(-3, -3),
                        blurRadius: 10,
                      )
                    ],
                    color: Colors.deepPurpleAccent.shade100),
              ),
            ),
          ],
        ),
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

  Wrap gradientTwoStarXd(BuildContext context, double starIconSize) {
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
