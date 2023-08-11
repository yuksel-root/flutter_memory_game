import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view/game_view.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    final gameViewProv = Provider.of<GameViewModel>(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Center(
        child: AnimatedContainer(
          height: screenHeight / 1.1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(
                  context.dynamicH(0.005) * context.dynamicW(0.008))),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: containerTitleContentWidget(context, screenWidth),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Color(0xff6dd5ed),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ],
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple,
                                    Color(0xff6dd5ed),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: Offset(0, 10),
                                  ),
                                ],
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
                                    child: columnSecondContentWidget(
                                        context, gameViewProv),
                                  ),
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 10,
                                    child: columnThirdContentWidget(
                                        context, gameViewProv),
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Color(0xff6dd5ed),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
          topLeft: Radius.circular(
              context.dynamicH(0.005) * context.dynamicW(0.008)),
        ),
      ),
      child: Center(
          child: gradientText(
        context,
        "STAGE 1",
        context.dynamicH(0.01) * context.dynamicW(0.014),
        LinearGradient(
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
              context.dynamicH(0.01) * context.dynamicW(0.01),
              LinearGradient(
                colors: AppColors.rainBowColors,
              ),
            ),
          ]),
    );
  }

  Container columnThirdContentWidget(
      BuildContext context, GameViewModel gameProv) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
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
              context.dynamicH(0.01) * context.dynamicW(0.01),
              LinearGradient(
                colors: [
                  Color(0xff70e1f5),
                  Color(0xffffd194),
                ],
              ),
            ),
            gradientText(
              context,
              gameProv.getScore.toString(),
              context.dynamicH(0.01) * context.dynamicW(0.01),
              LinearGradient(
                colors: [
                  Color(0xfff12711),
                  Color(0xfff5af19),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ]),
    );
  }

  GradientWidget gradientText(
      BuildContext context, String text, double fontSize, Gradient gradient) {
    return GradientWidget(
      gradient: gradient,
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

  Container columnSecondContentWidget(
      BuildContext context, GameViewModel gameProv) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 10),
          ),
        ],
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
              " Moves: ${gameProv.getTries}",
              context.dynamicH(0.007141) * context.dynamicW(0.01),
              LinearGradient(
                colors: AppColors.coolBlue,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            gradientText(
              context,
              "   TIMES: 117 ",
              context.dynamicH(0.00714) * context.dynamicW(0.01),
              LinearGradient(
                colors: AppColors.coolBlue,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            gradientText(
              context,
              " HighScore: ${gameProv.getHighScore} ",
              context.dynamicH(0.00714) * context.dynamicW(0.01),
              LinearGradient(
                colors: AppColors.coolBlue,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ]),
    );
  }

  CustomBtn alertBtn(BuildContext context, String text, IconData iconName) {
    return CustomBtn(
      borderRadius: BorderRadius.circular(
        context.dynamicH(0.005) * context.dynamicW(0.008),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurpleAccent.withOpacity(0.5),
          blurRadius: 10,
          spreadRadius: 0.5,
          offset: Offset(0, 4),
        ),
      ],
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
            LinearGradient(
              colors: AppColors.coolBlue,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
