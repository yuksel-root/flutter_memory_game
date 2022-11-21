import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/alert_dialog.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

enum GameState {
  empty,
  loading,
  completed,
  error,
}

class GameViewModel extends ChangeNotifier {
  late NavigationService _navigation;
  late GameState? _state;

  late bool _isFinished;
  late bool _isMatchedCard;

  late int _tries;
  late int _score;

  late int _randomCardCount;
  late int _totalImageCount;
  late int _minCardCount;
  late int _maxCardCount;

  late List<String>? gameCard;
  late List<Map<int, String>>? matchCheck;
  late List<String>? randomImgList;
  late List<String>? cardList;
  late List<String>? imageList;

  GameViewModel() {
    _navigation = NavigationService.instance;
    _state = GameState.empty;

    _isFinished = false;
    _isMatchedCard = false;

    _tries = 0;
    _score = 0;
    _randomCardCount = 0;
    _totalImageCount = 83;
    _minCardCount = 4;
    _maxCardCount = 4;

    gameCard = [];
    matchCheck = [];
    randomImgList = [];
    cardList = [];
    imageList = [];
  }

  Future<void> loadImageList() async {
    try {
      imageList =
          List.generate(_totalImageCount, (i) => "assets/card_images/$i.png");
    } catch (e) {
      print("add image error");
      print(e);
    }
  }

  Future<void> loadGameCardList() async {
    gameCard = List.generate(
        cardList!.length, (index) => GameImgConstants.hiddenCardPng);
  }

  Future<void> initGame() async {
    loadImageList();

    generateRandomImgList();

    loadGameCardList();
  }

  Future<void> generateRandomImgList() async {
    var rng = Random();

    _randomCardCount = rng.nextInt(_maxCardCount) + _minCardCount;

    for (int i = 0; i < _randomCardCount; i++) {
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

    for (int i = 0; i < _randomCardCount; i++) {
      cardList!.add(randomImgList![i]);
    }
  }

  Future<void> gameIsFinish() async {
    if (!gameCard!.contains(GameImgConstants.hiddenCardPng)) {
      setIsFinish = true;
    } else {
      setIsFinish = false;
    }
    notifyListeners();
  }

  Future<void> openGameCard(int index) async {
    gameCard![index] = cardList![index];

    matchCheck!.add({index: cardList![index]});

    notifyListeners();
  }

  Future<void> isMatchCard() async {
    if (matchCheck![0].values.first == matchCheck![1].values.first) {
      isMatchedCard = true;
    } else {
      isMatchedCard = false;
    }
    notifyListeners();
  }

  Future<void> closeGameCard() async {
    gameCard![matchCheck![0].keys.first] = GameImgConstants.hiddenCardPng;
    gameCard![matchCheck![1].keys.first] = GameImgConstants.hiddenCardPng;
    matchCheck!.clear();
    notifyListeners();
  }

  Future<void> restartGame() async {
    try {
      gameCard!.clear();
      randomImgList!.clear();
      matchCheck!.clear();
      cardList!.clear();
    } catch (e) {
      print("array clear error");
      print(e);
    }

    setScoreClear();
    setTriesClear();

    notifyListeners();
  }

  Future<void> winnerAlert(BuildContext context) async {
    AlertView alert = AlertView(
      content: "You won congrats!",
      title: "YOU WINNER",
      continueFunction: () {
        _navigation
            .navigateToPage(path: NavigationConstants.homeView, data: []);
        restartGame();
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

  Future<void> navigateToPage(String path) async {
    _navigation.navigateToPage(path: NavigationConstants.homeView, data: []);
  }

  GameState get state => _state!;
  set state(GameState state) {
    _state = state;
  }

  bool get getFinish => _isFinished;
  set setIsFinish(bool finish) {
    _isFinished = finish;
    notifyListeners();
  }

  int get getScore => _score;
  set setScore(int score) {
    _score += score;
    notifyListeners();
  }

  int get getTries => _tries;
  set setTries(int tries) {
    _tries += tries;
    notifyListeners();
  }

  void setTriesClear() {
    _tries = 0;
    notifyListeners();
  }

  void setScoreClear() {
    _score = 0;
    notifyListeners();
  }

  bool get isMatchedCard => _isMatchedCard;
  set isMatchedCard(bool isMatch) {
    _isMatchedCard = isMatch;
    notifyListeners();
  }
}
