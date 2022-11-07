import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/score_board.dart';
import 'package:flutter_memory_game/core/extensions/context_extensions.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  centerGameTitle(),
                  const Spacer(flex: 1),
                  rowScoreBoard(),
                  const Spacer(flex: 1),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Center centerGameTitle() {
    return const Center(
      child: Text(
        "Memory Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row rowScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScoreBoard(title: "Tries", info: "0"),
        ScoreBoard(title: "Score", info: "0"),
      ],
    );
  }
}
