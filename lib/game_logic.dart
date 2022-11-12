import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/alert_dialog.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

class Game {
  final NavigationService navigation = NavigationService.instance;
  bool isFinished = false;
  bool isMatchedCard = false;
  int tries = 0;
  int score = 0;
  int cardCount = 0;
  int randomCardCount = 0;

  final int totalImageCount = 83;
  final int minCardCount = 4;
  final int maxCardCount = 6;

  List<String>? gameCard = [];
  final List<Map<int, String>>? matchCheck = [];
  final List<String>? randomImgList = [];
  final List<String>? cardList = [];
  final List<String>? imageList = [];

  List myShuffle(List items) {
    //still progress...
    var random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  Future<void> generaterRandomImage() async {
    var rng = Random();
    try {
      for (int i = 0; i <= totalImageCount; i++) {
        imageList!.add("assets/images/" + i.toString() + ".png");
      }
    } catch (e) {
      print("add image error");
      print(e);
    }

    randomCardCount = rng.nextInt(minCardCount) + maxCardCount;

    for (int i = 0; i < randomCardCount; i++) {
      randomImgList!.add(imageList![rng.nextInt(imageList!.length)]);
      if (i == 0) {
        cardList!.add(randomImgList![i]);
        imageList!.remove(randomImgList![i]);
      }
      if (i > 0) {
        if (randomImgList![i - 1] != randomImgList![i]) {
          cardList!.add(randomImgList![i]);
          imageList!.remove(randomImgList![i]);
        }
      }
    }

    for (int i = 0; i < randomCardCount; i++) {
      cardList!.add(randomImgList![i]);
    }
  }

  Future<void> isMatchCard(List? matchCheck) async {
    if (matchCheck![0].values.first == matchCheck[1].values.first) {
      isMatchedCard = true;
    } else {
      isMatchedCard = false;
    }
  }

  Future<void> navigateToPage(String path) async {
    navigation.navigateToPage(path: NavigationConstants.HOME_VIEW, data: []);
  }

  Future<void> isFinish(List gameCard) async {
    if (!gameCard.contains(GameImgConstants.hiddenCardPng)) {
      isFinished = true;
    } else {
      isFinished = false;
    }
  }

  Future<void> closeCard(List? gameCard, List? matchCheck) async {
    gameCard![matchCheck![0].keys.first] = GameImgConstants.hiddenCardPng;
    gameCard[matchCheck[1].keys.first] = GameImgConstants.hiddenCardPng;
    matchCheck.clear();
  }

  Future<void> winnerAlert(List gameCard, BuildContext context) async {
    AlertView alert = AlertView(
      content: "You won congrats!",
      title: "WINNER",
      continueFunction: () {
        navigation
            .navigateToPage(path: NavigationConstants.HOME_VIEW, data: []);
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

  void initGame() {
    try {
      gameCard!.clear();
      randomImgList!.clear();
      matchCheck!.clear();
      cardList!.clear();
    } catch (e) {
      print("array clear error");
      print(e);
    }

    tries = 0;
    score = 0;
    isFinished = false;
    isMatchedCard = false;
    generaterRandomImage();

    cardCount = cardList!.length;

    gameCard =
        List.generate(cardCount, (index) => GameImgConstants.hiddenCardPng);
  }
}
