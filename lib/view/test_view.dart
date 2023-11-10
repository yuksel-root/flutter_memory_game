import 'package:flutter/material.dart';
import 'package:flutter_memory_game/view/new_game_alert.dart';

class TestView extends StatelessWidget {
//flutter build apk --target-platform android-arm --analyze-size

//flutter build appbundle --target-platform android-arm

//flutter build apk --split-per-abi
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return NewGameAlertDialog(
                    content: "",
                    menuButtonFunction: () {},
                    retryButtonFunction: () {},
                    nextButtonFunction: () {},
                    title: "",
                    score: 0,
                    tries: 0,
                  );
                },
              );
            },
          ),
        ));
  }
}
