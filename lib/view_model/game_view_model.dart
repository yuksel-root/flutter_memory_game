import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/components/alert_dialog.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';

//-- GameState Variables -- //
enum GameState {
  empty,
  loading,
  completed,
  error,
}

class GameViewModel extends ChangeNotifier {
  late NavigationService _navigation;
  late GameState? _state;

// -- Game Logic Variables - //
  late bool _isFinished;
  late bool _isMatchedCard;
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

//-- Animation Variables -- //
  late List<Color> _cardBorderColors;
  late List<double> _cardBorderWidth;
  late List<double>? _animationAngleArr;

//-- Game Logic List -- //
  late List<Map<int, String>>? _matchCheck;
  late List<String>? _imageList;
  late List<String>? _cardList;
  late List<String>? _randomImgList;
  late List<String>? gameCard;

  late List<String>? _bgImagesList;
  late List<String>? _bgList;
  late List<String>? _randomBgList;
  late List<String>? gameBgImageList;

  GameViewModel() {
    _navigation = NavigationService.instance;
    _state = GameState.empty;

    _isFinished = false;
    _isMatchedCard = false;
    _randomCardCount = 0;
    _matchCount = 0;
    _tries = 0;
    _score = 0;
    _peekCardsClickCount = 0;
    _currentStage = 0;

    _totalImageCount = 83;
    _minCardCount = 2;
    _maxCardCount = 1;
    _totalBgImageCount = 10;

    _animationAngleArr = [];
    _cardBorderColors = [];
    _cardBorderWidth = [];

    _imageList = [];
    _cardList = [];
    _randomImgList = [];
    gameCard = [];

    _matchCheck = [];

    _bgImagesList = [];
    _bgList = [];
    _randomBgList = [];
    gameBgImageList = [];
  }

  void loadImageList() {
    try {
      _imageList!.clear();
      _imageList =
          List.generate(_totalImageCount, (i) => "assets/card_images/$i.png");
      _imageList!.shuffle();
    } catch (e) {
      print({"add card_images error": e});
    }
  }

  void loadBgImageList() {
    try {
      _bgImagesList!.clear();
      _bgImagesList =
          List.generate(_totalBgImageCount, (i) => "assets/bg_images/bg$i.jpg");
      _bgImagesList!.shuffle();
    } catch (e) {
      print({"add _bgImages error": e});
    }
  }

  void loadGameCardList() {
    gameCard!.shuffle();
    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    gameCard!.shuffle();
  }

  void generateDefaultLists() {
    setAngleGameCardList();
    setCardBorderColor();

    generateRandomBgList();
    setCardBorderWidth = 0;
  }

  void initGame() {
    generateRandomImgList();

    loadGameCardList();

    generateDefaultLists();
  }

