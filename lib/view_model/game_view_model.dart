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

  late List<Color> _cardBorderColors = [];
  late List<double> _cardBorderWidth = [];
  late List<String>? _bgImagesList = [];

  late int _tries;
  late int _score;
  late int _peekCardsClickCount;
  late int _currentStage;
  late int _matchCount;
  late int _randomCardCount;
  late int _totalImageCount;
  late int _minCardCount;
  late int _maxCardCount;

  late int _totalBgImageCount;

  late List<String>? gameCard;
  late List<String>? gameBgImageList;
  late List<Map<int, String>>? _matchCheck;
  late List<String>? _randomImgList;

  late List<String>? _cardList;
  late List<String>? _realBgList;
  late List<String>? _imageList;
  late List<double>? _angleArr;

  GameViewModel() {
    _navigation = NavigationService.instance;
    _state = GameState.empty;

    _isFinished = false;
    _isMatchedCard = false;

    _tries = 0;
    _score = 0;
    _peekCardsClickCount = 0;
    _currentStage = 0;

    _randomCardCount = 0;
    _totalImageCount = 83;
    _minCardCount = 2;
    _maxCardCount = 1;
    _matchCount = 0;
    _totalBgImageCount = 6;

    gameCard = [];
    gameBgImageList = [];
    _matchCheck = [];
    _randomImgList = [];

    _cardList = [];
    _realBgList = [];
    _imageList = [];
    _angleArr = [];
    _cardBorderColors = [];
    _cardBorderWidth = [];
    _bgImagesList = [];
  }
//flutter pub run flutter_native_splash:create
  Future<void> loadImageList() async {
    try {
      _imageList!.clear();
      _imageList =
          List.generate(_totalImageCount, (i) => "assets/card_images/$i.png");
      _imageList!.shuffle();
    } catch (e) {
      print({"add card_images error": e});
    }
  }

  Future<void> loadBgImageList() async {
    try {
      _bgImagesList!.clear();
      _bgImagesList =
          List.generate(_totalBgImageCount, (i) => "assets/bg_images/bg$i.jpg");
      _bgImagesList!.shuffle();
    } catch (e) {
      print({"add _bgImages error": e});
    }
  }

  set setchangeBg(int random) {
    try {
      state = GameState.loading;
      gameBgImageList = List.generate(
          _bgImagesList!.length, (index) => gameBgImageList![random]);

      state = GameState.completed;
    } catch (e) {
      print({"setChange err": e});
    }
    notifyListeners();
  }

  String get getBgImages {
    return gameBgImageList![0];
  }

  Future<void> loadGameCardList() async {
    gameCard!.shuffle();
    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    gameCard!.shuffle();
  }

  Future<void> setGameBgImageList(int random) async {
    loadBgImageList();
    try {
      gameBgImageList!.shuffle();
      state = GameState.loading;

      gameBgImageList = List.generate(
          _bgImagesList!.length, (index) => _bgImagesList![random]);
      gameBgImageList!.shuffle();
      state = GameState.completed;
    } catch (e) {
      print(e);
    }
  }

  Future<void> generateDefaultLists() async {
    setAngleGameCardList();
    setCardBorderColor();
    setCardBorderWidth();
  }

  Future<void> initGame() async {
    generateRandomImgList();

    loadGameCardList();
    setGameBgImageList(Random().nextInt(5));

    generateDefaultLists();
  }

  Future<void> generateRandomImgList() async {
    loadImageList();
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
    if ((_cardList!.length / 2) == _matchCount) {
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

  Future<void> clickCard(int index, BuildContext context) async {
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
          setMatchCount = 1;

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

  Future<void> openGameCard(int index) async {
    flipGameCard(1, index);
    gameCard![index] = _cardList![index];

    _matchCheck!.add({index: _cardList![index]});

    notifyListeners();
  }

  void borderAnimate(int index0, int index1, int count, Color color) {
    if (count > 4) return;

    _cardBorderColors[index0] = color;
    _cardBorderColors[index1] = color;
    Future.delayed(const Duration(milliseconds: 100), () {
      _cardBorderColors[index0] = const Color(0xFFB2FEFA);
      _cardBorderColors[index1] = const Color(0xFFB2FEFA);
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 100), () {
        borderAnimate(index0, index1, count + 1, color);
      });
    });
    notifyListeners();
  }

  Future<void> closeGameCard() async {
    Color color = const Color.fromARGB(255, 255, 17, 0);
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;

    Future.delayed(const Duration(milliseconds: 1350), () {
      borderAnimate(index0, index1, 0, color);
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
    setScoreClear();
    setTriesClear();

    gameCard = List.generate(
        _cardList!.length, (index) => _cardList!.elementAt(index));

    Future.delayed(const Duration(milliseconds: 1500), () {
      closeAllGameCard();
      _matchCheck!.clear();
    });
    notifyListeners();
  }

  Future<void> closeAllGameCard() async {
    gameCard!.clear;

    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    notifyListeners();
  }

  Future<void> isMatchCard() async {
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;
    Color color = Color.fromARGB(255, 0, 255, 42);
    if (_matchCheck![0].values.first == _matchCheck![1].values.first) {
      isMatchedCard = true;
      Future.delayed(const Duration(milliseconds: 1350), () {
        borderAnimate(index0, index1, 0, color);
      });
    } else {
      isMatchedCard = false;
    }
    notifyListeners();
  }

  Future<void> restartGame() async {
    try {
      gameCard!.clear();
      gameBgImageList!.clear();
      _randomImgList!.clear();

      _matchCheck!.clear();
      _cardList!.clear();
      setchangeBg = Random().nextInt(5);
      _matchCount = 0;
    } catch (e) {
      print({"array clear error": e});
    }

    _matchCount = 0;
    setScoreClear();
    setTriesClear();
    _currentStage = 0;
    _peekCardsClickCountClear();
    notifyListeners();
  }

  void nextStage() {
    gameCard!.clear();
    gameBgImageList!.clear();
    _randomImgList!.clear();

    _realBgList!.clear();
    _matchCheck!.clear();
    _cardList!.clear();

    _matchCount = 0;
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

  int get getMatchCount => _matchCount;

  set setMatchCount(int count) {
    _matchCount += count;
    notifyListeners();
  }

  int get getStage => _currentStage;

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

  double getAngleArr(int index) => _angleArr![index];

  void setAngleArr(double angle, int index) {
    _angleArr![index] = (angle);
    notifyListeners();
  }

  Color getCardBorderColors(int index) => _cardBorderColors[index];
  double getCardBorderWidth(int index) => _cardBorderWidth[index];
}
