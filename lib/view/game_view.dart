import 'package:flutter/material.dart';
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
        appBar: AppBar(
          flexibleSpace: Container(
            height: context.mediaQuery.size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1D976C),
                  Color(0xFF93F9B9),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.repeated,
              ),
            ),
            child: SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  FittedBox(fit: BoxFit.cover, child: centerGameTitle()),
                  const Spacer(flex: 1),
                  FittedBox(
                      fit: BoxFit.cover,
                      child: elevatedBtnReplay(readGameView, context)),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2193b0),
                    Color(0xFF6dd5ed),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated,
                ),
              ),
              height: context.mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  rowScoreBoard(readGameView.getTries, readGameView.getScore),
                  const Spacer(flex: 1),
                  expandedCard(readGameView.getTries, readGameView.getScore,
                      readGameView, gameViewProv),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }

  DecoratedBox elevatedBtnReplay(
      GameViewModel readGameView, BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB2FEFA),
            Color(0xFF6dd5ed),
            Color(0xFFB2FEFA),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.9, 1.0],
          tileMode: TileMode.repeated,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
              blurRadius: 5) //blur radius of shadow
        ],
        borderRadius: BorderRadius.circular(
            context.dynamicHeight(0.008) * context.dynamicWidth(0.012)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(context.dynamicWidth(0.01) *
                context.dynamicHeight(0.007))), //5*5 25px , 500w 700h
        onPressed: () {
          readGameView.navigateToPage(NavigationConstants.homeView);
          readGameView.restartGame();
        },
        child: Text(
          "Replay",
          style: TextStyle(
            fontSize: context.dynamicHeight(0.008) *
                context.dynamicWidth(0.012), //6*6 36px
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Expanded expandedCard(
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
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                padding: EdgeInsets.all(context.dynamicHeight(0.004) *
                    context.dynamicWidth(0.006)), //3*3 9px
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFB2FEFA),
                      Color(0xFF6dd5ed),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.repeated,
                  ),
                  borderRadius: BorderRadius.circular(
                      context.dynamicHeight(0.002) *
                          context.dynamicWidth(0.004)), //2*2
                  image: DecorationImage(
                    onError: (Object exception, StackTrace? stackTrace) {
                      print('Exception: $exception');
                      print('Stack Trace:\n$stackTrace');
                    },
                    repeat: ImageRepeat.noRepeat,

                    scale: context.dynamicHeight(0.005) *
                        context.dynamicWidth(0.008), //4*4
                    opacity: 0.9,
                    alignment: Alignment.center,
                    image: AssetImage(readGameViewCtx.gameCard![index]),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Center centerGameTitle() {
    return Center(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          "Memory Game",
          style: TextStyle(
            color: Colors.white,
            fontSize: context.dynamicHeight(0.01) *
                context.dynamicWidth(0.014), //7*7 49px
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Row rowScoreBoard(int tries, int score) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScoreBoard(title: "Tries", info: "$tries"),
        ScoreBoard(title: "Score", info: "$score"),
      ],
    );
  }
}
