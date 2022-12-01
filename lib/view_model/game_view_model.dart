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
  late bool _isBack;

  late List<Color> _cardBorderColors = [];
  late List<double> _cardBorderWidth = [];
  late List<String> _bgImages = [];

  late int _tries;
  late int _score;
  late int _peekCardsClickCount;
  late int _currentStage;

  late int _randomCardCount;
  late int _totalImageCount;
  late int _minCardCount;
  late int _maxCardCount;

  late List<String>? gameCard;
  late List<Map<int, String>>? _matchCheck;
  late List<String>? _randomImgList;
  late List<String>? _cardList;
  late List<String>? _imageList;
  late List<double>? _angleArr;

  GameViewModel() {
    _navigation = NavigationService.instance;
    _state = GameState.empty;

    _isFinished = false;
    _isMatchedCard = false;
    _isBack = true;

    _tries = 0;
    _score = 0;
    _peekCardsClickCount = 0;
    _currentStage = 0;

    _randomCardCount = 0;
    _totalImageCount = 83;
    _minCardCount = 4;
    _maxCardCount = 4;

    gameCard = [];
    _matchCheck = [];
    _randomImgList = [];
    _cardList = [];
    _imageList = [];
    _angleArr = [];
    _cardBorderColors = [];
    _cardBorderWidth = [];
    _bgImages = [];
  }

  Future<void> loadImageList() async {
    try {
      _imageList!.shuffle();
      _imageList =
          List.generate(_totalImageCount, (i) => "assets/card_images/$i.png");
      _imageList!.shuffle();
    } catch (e) {
      print("add image error");
      print(e);
    }
  }

  Future<void> loadGameCardList() async {
    gameCard!.shuffle();
    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    gameCard!.shuffle();
  }

  Future<void> generateDefaultLists() async {
    setAngleGameCardList();
    setCardBorderColor();
    setCardBorderWidth();
  }

  Future<void> setAngleGameCardList() async {
    _angleArr = List.generate(_cardList!.length, (index) => 0);
  }

  Future<void> setCardBorderColor() async {
    _cardBorderColors =
        List.generate(_cardList!.length, (index) => const Color(0xFFB2FEFA));
  }

  void setCardBorderWidth() {
    _cardBorderWidth = List.generate(_cardList!.length, (index) => 0);
  }

  void setBgImages() {
    _bgImages = List.generate(1, (index) => GameImgConstants.bg1Png);
  }

  String getBgImages(int index) {
    return _bgImages[index];
  }

  Color getCardBorderColors(int index) => _cardBorderColors[index];
  double getCardBorderWidth(int index) => _cardBorderWidth[index];
  Future<void> initGame() async {
    loadImageList();

    generateRandomImgList();

    loadGameCardList();

    generateDefaultLists();
  }

  Future<void> generateRandomImgList() async {
    var rng = Random();
    _imageList!.shuffle();
    _randomCardCount = rng.nextInt(_maxCardCount) + _minCardCount;

    for (int i = 0; i < _randomCardCount; i++) {
      _randomImgList!.add(_imageList![rng.nextInt(_imageList!.length)]);

      if (i == 0) {
        _cardList!.add(_randomImgList![i]);
        _imageList!.remove(_randomImgList![i]);
      }

      if (i > 0) {
        if (_randomImgList![i - 1] != _randomImgList![i]) {
          _cardList!.add(_randomImgList![i]);
          _imageList!.remove(_randomImgList![i]);
        }
      }
    }
    _cardList!.shuffle();
    _randomImgList!.shuffle();
    for (int i = 0; i < _randomCardCount; i++) {
      _cardList!.add(_randomImgList![i]);
    }
    _cardList!.shuffle();
  }

  Future<void> gameIsFinish() async {
    if (!gameCard!.contains(GameImgConstants.hiddenCardPng)) {
      setIsFinish = true;
    } else {
      setIsFinish = false;
    }
    notifyListeners();
  }

  Future<void> flipGameCard(double direction, int index) async {
    setAngleArr((direction * pi), index);

    notifyListeners();
  }

  void clickCard(int index, BuildContext context) {
    /*  print({
                "match": readGameViewCtx.isMatchedCard,
                "matchL": readGameViewCtx.matchCheck!.length,
                "gameC": readGameViewCtx.gameCard
              }); */
    if (gameCard![index] == GameImgConstants.hiddenCardPng &&
        _matchCheck!.length < 2) {
      openGameCard(index);
      setTries();

      if (_matchCheck!.length == 2) {
        isMatchCard();
        if (isMatchedCard) {
          setScore = 100;

          _matchCheck!.clear();
        } else {
          closeGameCard();
        }
      }
    } else {
      return;
    }

    gameIsFinish();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (getFinish) {
        nextStageAlert(context, getStage);
      } else {
        return;
      }
    });
  }

  double getAngleArr(int index) => _angleArr![index];

  void setAngleArr(double angle, int index) {
    _angleArr![index] = (angle);
    notifyListeners();
  }

  Future<void> openGameCard(int index) async {
    flipGameCard(1, index);
    gameCard![index] = _cardList![index];

    _matchCheck!.add({index: _cardList![index]});

    notifyListeners();
  }

  void borderAnimete(int index0, int index1, int count) {
    //print({"index0": index0, "\nindex1": index1});
    if (count > 4) return;
    _cardBorderColors[index0] = const Color.fromARGB(255, 255, 17, 0);
    _cardBorderColors[index1] = const Color.fromARGB(255, 248, 17, 0);
    Future.delayed(const Duration(milliseconds: 100), () {
      _cardBorderColors[index0] = const Color(0xFFB2FEFA);
      _cardBorderColors[index1] = const Color(0xFFB2FEFA);
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 100), () {
        borderAnimete(index0, index1, count + 1);
      });
    });
    notifyListeners();
  }

  Future<void> closeGameCard() async {
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;

    Future.delayed(const Duration(milliseconds: 1350), () {
      borderAnimete(index0, index1, 0);
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      flipGameCard(0, index0);
      flipGameCard(0, index1);

      gameCard![index0] = GameImgConstants.hiddenCardPng;
      gameCard![index1] = GameImgConstants.hiddenCardPng;
    });

    _matchCheck!.clear();
    notifyListeners();
  }

  Future<void> openAllGameCard() async {
    gameCard!.clear();

    gameCard = List.generate(
        _cardList!.length, (index) => _cardList!.elementAt(index));

    notifyListeners();
  }

  Future<void> closeAllGameCard() async {
    gameCard!.clear;

    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    notifyListeners();
  }

  Future<void> isMatchCard() async {
    if (_matchCheck![0].values.first == _matchCheck![1].values.first) {
      isMatchedCard = true;
    } else {
      isMatchedCard = false;
    }
    notifyListeners();
  }

  Future<void> restartGame() async {
    try {
      gameCard!.clear();
      _randomImgList!.clear();
      _matchCheck!.clear();
      _cardList!.clear();
    } catch (e) {
      print("array clear error");
      print(e);
    }

    setScoreClear();
    setTriesClear();
    _currentStage = 0;
    _peekCardsClickCountClear();
    notifyListeners();
  }

  void nextStage() {
    gameCard!.clear();
    _randomImgList!.clear();
    _matchCheck!.clear();
    _cardList!.clear();

    _currentStage++;

    setTriesClear();
    _peekCardsClickCountClear();
    notifyListeners();
  }

  Future<void> nextStageAlert(BuildContext context, int currentStage) async {
    GameAlertView alert = GameAlertView(
      score: _score,
      tries: _tries,
      content: "You are inceridble..",
      title: "STAGE  $currentStage",
      continueButtonText: "NEXT",
      continueFunction: () {
        _navigation
            .navigateToPageClear(path: NavigationConstants.homeView, data: []);
        nextStage();
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

  Future<void> navigateToPageClear(String path) async {
    _navigation
        .navigateToPageClear(path: NavigationConstants.homeView, data: []);
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
  void setTries() {
    _tries += 1;
    notifyListeners();
  }

  int get getPeekCardCount => _peekCardsClickCount;
  set setPeekCardCount(int i) {
    _peekCardsClickCount += i;
    notifyListeners();
  }

  void _peekCardsClickCountClear() {
    _peekCardsClickCount = 0;
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

  bool get getIsBackedCard => _isBack;
  set setIsBackedCard(bool isBack) {
    _isBack != isBack;
  }

  int get getStage => _currentStage;
}
