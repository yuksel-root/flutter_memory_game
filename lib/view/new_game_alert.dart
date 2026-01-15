import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_elevated_button.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

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

  static const LinearGradient goldGradient = LinearGradient(
    colors: AppColors.goldenColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.mediaQuery.size.height;
    final screenWidth = context.mediaQuery.size.width;
    final gameViewProv = Provider.of<GameViewModel>(context);

    final bool kIsWeb = screenWidth > 700;
    final double webScaleFactor = kIsWeb ? 0.8 : 1.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
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
                // Daha seçkin, seviyeli dış ışıma
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF00E5FF).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        gradient: LinearGradient(
                          colors: AppColors.alertTitleColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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
                            flex: 13,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(flex: 1),
                                    Expanded(
                                      flex: 15,
                                      child: columnFirstContentWidget(
                                        context,
                                        kIsWeb,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 20,
                                      child: columnSecondContentWidget(
                                        context,
                                        gameViewProv,
                                        kIsWeb,
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                    Expanded(
                                      flex: 15,
                                      child: columnThirdContentWidget(
                                        context,
                                        gameViewProv,
                                        kIsWeb,
                                      ),
                                    ),
                                    const Spacer(flex: 5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 3,
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF001220),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Center(
        child: gradientText(
          context,
          title,
          kIsWeb ? 40 : context.dynamicH(0.00714) * context.dynamicW(0.01),
          goldGradient,
          hasShadow: true,
        ),
      ),
    );
  }

  Column columnFirstContentWidget(BuildContext context, bool kIsWeb) {
    return Column(
      children: [
        gradientThreeStarXd(
          context,
          kIsWeb ? 40 : context.dynamicH(0.01) * context.dynamicW(0.01),
        ),
        const SizedBox(height: 5),
        gradientText(
          context,
          content,
          kIsWeb ? 40 : context.dynamicH(0.00714) * context.dynamicW(0.01),
          goldGradient,
          hasShadow: true,
        ),
      ],
    );
  }

  Container columnSecondContentWidget(
    BuildContext context,
    GameViewModel gameProv,
    bool kIsWeb,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customInfoTexts(
            context,
            Icons.bolt,
            "MOVES:",
            gameProv.getTries,
            kIsWeb,
          ),
          customInfoTexts(context, Icons.timer, "TIME:", "00:45", kIsWeb),
          customInfoTexts(
            context,
            Icons.emoji_events,
            "BEST:",
            gameProv.getHighScore,
            kIsWeb,
          ),
        ],
      ),
    );
  }

  Padding columnThirdContentWidget(
    BuildContext context,
    GameViewModel gameProv,
    bool kIsWeb,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00E5FF).withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(color: Colors.cyan.withOpacity(0.15), blurRadius: 8),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SCORE:",
              style: TextStyle(
                color: Colors.cyanAccent.withOpacity(0.8),
                fontSize: kIsWeb
                    ? 20
                    : context.dynamicH(0.00714) * context.dynamicW(0.00833),
                fontWeight: FontWeight.bold,
              ),
            ),
            gradientText(
              context,
              gameProv.getScore.toString(),
              kIsWeb
                  ? 20
                  : context.dynamicH(0.00714) * context.dynamicW(0.00833),
              RadialGradient(colors: AppColors.scoreColors, radius: 2),
            ),
          ],
        ),
      ),
    );
  }

  Row customInfoTexts(
    BuildContext context,
    IconData icon,
    String titleText,
    Object infoText,
    bool kIsWeb,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientWidget(
          gradient: RadialGradient(colors: AppColors.scoreColors, radius: 2),
          widget: Icon(
            icon,
            size: kIsWeb
                ? 20
                : context.dynamicH(0.00984) * context.dynamicW(0.00666),
          ),
        ),
        SizedBox(width: context.dynamicW(0.00833)),
        Text(
          titleText,
          style: TextStyle(
            color: Colors.white70,
            fontSize: kIsWeb
                ? 20
                : context.dynamicH(0.00714) * context.dynamicW(0.00666),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: context.dynamicW(0.00833)),
        Text(
          infoText.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: kIsWeb
                ? 20
                : context.dynamicH(0.00714) * context.dynamicW(0.00666),
            fontWeight: FontWeight.bold,
          ),
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
      borderRadius: BorderRadius.circular(15),
      bgGradient: RadialGradient(
        colors: AppColors.btnColors,
        tileMode: TileMode.mirror,
        radius: 3,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF9C27B0).withOpacity(0.4),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.5),
          blurRadius: 0.5,
          offset: const Offset(0, -1.5),
        ),
      ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientWidget(
            gradient: goldGradient,
            widget: Icon(
              iconName,
              size: context.dynamicH(0.012) * context.dynamicW(0.007),
              shadows: [
                Shadow(
                  color: Colors.orange.withOpacity(0.6),
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
                const Shadow(
                  color: Colors.black45,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          gradientText(
            context,
            text,
            context.dynamicH(0.00714) * context.dynamicW(0.00666),
            goldGradient,
          ),
        ],
      ),
    );
  }

  Wrap rowButtonsThirdContentWidget(BuildContext context, bool kIsWeb) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: [
        alertBtn(context, "MENU", Icons.grid_view_rounded, kIsWeb),
        alertBtn(context, "RETRY", Icons.refresh_rounded, kIsWeb),
        alertBtn(context, "NEXT", Icons.play_arrow_rounded, kIsWeb),
      ],
    );
  }

  Wrap gradientThreeStarXd(BuildContext context, double starIconSize) {
    return Wrap(
      spacing: 5,
      children: List.generate(
        3,
        (index) => gradientStarWidget(context, starIconSize),
      ),
    );
  }

  GradientWidget gradientStarWidget(BuildContext context, double starIconSize) {
    return GradientWidget(
      gradient: goldGradient,
      widget: Icon(
        Icons.stars,
        size: starIconSize,
        shadows: [
          Shadow(color: Colors.orange.withOpacity(0.5), blurRadius: 10),
        ],
      ),
    );
  }

  GradientWidget gradientText(
    BuildContext context,
    String text,
    double fontSize,
    Gradient gradient, {
    bool hasShadow = true,
  }) {
    return GradientWidget(
      gradient: gradient,
      widget: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          fontFamily: 'Serif',
          shadows: hasShadow
              ? [
                  const Shadow(
                    color: Color.fromARGB(221, 211, 248, 2),
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
