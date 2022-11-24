import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/custom_app_bar.dart';
import 'package:flutter_memory_game/components/gradient_widget.dart';
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
        appBar: CustomAppBar(
          dynamicPreferredSize: context.dynamicHeight(0.15),
          appBar: gameAppBarWidget(context, readGameView, gameViewProv),
        ),
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

  AppBar gameAppBarWidget(BuildContext context, GameViewModel readGameView,
      GameViewModel gameViewProv) {
    return AppBar(
      flexibleSpace: flexibleAppBarWidgets(context, readGameView, gameViewProv),
    );
  }

  FittedBox flexibleAppBarWidgets(
      BuildContext context, GameViewModel readGameView, gameViewProv) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.014)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: context.dynamicWidth(0.15),
              children: [
                elevatedBtnPeekCards(readGameView, context, gameViewProv),
                gameLevelWidget(),
                elevatedBtnPauseWidget(readGameView, context),
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.007)),
            FittedBox(
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: context.dynamicWidth(0.17),
                children: [
                  ScoreBoard(
                      title: "Score", info: readGameView.getScore.toString()),
                  gradientThreeStarXd(),
                  ScoreBoard(
                      title: "Tries", info: readGameView.getTries.toString())
                ],
              ),
            ),
          ],
        ),
      ),
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
          size: context.dynamicHeight(0.01) * context.dynamicWidth(0.014),
        ),
      ),
    );
  }

  ElevatedButton elevatedBtnPauseWidget(
      GameViewModel readGameView, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        readGameView.navigateToPageClear(NavigationConstants.homeView);
        readGameView.restartGame();
      },

      // ignore: prefer_const_constructors
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              context.dynamicHeight(0.01) * context.dynamicWidth(0.014)),
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
            size: context.dynamicHeight(0.01) * context.dynamicWidth(0.014),
          ),
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
        ),
      ),
    );
  }

  ElevatedButton elevatedBtnPeekCards(GameViewModel readGameView,
      BuildContext context, GameViewModel gameProv) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          },
        ),
      ),
      onPressed: () {
        gameProv.setPeekCardCount = 1;

        if ((readGameView.getPeekCardCount % 2) != 0) {
          gameProv.openAllGameCard();
        } else {
          gameProv.closeAllGameCard();
        }
      },
      // ignore: prefer_const_constructors
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
              context.dynamicHeight(0.01) * context.dynamicWidth(0.014)),
        ),
        child: GradientWidget(
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
            Icons.search,
            size: context.dynamicHeight(0.01) * context.dynamicWidth(0.014),
          ),
        ),
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
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Container gameLevelWidget() {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.dynamicHeight(0.001),
        top: context.dynamicHeight(0.001),
        left: context.dynamicWidth(0.02),
        right: context.dynamicWidth(0.02),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFF8470ff).withOpacity(0.5),
          const Color(0xFF8470ff).withOpacity(0.5),
        ]),
        border: Border.all(
          color: Color(0xFF8470ff).withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
            context.dynamicHeight(0.005) * context.dynamicWidth(0.008)),
      ),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
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
              "STAGE",
              style: TextStyle(
                fontSize:
                    context.dynamicHeight(0.008) * context.dynamicWidth(0.014),
              ),
            ),
          ),
          SizedBox(
            width: context.dynamicWidth(0.05),
          ),
          GradientWidget(
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
              center: Alignment(0.0, 0.3),
              tileMode: TileMode.clamp,
            ),
            widget: Text(
              "10",
              style: TextStyle(
                fontSize:
                    context.dynamicHeight(0.009) * context.dynamicWidth(0.016),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