  void generateRandomImgList() {
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

  void generateRandomBgList() {
    loadBgImageList();
    _randomBgList!.clear();
    _bgList!.clear();
    var rng = Random();
    _bgImagesList!.shuffle();

    for (int i = 0; i < _totalBgImageCount; i++) {
      _randomBgList!.add(_bgImagesList![rng.nextInt(_bgImagesList!.length)]);

      if (i == 0) {
        _bgList!.add(_randomBgList![i]);
        _imageList!.remove(_randomBgList![i]);
      }

      if (i > 0) {
        if (_randomBgList![i - 1] != _randomBgList![i]) {
          _bgList!.add(_randomBgList![i]);
          _bgImagesList!.remove(_randomBgList![i]);
        }
      }
    }
    _bgList!.shuffle();
    _randomBgList!.shuffle();
    for (int i = 0; i < _totalBgImageCount; i++) {
      _bgList!.add(_randomBgList![i]);
    }
    _bgList!.shuffle();
  }

  void gameIsFinish() {
    if ((_cardList!.length / 2) == _matchCount) {
      setIsFinish = true;
    } else {
      setIsFinish = false;
    }
    notifyListeners();
  }

  void flipGameCard(double direction, int index) {
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
      notifyListeners();
      if (_matchCheck!.length == 2) {
        isMatchCard();
        if (isMatchedCard) {
          setScore = 100;
          setMatchCount = 1;

          _matchCheck!.clear();
          notifyListeners();
        } else {
          closeGameCard();
          notifyListeners();
        }
      }
    } else {
      return;
    }

    gameIsFinish();

    if (getFinish) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        nextStageAlert(context, getStage);
      });
      notifyListeners();
    } else {
      return;
    }
    notifyListeners();
  }

  void openGameCard(int index) {
    flipGameCard(1, index);
    gameCard![index] = _cardList![index];

    _matchCheck!.add({index: _cardList![index]});
    notifyListeners();
  }

  void borderAnimate(int i0, int i1, int count, Color color, double borderW) {
    if (count > 4) return;

    _cardBorderColors[i0] = color;
    _cardBorderColors[i1] = color;
    notifyListeners();
    _cardBorderWidth[i0] = borderW > 0.1 && borderW < 0.5
        ? borderW += Random().nextDouble() * 0.256
        : borderW > 0.5 && borderW > 0.2
            ? borderW -= Random().nextDouble() * 0.123
            : borderW += Random().nextDouble() * 0.195;
    notifyListeners();
    _cardBorderWidth[i1] = borderW > 0.1 && borderW < 0.5
        ? borderW += Random().nextDouble() * 0.261
        : borderW > 0.5 && borderW > 0.2
            ? borderW -= borderW += Random().nextDouble() * 0.112
            : borderW += Random().nextDouble() * 0.316;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 112), () {
      _cardBorderColors[i0] = const Color(0xFFB2FEFA);
      _cardBorderColors[i1] = const Color(0xFFB2FEFA);
      _cardBorderWidth[i0] = 0;
      _cardBorderWidth[i1] = 0;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 112), () {
        borderAnimate(i0, i1, count + 1, color, Random().nextDouble() * 0.114);
      });
    });
    notifyListeners();
  }

  void closeGameCard() {
    Color color = const Color.fromARGB(255, 255, 17, 0);
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;

    Future.delayed(const Duration(milliseconds: 500), () {
      borderAnimate(index0, index1, 0, color, Random().nextDouble() * 0.234);
    });
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1500), () {
      flipGameCard(0, index0);
      flipGameCard(0, index1);
      notifyListeners();
      gameCard![index0] = GameImgConstants.hiddenCardPng;
      gameCard![index1] = GameImgConstants.hiddenCardPng;
      notifyListeners();
    });

    _matchCheck!.clear();
    notifyListeners();
  }

  void openAllGameCard() {
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

  void closeAllGameCard() {
    gameCard!.clear;

    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    notifyListeners();
  }

  void isMatchCard() {
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;
    Color color = const Color.fromARGB(255, 0, 255, 42);
    if (_matchCheck![0].values.first == _matchCheck![1].values.first) {
      isMatchedCard = true;
      Future.delayed(const Duration(milliseconds: 1350), () {
        borderAnimate(index0, index1, 0, color, Random().nextDouble() * 0.222);
      });
    } else {
      isMatchedCard = false;
    }
    notifyListeners();
  }

  void restartGame() {
    try {
      gameCard!.clear();
      gameBgImageList!.clear();
      _randomImgList!.clear();
      _matchCheck!.clear();
      _cardList!.clear();

      _matchCount = 0;
      _currentStage = 0;

      setScoreClear();
      setTriesClear();
      _peekCardsClickCountClear();
    } catch (e) {
      print({"res game error": e});
    }
    notifyListeners();
  }

  void nextStage() {
    gameCard!.clear();
    gameBgImageList!.clear();
    _randomImgList!.clear();
    _matchCheck!.clear();
    _cardList!.clear();

    _matchCount = 0;
    _currentStage++;

    setTriesClear();
    _peekCardsClickCountClear();
    notifyListeners();
  }

  void nextStageAlert(BuildContext context, int currentStage) {
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
        notifyListeners();
      },
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    notifyListeners();
  }

  void navigateToPageClear(String path) {
    _navigation
        .navigateToPageClear(path: NavigationConstants.homeView, data: []);
    notifyListeners();
  }

  void setTries() {
    _tries += 1;
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

  void setAngleGameCardList() {
    _animationAngleArr = List.generate(_cardList!.length, (index) => 0);
  }

  void setCardBorderColor() {
    _cardBorderColors =
        List.generate(_cardList!.length, (index) => const Color(0xFFB2FEFA));
  }

  void setAngleArr(double angle, int index) {
    _animationAngleArr![index] = (angle);
    notifyListeners();
  }

  set setPeekCardCount(int i) {
    _peekCardsClickCount += i;
    notifyListeners();
  }

  set state(GameState state) {
    _state = state;
  }

  set setIsFinish(bool finish) {
    _isFinished = finish;
    notifyListeners();
  }

  set setScore(int score) {
    _score += score;
    notifyListeners();
  }

  set setCardBorderWidth(double border) {
    _cardBorderWidth = List.generate(_cardList!.length, (index) => border);
  }

  set setMatchCount(int count) {
    _matchCount += count;
    notifyListeners();
  }

  set isMatchedCard(bool isMatch) {
    _isMatchedCard = isMatch;
    notifyListeners();
  }

  String get getBgImages {
    print(_bgList);
    return _bgList![_currentStage];
  }

  GameState get state => _state!;
  bool get getFinish => _isFinished;
  int get getPeekCardCount => _peekCardsClickCount;
  int get getScore => _score;
  int get getTries => _tries;
  int get getMatchCount => _matchCount;
  bool get isMatchedCard => _isMatchedCard;
  int get getStage => _currentStage;
  double getAngleArr(int index) => _animationAngleArr![index];
  Color getCardBorderColors(int index) => _cardBorderColors[index];
  double getCardBorderWidth(int index) => _cardBorderWidth[index];
}
