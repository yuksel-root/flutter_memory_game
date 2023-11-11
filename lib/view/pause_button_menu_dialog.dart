import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PauseButtonMenuDialog extends StatelessWidget {
  final Function menuButtonFunction;
  final Function newGameButtonFunction;
  final Function continueBtnFunction;
  final Function soundBtnFunction;

  const PauseButtonMenuDialog(
      {Key? key,
      required this.menuButtonFunction,
      required this.newGameButtonFunction,
      required this.continueBtnFunction,
      required this.soundBtnFunction})
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
              height: screenHeight / 2.3799,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(
                        context.dynamicH(0.005) * context.dynamicW(0.008))),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 100,
                          child: Container(
                            width: screenWidth / 1.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 100,
                                  child: alertBtn(context, "  SOUND ON ",
                                      Icons.surround_sound),
                                ),
                                const Spacer(flex: 1),
                                Expanded(
                                    flex: 100,
                                    child: alertBtn(context,
                                        "  MENU             ", Icons.menu)),
                                const Spacer(flex: 1),
                                Expanded(
                                  flex: 100,
                                  child: alertBtn(context, "   NEW GAME ",
                                      Icons.add_card_sharp),
                                ),
                                const Spacer(flex: 1),
                                Expanded(
                                  flex: 100,
                                  child: alertBtn(context, "    CONTINUE ",
                                      Icons.skip_next),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )))),
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
          offset: const Offset(0, 4),
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
      onPressFunc: () {
        switch (text) {
          case "  SOUND ON ":
            soundBtnFunction();
            print("SOUND");
            break;
          case "  MENU             ":
            menuButtonFunction();
            print(" MENU ");
            break;
          case "   NEW GAME ":
            newGameButtonFunction();
            print("NEW GAME");
            break;
          case "    CONTINUE ":
            continueBtnFunction();
            print("CONTINUE");
            break;

          default:
            print("DEF");
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientWidget(
            gradient: const SweepGradient(
              colors: AppColors.rainBowColors,
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
            const LinearGradient(
              colors: AppColors.coolBlue,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
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
          style:
              TextStyle(fontSize: fontSize, letterSpacing: 1, shadows: const [
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
}
