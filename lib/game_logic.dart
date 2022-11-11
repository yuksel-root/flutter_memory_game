import 'dart:math';

import 'package:flutter_memory_game/core/constants/game_img_constants.dart';

class Game {
  int tries = 0;
  int score = 0;
  int cardCount = 0;

  List<String>? gameCard;
  List<Map<int, String>> matchCheck = [];
  final List<String> randomImgList = [];
  final List<String> cardList = [];

  void generaterRandomImage() {
    var rng = Random();

    for (int i = 0; i < 10; i++) {
      randomImgList.add(GameImgConstants
          .imageList[rng.nextInt(GameImgConstants.imageList.length)]);
      cardList.add(randomImgList[i]);
    }

    print("random");
    print(randomImgList);
    print("random");

    for (int i = 0; i < 10; i++) {
      cardList.add(randomImgList[i]);
    }

    print(cardList);
    print(cardList.length);
  }

  void initGame() {
    tries = 0;
    score = 0;
    generaterRandomImage();
    cardCount = cardList.length;
    cardList.shuffle();
    gameCard =
        List.generate(cardCount, (index) => GameImgConstants.hiddenCardPng);

    print("end");
    print(cardList);
    print(cardList.length);
    print("end");
  }
}
