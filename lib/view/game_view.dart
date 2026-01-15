import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_app_bar.dart';
import 'package:flutter_memory_game/components/custom_countdown_bar.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
import 'package:flutter_memory_game/components/score_board.dart';
import 'package:flutter_memory_game/core/constants/app_colors.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter_memory_game/core/notifier/timeState_provider.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:flutter_memory_game/view_model/sound_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late bool init;
  late NavigationService _navigation;

  @override
  void initState() {
    init = false;
    super.initState();
    if (!context.mounted) return;
    _navigation = NavigationService.instance;
    Provider.of<GameViewModel>(context, listen: false).initGame(context);

    Future.microtask(() async {
      if (!context.mounted) return;
      await Future.delayed(const Duration(milliseconds: 200)).then((value) {
        if (!context.mounted) return;
        Provider.of<GameViewModel>(context, listen: false).setOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameViewProv = Provider.of<GameViewModel>(context);
    final timeProv = Provider.of<TimerProvider>(context, listen: true);
    final soundProv = Provider.of<SoundViewModel>(context);

    if (init == false) {
      print("if init game view");

      context.read<TimerProvider>().startTime(context);

      init = true;
    }

    return scaffoldWidget(context, gameViewProv, timeProv, soundProv);
  }

  Scaffold scaffoldWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    TimerProvider timeProv,
    SoundViewModel soundProv,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        dynamicPreferredSize: context.dynamicH(0.15),
        appBar: gameAppBarWidget(context, gameViewProv, timeProv),
      ),
      body: AnimatedOpacity(
        opacity: gameViewProv.getOpacity,
        curve: Curves.elasticInOut,
        duration: const Duration(microseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(gameViewProv.getBgImages),
              fit: BoxFit.cover,
            ),
          ),
          height: context.mediaQuery.size.height,
          width: context.mediaQuery.size.width,
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: context.mediaQuery.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    expandedCardWidget(
                      gameViewProv.getTries,
                      gameViewProv.getScore,
                      gameViewProv,
                      soundProv,
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Image setBackgroundImageWidget(
    GameViewModel gameViewProv,
    BuildContext context,
  ) {
    return Image.asset(
      gameViewProv.getBgImages,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fill,
    );
  }

  AppBar gameAppBarWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    TimerProvider timeProv,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: flexibleAppBarWidgets(context, gameViewProv, timeProv),
    );
  }

  FittedBox flexibleAppBarWidgets(
    BuildContext context,
    GameViewModel gameViewProv,
    TimerProvider timerProv,
  ) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(top: context.dynamicH(0.014)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: context.dynamicW(0.15),
              children: [
                elevatedBtnPeekCards(context, gameViewProv),
                gameLevelWidget(gameViewProv),
                elevatedBtnPauseWidget(gameViewProv, context, timerProv),
              ],
            ),
            gameInfoWidgets(gameViewProv),
            SizedBox(height: context.dynamicH(0.007)),
            FittedBox(
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: context.dynamicW(0.17),
                children: [
                  Center(
                    child: Consumer<TimerProvider>(
                      builder: (context, timeState, _) => FutureBuilder(
                        future: Future.delayed(
                          Duration.zero,
                          () => {
                            timeState.getTimeState == TimeState.timerFinish
                                ? {gameViewProv.nextStageAlert(context)}
                                : {
                                    timeState.getTimeState ==
                                            TimeState.timerPaused
                                        ? {gameViewProv.pauseGameAlert(context)}
                                        : {},
                                  },
                          },
                        ),
                        builder: (context, snapshot) {
                          return CustomCountDownBar(
                            width: context.dynamicW(0.9),
                            value: timeState.getTime.abs(),
                            totalValue: context.dynamicW(0.9),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Wrap gameInfoWidgets(GameViewModel gameProv) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: context.mediaQuery.size.width / 2,
      children: [
        ScoreBoard(
          title: "Scores",
          info: gameProv.getScore.toString(),
          bgGradient: LinearGradient(
            colors: [
              const Color(0xFF8470ff).withOpacity(0.5),
              const Color(0xFF8470ff).withOpacity(0.5),
            ],
          ),
        ),
        ScoreBoard(
          title: "Tries",
          info: gameProv.getTries.toString(),
          bgGradient: LinearGradient(
            colors: [
              const Color(0xFF8470ff).withOpacity(0.5),
              const Color(0xFF8470ff).withOpacity(0.5),
            ],
          ),
        ),
      ],
    );
  }

  Wrap gradientThreeStarXd() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: 2,
      children: [
        gradientStarWidget(),
        gradientStarWidget(),
        gradientStarWidget(),
      ],
    );
  }

  FittedBox gradientStarWidget() {
    // ignore: prefer_const_constructors
    return FittedBox(
      // ignore: prefer_const_constructors
      child: GradientWidget(
        // ignore: prefer_const_constructors
        gradient: const RadialGradient(
          colors: AppColors.rainBowColors,
          center: Alignment(0.0, 0.5),
          tileMode: TileMode.clamp,
        ),

        widget: Icon(
          Icons.star,
          size: context.dynamicH(0.01) * context.dynamicW(0.014),
        ),
      ),
    );
  }

  ElevatedButton elevatedBtnPauseWidget(
    GameViewModel gameProv,
    BuildContext context,
    TimerProvider timeProv,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.transparent;
          }
          if (states.contains(MaterialState.pressed)) {
            return Colors.transparent;
          }
          return null;
        }),
      ),
      onPressed: () {
        gameProv.pauseGameAlert(context);

        context.read<TimerProvider>().stopTimer(context, reset: false);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            context.dynamicH(0.01) * context.dynamicW(0.014),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GradientWidget(
          widget: Icon(
            Icons.pause,
            size: context.dynamicH(0.01) * context.dynamicW(0.014),
          ),
          gradient: const SweepGradient(
            colors: AppColors.rainBowColors,
            startAngle: 0.9,
            endAngle: 6.0,
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }

  ElevatedButton elevatedBtnPeekCards(
    BuildContext context,
    GameViewModel gameProv,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.transparent;
          }
          if (states.contains(MaterialState.pressed)) {
            return Colors.transparent;
          }
          return null;
        }),
      ),
      onPressed: () {
        gameProv.setPeekCardCount = 1;
        if (gameProv.getPeekCardCount < 2) {
          if ((gameProv.getPeekCardCount % 2) != 0) {
            gameProv.openAllGameCard();
          } else {
            return;
          }
        } else {
          return;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
              Colors.deepPurpleAccent.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            context.dynamicH(0.01) * context.dynamicW(0.014),
          ),
        ),
        child: GradientWidget(
          gradient: const SweepGradient(
            colors: AppColors.rainBowColors,
            startAngle: 0.9,
            endAngle: 6.0,
            tileMode: TileMode.clamp,
          ),
          widget: Icon(
            Icons.search,
            size: context.dynamicH(0.01) * context.dynamicW(0.014),
          ),
        ),
      ),
    );
  }

  Expanded expandedCardWidget(
    int tries,
    int score,
    GameViewModel gameViewProv,
    SoundViewModel soundProv,
  ) {
    return Expanded(
      flex: 100,
      child: GridView.builder(
        itemCount: gameViewProv.gameCard!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: context.dynamicW(0.02), //10px
          mainAxisSpacing: context.dynamicH(0.014), //10px
          childAspectRatio: 1 / 1,
        ),
        padding: EdgeInsets.all(
          //3*3 4px
          context.dynamicH(0.004) * context.dynamicW(0.006),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              gameViewProv.clickCard(index, context, soundProv);
            },
            child: TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0.0,
                end: gameViewProv.getAngleArr(index),
              ),
              duration: const Duration(milliseconds: 650),
              builder: (BuildContext context, double val, __) {
                return Transform(
                  transform: Matrix4.rotationY(val)..setEntry(3, 2, 0.01),
                  alignment: Alignment.center,
                  child: gameCardWidget(context, gameViewProv, index),
                );
              },
            ),
          );
        },
      ),
    );
  }

  FittedBox gameCardWidget(
    BuildContext context,
    GameViewModel gameViewProv,
    int index,
  ) {
    final angle = gameViewProv.getAngleArr(index);
    final isFront = angle > pi / 2;
    return (FittedBox(
      fit: BoxFit.contain,
      child: Transform(
        alignment: Alignment.center,
        transform: isFront ? Matrix4.rotationY(pi) : Matrix4.identity(),
        child: Container(
          padding: EdgeInsets.all(
            context.dynamicH(0.004) * context.dynamicW(0.006),
          ), //3*3 9px
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFB2FEFA).withOpacity(0.6),
                const Color(0xFF6dd5ed).withOpacity(0.6),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
            border: Border.all(
              color: gameViewProv.getCardBorderColors(index),
              width: gameViewProv.getCardBorderWidth(index),
            ),
            borderRadius: BorderRadius.circular(
              context.dynamicH(0.002) * context.dynamicW(0.004),
            ), //2*2
            image: DecorationImage(
              repeat: ImageRepeat.noRepeat,

              scale: context.dynamicH(0.005) * context.dynamicW(0.008), //4*4
              opacity: 0.9,
              alignment: Alignment.center,
              image: AssetImage(
                gameViewProv.gameCard![index] == GameImgConstants.hiddenCardPng
                    ? GameImgConstants.transparentPng
                    : gameViewProv.gameCard![index],
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ));
  }

  Container gameStageWidget(GameViewModel gameViewProv) {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.dynamicH(0.001),
        top: context.dynamicH(0.001),
        left: context.dynamicW(0.02),
        right: context.dynamicW(0.02),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8470ff).withOpacity(0.5),
            const Color(0xFF8470ff).withOpacity(0.5),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8470ff).withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.005) * context.dynamicW(0.008),
        ),
      ),
      child: Row(
        children: [
          GradientWidget(
            gradient: const LinearGradient(colors: AppColors.rainBowColors),
            widget: Text(
              "STAGE",
              style: TextStyle(
                fontSize: context.dynamicH(0.008) * context.dynamicW(0.014),
              ),
            ),
          ),
          SizedBox(width: context.dynamicW(0.05)),
          GradientWidget(
            gradient: const RadialGradient(
              colors: AppColors.rainBowColors,
              center: Alignment(0.0, 0.3),
              tileMode: TileMode.clamp,
            ),
            widget: Text(
              gameViewProv.getStage.toString(),
              style: TextStyle(
                fontSize: context.dynamicH(0.009) * context.dynamicW(0.016),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container gameLevelWidget(GameViewModel gameViewProv) {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.dynamicH(0.001),
        top: context.dynamicH(0.001),
        left: context.dynamicW(0.02),
        right: context.dynamicW(0.02),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8470ff).withOpacity(0.5),
            const Color(0xFF8470ff).withOpacity(0.5),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8470ff).withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          context.dynamicH(0.005) * context.dynamicW(0.008),
        ),
      ),
      child: Row(
        children: [
          GradientWidget(
            gradient: const LinearGradient(colors: AppColors.rainBowColors),
            widget: Text(
              "LEVEL",
              style: TextStyle(
                fontSize: context.dynamicH(0.008) * context.dynamicW(0.014),
              ),
            ),
          ),
          SizedBox(width: context.dynamicW(0.05)),
          GradientWidget(
            gradient: const RadialGradient(
              colors: AppColors.rainBowColors,
              center: Alignment(0.0, 0.3),
              tileMode: TileMode.clamp,
            ),
            widget: Text(
              gameViewProv.getStage.toString(),
              style: TextStyle(
                fontSize: context.dynamicH(0.009) * context.dynamicW(0.016),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
