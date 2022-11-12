import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/score_board.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';
import 'package:flutter_memory_game/game_logic.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Game _game = Game();

  @override
  void initState() {
    _game.initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFe55870),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      centerGameTitle(),
                      const Spacer(flex: 1),
                      elevatedBtnReplay(),
                      const Spacer(flex: 1),
                    ],
                  ),
                  const Spacer(flex: 1),
                  rowScoreBoard(_game.tries, _game.score),
                  const Spacer(flex: 1),
                  expandedCard(_game.tries, _game.score),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ));
  }

  ElevatedButton elevatedBtnReplay() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            onPrimary: Colors.white,
            primary: const Color(0xFFFFB46A),
            shadowColor: Colors.deepPurpleAccent,
            padding: EdgeInsets.all(context.dynamicWidth(0.0375))),
        onPressed: () {
          _game.navigateToPage(NavigationConstants.HOME_VIEW);
        },
        child: const Text(
          "Replay",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Expanded expandedCard(int tries, int score) {
    return Expanded(
      flex: 100,
      child: GridView.builder(
        itemCount: _game.gameCard!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: context.dynamicWidth(0.025), //10px
          mainAxisSpacing: context.dynamicHeight(0.0142), //10 px
          childAspectRatio: 1 / 1,
        ),
        padding: EdgeInsets.all(//3 * 3 px
            context.dynamicHeight(0.004) * context.dynamicWidth(0.0075)),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                if (_game.gameCard![index] == GameImgConstants.hiddenCardPng) {
                  setState(() {
                    _game.tries++;

                    _game.gameCard![index] = _game.cardList![index];
                    _game.matchCheck!.add({index: _game.cardList![index]});
                  });

                  if (_game.matchCheck!.length == 2) {
                    if (_game.matchCheck![0].values.first ==
                        _game.matchCheck![1].values.first) {
                      _game.score += 100;
                      _game.matchCheck!.clear();
                    } else {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() {
                          _game.closeCard(_game.gameCard, _game.matchCheck);
                        });
                      });
                    }
                  }
                } else {
                  return;
                }

                setState(() {
                  _game.isFinish(_game.gameCard!);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (_game.isFinished) {
                      _game.winnerAlert(_game.gameCard!, context);
                    } else {
                      return;
                    }
                  });
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB46A),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    repeat: ImageRepeat.noRepeat,
                    scale: 2.0,
                    image: AssetImage(_game.gameCard![index]),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ));
        },
      ),
    );
  }

  Center centerGameTitle() {
    return const Center(
      child: Text(
        "Memory Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
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
