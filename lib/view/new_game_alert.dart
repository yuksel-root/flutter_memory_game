import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/custom_google_fonts.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as kIsWeb;

class NewGameAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final int score;
  final int? tries;
  final Function menuButtonFunction;
  final Function retryButtonFunction;
  final Function nextButtonFunction;

  const NewGameAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.score,
    required this.tries,
    required this.menuButtonFunction,
    required this.retryButtonFunction,
    required this.nextButtonFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.mediaQuery.size.height;
    final screenWidth = context.mediaQuery.size.width;
    final gameViewProv = Provider.of<GameViewModel>(context);

    final bool kIsWeb = screenWidth > 768;
    final double webScaleFactor = kIsWeb ? 0.8 : 1.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Center(
        child: AnimatedContainer(
          height: kIsWeb ? 700 : screenHeight / 1.1,
          width: kIsWeb ? 600 : null,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: Transform.scale(
            scale: webScaleFactor,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    context.dynamicH(0.005) * context.dynamicW(0.008),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: containerTitleContentWidget(
                      context,
                      screenWidth,
                      kIsWeb,
                    ),
                  ),
                  Expanded(
                    flex: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.deepPurpleColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.yellow,
                            blurRadius: 10,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            context.dynamicH(0.005) * context.dynamicW(0.008),
                          ),
                          bottomRight: Radius.circular(
                            context.dynamicH(0.005) * context.dynamicW(0.008),
                          ),
                        ),
                      ),
                      width: kIsWeb ? 600 : screenWidth / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.deepPurpleColors,
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
                                    child: columnFirstContentWidget(
                                      context,
                                      kIsWeb,
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 10,
                                    child: columnSecondContentWidget(
                                      context,
                                      gameViewProv,
                                      kIsWeb,
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                  Expanded(
                                    flex: 10,
                                    child: columnThirdContentWidget(
                                      context,
                                      gameViewProv,
                                      kIsWeb,
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 5,
                            child: rowButtonsThirdContentWidget(
                              context,
                              kIsWeb,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container containerTitleContentWidget(
    BuildContext context,
    double screenWidth,
    bool kIsWeb,
  ) {
    return Container(
      width: kIsWeb ? 600 : screenWidth / 1.5,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          colors: AppColors.deepPurpleColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            context.dynamicH(0.005) * context.dynamicW(0.008),
          ),
          topLeft: Radius.circular(
            context.dynamicH(0.005) * context.dynamicW(0.008),
          ),
        ),
      ),
      child: Center(
        child: gradientText(
          context,
          title,
          kIsWeb ? 32 : context.dynamicH(0.01) * context.dynamicW(0.014),
          const LinearGradient(colors: AppColors.rainBowColors),
        ),
      ),
    );
  }

  Wrap rowButtonsThirdContentWidget(BuildContext context, bool kIsWeb) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: [
        FittedBox(
          alignment: Alignment.center,
          child: alertBtn(context, "MENU", Icons.menu, kIsWeb),
        ),
        FittedBox(
          alignment: Alignment.center,
          child: alertBtn(context, "RETRY", Icons.replay, kIsWeb),
        ),
        FittedBox(
          alignment: Alignment.center,
          child: alertBtn(context, "NEXT", Icons.skip_next, kIsWeb),
        ),
      ],
    );
  }

  Container columnFirstContentWidget(BuildContext context, bool kIsWeb) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.01) * context.dynamicW(0.01),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          gradientThreeStarXd(
            context, //5*5px for 700h*600w
            kIsWeb
                ? context.dynamicH(0.00714) * context.dynamicW(0.00833)
                : context.dynamicH(0.01) * context.dynamicW(0.01),
          ),
          gradientText(
            context,
            content,
            kIsWeb //5*5px
                ? context.dynamicH(0.00714) * context.dynamicW(0.00833)
                : context.dynamicH(0.01) * context.dynamicW(0.01),
            const LinearGradient(colors: AppColors.rainBowColors),
          ),
        ],
      ),
    );
  }

  Container columnThirdContentWidget(
    BuildContext context,
    GameViewModel gameProv,
    bool kIsWeb,
  ) {
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
            "Score:", //3*3px for 700h 600w
            kIsWeb ? 28 : context.dynamicH(0.01) * context.dynamicW(0.01),
            const LinearGradient(colors: AppColors.fakeRainbowColors),
          ),
          gradientText(
            context,
            gameProv.getScore.toString(),
            kIsWeb ? 28 : context.dynamicH(0.01) * context.dynamicW(0.01),
            const SweepGradient(colors: [Colors.pinkAccent, Colors.pinkAccent]),
          ),
        ],
      ),
    );
  }

  GradientWidget gradientText(
    BuildContext context,
    String text,
    double fontSize,
    Gradient gradient,
  ) {
    return GradientWidget(
      gradient: gradient,
      widget: GoogleFontsText(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        styleOverride: TextStyle(
          fontSize: fontSize,
          letterSpacing: 1,
          shadows: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  Container columnSecondContentWidget(
    BuildContext context,
    GameViewModel gameProv,
    bool kIsWeb,
  ) {
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
          customInfoTexts(
            context,
            gameProv,
            "moves:",
            gameProv.getTries,
            kIsWeb,
          ),
          customInfoTexts(
            context,
            gameProv,
            "times:",
            gameProv.getHighScore,
            kIsWeb,
          ),
          customInfoTexts(
            context,
            gameProv,
            "highscore:",
            gameProv.getHighScore,
            kIsWeb,
          ),
        ],
      ),
    );
  }

  Row customInfoTexts(
    BuildContext context,
    GameViewModel gameProv,
    String titleText,
    Object infoText,
    bool kIsWeb,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        gradientText(
          context,
          " $titleText ",
          kIsWeb ? 20 : context.dynamicH(0.007141) * context.dynamicW(0.01),
          const LinearGradient(
            colors: AppColors.fakeRainbowColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        gradientText(
          context,
          " $infoText",
          kIsWeb ? 20 : context.dynamicH(0.007141) * context.dynamicW(0.01),
          const SweepGradient(colors: AppColors.coolBlue),
        ),
      ],
    );
  }

  CustomBtn alertBtn(
    BuildContext context,
    String text,
    IconData iconName,
    bool kIsWeb,
  ) {
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
        if (text == "MENU") {
          menuButtonFunction();
        } else if (text == "NEXT") {
          nextButtonFunction();
        } else {
          retryButtonFunction();
        }
      },
      child: Column(
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
              size: kIsWeb
                  ? 32
                  : context.dynamicH(0.01) * context.dynamicW(0.014),
            ),
          ),
          gradientText(
            context,
            text,
            kIsWeb ? 20 : context.dynamicH(0.00714) * context.dynamicW(0.01),
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
    return GradientWidget(
      gradient: const RadialGradient(
        colors: AppColors.rainBowColors,
        center: Alignment(0.0, 0.5),
        tileMode: TileMode.clamp,
      ),
      widget: Icon(Icons.star, size: starIconSize),
    );
  }
}
