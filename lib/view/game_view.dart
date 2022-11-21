import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/gradient_icon.dart';
import 'package:flutter_memory_game/components/score_board.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/view_model/game_view_model.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    Provider.of<GameViewModel>(context, listen: false).initGame();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameViewProv = Provider.of<GameViewModel>(context);
    final readGameView = context.read<GameViewModel>();

    return Scaffold(
        backgroundColor: const Color(0xFFe55870),
        appBar: gameAppBarWidget(context, readGameView),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.fill,
                  image: AssetImage(GameImgConstants.bg1Png),
                ),
              ),
              height: context.mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  expandedCardWidget(readGameView.getTries,
                      readGameView.getScore, readGameView, gameViewProv),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }

  AppBar gameAppBarWidget(BuildContext context, GameViewModel readGameView) {
    return AppBar(
      flexibleSpace: centerAppBarWidgets(context),
      actions: [actionsAppBarWidgets(readGameView, context)],
      leading: leadingAppBarWidgets(readGameView, context),
      leadingWidth: context.dynamicWidth(2),
      toolbarHeight: context.dynamicHeight(0.12),
    );
  }

  FittedBox actionsAppBarWidgets(
      GameViewModel readGameView, BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          FittedBox(
              fit: BoxFit.scaleDown,
              child: elevatedBtnPauseWidget(readGameView, context)),
          FittedBox(
              child: ScoreBoard(
                  title: "Tries", info: readGameView.getTries.toString())),
        ],
      ),
    );
  }

  FittedBox leadingAppBarWidgets(
      GameViewModel readGameView, BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          FittedBox(
            child: elevatedBtnPeekCards(readGameView, context),
          ),
          FittedBox(
              child: ScoreBoard(
                  title: "Score", info: readGameView.getScore.toString())),
        ],
      ),
    );
  }

  Container centerAppBarWidgets(BuildContext context) {
    return Container(
      height: context.mediaQuery.size.height / 4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF00bfff),
            Color(0xFFbdc3c7),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.repeated,
        ),
      ),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: gameLevelWidget(),
            ),
            SizedBox(
              width: context.dynamicWidth(0.04),
            ),
            Row(
              children: [
                gradientStarWidget(),
                SizedBox(
                  width: context.dynamicWidth(0.01),
                ),
                gradientStarWidget(),
                SizedBox(
                  width: context.dynamicWidth(0.01),
                ),
                gradientStarWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FittedBox gradientStarWidget() {
    // ignore: prefer_const_constructors
    return FittedBox(
      // ignore: prefer_const_constructors
      child: GradientIcon(
        // ignore: prefer_const_constructors
        iconGradient: const SweepGradient(
          colors: [
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.blue,
            Colors.indigo,
            Colors.deepOrangeAccent,
          ],
          startAngle: 0.9,
          endAngle: 6.0,
          tileMode: TileMode.clamp,
        ),
        isbgGradient: false,
        isIconGradient: true,
        Icons.star,
        0.01,
        0.014,
        bgGradient: null,
      ),
    );
  }

  ElevatedButton elevatedBtnPauseWidget(
      GameViewModel readGameView, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
      ), //5*5 25px , 500w 700h
      onPressed: () {
        readGameView.navigateToPage(NavigationConstants.homeView);
        readGameView.restartGame();
      },

      // ignore: prefer_const_constructors
      child: GradientIcon(
        isbgGradient: true,
        bgGradient: LinearGradient(
          colors: [
            Colors.deepPurple.withOpacity(0.8),
            Colors.deepPurpleAccent.withOpacity(0.8),
            Colors.deepPurpleAccent.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        isIconGradient: true,
        Icons.pause,
        0.01,
        0.014,
        iconGradient: const SweepGradient(
          colors: [
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.blue,
            Colors.indigo,
            Colors.deepOrangeAccent,
          ],
          startAngle: 0.9,
          endAngle: 6.0,
          tileMode: TileMode.clamp,
        ),
        iconColor: Colors.white,
      ),
    );
  }

  ElevatedButton elevatedBtnPeekCards(
      GameViewModel readGameView, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
      ), //5*5 25px , 500w 700h
      onPressed: () {
        readGameView.navigateToPage(NavigationConstants.homeView);
        readGameView.restartGame();
      },
      // ignore: prefer_const_constructors
      child: GradientIcon(
        isbgGradient: true,
        bgGradient: LinearGradient(
          colors: [
            Colors.deepPurple.withOpacity(0.8),
            Colors.deepPurpleAccent.withOpacity(0.8),
            Colors.deepPurpleAccent.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        isIconGradient: true,
        iconGradient: const SweepGradient(
          colors: [
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.blue,
            Colors.indigo,
            Colors.deepOrangeAccent,
          ],
          startAngle: 0.9,
          endAngle: 6.0,
          tileMode: TileMode.clamp,
        ),
        Icons.search,
        0.01,
        0.014,
        iconColor: Colors.white,
      ),
    );
  }

  Expanded expandedCardWidget(
      int tries, int score, readGameViewCtx, GameViewModel gameViewProv) {
    return Expanded(
      flex: 100,
      child: GridView.builder(
        itemCount: readGameViewCtx.gameCard!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: context.dynamicWidth(0.02), //10px
          mainAxisSpacing: context.dynamicHeight(0.014), //10px
          childAspectRatio: 1 / 1,
        ),
        padding: EdgeInsets.all(//3*3 4px
            context.dynamicHeight(0.004) * context.dynamicWidth(0.006)),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (readGameViewCtx.gameCard![index] ==
                  GameImgConstants.hiddenCardPng) {
                gameViewProv.openGameCard(index);
                readGameViewCtx.setTries = 1;

                if (readGameViewCtx.matchCheck!.length == 2) {
                  gameViewProv.isMatchCard();
                  if (readGameViewCtx.isMatchedCard) {
                    gameViewProv.setScore = 100;
                    gameViewProv.matchCheck!.clear();
                  } else {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      gameViewProv.closeGameCard();
                    });
                  }
                }
              } else {
                return;
              }
              gameViewProv.gameIsFinish();
              Future.delayed(const Duration(milliseconds: 100), () {
                if (readGameViewCtx.getFinish) {
                  gameViewProv.winnerAlert(context);
                } else {
                  return;
                }
              });
            },
            child: gameCardWidget(context, readGameViewCtx, index),
          );
        },
      ),
    );
  }

  FittedBox gameCardWidget(BuildContext context, readGameViewCtx, int index) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: EdgeInsets.all(context.dynamicHeight(0.004) *
            context.dynamicWidth(0.006)), //3*3 9px
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
            color: const Color(0xFFB2FEFA).withOpacity(0.6),
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(
              context.dynamicHeight(0.002) * context.dynamicWidth(0.004)), //2*2
          image: DecorationImage(
            repeat: ImageRepeat.noRepeat,

            scale: context.dynamicHeight(0.005) *
                context.dynamicWidth(0.008), //4*4
            opacity: 0.9,
            alignment: Alignment.center,
            image: AssetImage(readGameViewCtx.gameCard![index] ==
                    GameImgConstants.hiddenCardPng
                ? GameImgConstants.transparentPng
                : readGameViewCtx.gameCard![index]),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Container gameLevelWidget() {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.dynamicHeight(0.01),
        top: context.dynamicHeight(0.01),
        left: context.dynamicWidth(0.04),
        right: context.dynamicWidth(0.04),
      ),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.deepPurple,
            Colors.deepPurpleAccent,
          ]),
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
              context.dynamicHeight(0.005) * context.dynamicWidth(0.008))),
      child: Row(
        children: [
          Text(
            "STAGE",
            style: TextStyle(
              color: Colors.white,
              fontSize: context.dynamicHeight(0.008) *
                  context.dynamicWidth(0.014), //6*6 36px
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "   1",
            style: TextStyle(
              color: Colors.yellow,
              fontSize:
                  context.dynamicHeight(0.008) * context.dynamicWidth(0.014),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
