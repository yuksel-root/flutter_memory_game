import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/alert_dialog.dart';
import 'package:flutter_memory_game/components/score_board.dart';
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
    _game.score = 0;
    _game.tries = 0;
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
                  centerGameTitle(),
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

  Expanded expandedCard(int tries, int score) {
    return Expanded(
      flex: 100,
      child: GridView.builder(
        itemCount: _game.gameImg!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: context.dynamicWidth(0.025), //10px
          mainAxisSpacing: context.dynamicHeight(0.0142), //10 px
          childAspectRatio: 3 / 2,
        ),
        // context.dynamicHeight(0.004) * context.dynamicWidth(0.0075)
        padding: EdgeInsets.all(//3 * 3 px
            context.dynamicHeight(0.004) * context.dynamicWidth(0.0075)),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  _game.tries++;

                  _game.gameImg![index] = _game.cardList[index];
                  _game.matchCheck.add({index: _game.cardList[index]});
                });
                if (_game.matchCheck.length == 2) {
                  //print(_game.matchCheck);
                  //print(_game.matchCheck[0].values.first);
                  // print(_game.matchCheck[1].values.first);
                  // print("index: " + index.toString());

                  if (_game.matchCheck[0].values.first ==
                      _game.matchCheck[1].values.first) {
                    _game.score += 100;
                    _game.matchCheck.clear();
                  } else {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      //print(_game.gameImg);
                      setState(() {
                        _game.gameImg![_game.matchCheck[0].keys.first] =
                            _game.hiddenCardpath;
                        _game.gameImg![_game.matchCheck[1].keys.first] =
                            _game.hiddenCardpath;
                        _game.matchCheck.clear();
                      });
                    });
                  }
                }

                if (!_game.gameImg!.contains(_game.hiddenCardpath)) {
                  AlertView alert = AlertView(
                    content: "WINNER!",
                    title: "You won congrate!",
                    continueFunction: () {
                      setState(() {
                        _game.initGame();
                      });
                      Navigator.of(context).pop();
                    },
                  );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB46A),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(_game.gameImg![index]),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScoreBoard(title: "Tries", info: "$tries"),
        ScoreBoard(title: "Score", info: "$score"),
      ],
    );
  }
}
