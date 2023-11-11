import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/view/new_game_alert.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/local_storage/local_storage_manager.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter_memory_game/core/notifier/timeState_provider.dart';
import 'package:flutter_memory_game/view/pause_button_menu_dialog.dart';
import 'package:provider/provider.dart';

//-- GameState Variables -- //
enum GameState {
  empty,
  loading,
  completed,
  error,
}

class GameViewModel extends ChangeNotifier {
  late NavigationService _navigation;
  late LocalStorageManager _storageManager;
  late GameState? _state;

// -- Game Logic Variables - //
  bool isFirstInit = true;
  late bool _isFinishedCard;
  late bool _isMatchedCard;

  late int _tries;
  late int _score;
  late int _highscore;
  late int _timeInfo;
  late int _peekCardsClickCount;
  late int _currentStage;
  late int _matchCount;
  late int _randomCardCount;

  late int _totalImageCount;
  late int _minCardCount;
  late int _maxCardCount;
  late int _totalBgImageCount;
  late int _bgCounter;

//-- Animation Variables -- //
  late List<Color> _cardBorderColors;
  late List<double> _cardBorderWidth;
  late List<double>? _animationAngleArr;

  double _pageOpacity = 0;

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
    _storageManager = LocalStorageManager.instance;

    _state = GameState.empty;

    _isFinishedCard = false;
    _isMatchedCard = false;

    _randomCardCount = 0;
    _matchCount = 0;
    _tries = 0;
    _score = 0;
    _highscore = 50;
    _timeInfo = 0;
    _peekCardsClickCount = 0;
    _currentStage = 0;

    _totalImageCount = 83;
    _minCardCount = 3;
    _maxCardCount = 6;
    _totalBgImageCount = 11;
    _bgCounter = 0;

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

  set setOpacity(double i) {
    _pageOpacity = i;
    notifyListeners();
  }

  get getOpacity => _pageOpacity;

  Future<void> saveBgList() async {
    //print(_getBgList);
    _storageManager.setStringList("bg", _getBgList);

    //print(await _storageManager.getStringList("bg"));
    //print(await _storageManager.getAllValues);
  }

  void loadImageList() {
    try {
      _imageList!.clear();
      _imageList =
          List.generate(_totalImageCount, (i) => "assets/game_card_png/$i.png");
      _imageList!.shuffle();
    } catch (e) {
      print({"add card_images error": e});
    }
  }

  void loadBgImageList() {
    try {
      _bgImagesList!.clear();
      _bgImagesList = List.generate(
          _totalBgImageCount, (i) => "assets/game_bg_jpeg/bg$i.jpeg");
    } catch (e) {
      print({"add _bgImages error": e});
    }
  }

  void loadBgList() {
    loadBgImageList();

    try {
      _bgList!.clear();
      _bgList = List.generate(
          _totalBgImageCount, (i) => "assets/game_bg_jpeg/bg$i.jpeg");
    } catch (e) {
      print({"add _bgsImages error": e});
    }
  }

  void loadGameCardList() {
    gameCard!.clear();
    gameCard!.shuffle();
    gameCard = List.generate(
        _cardList!.length, (index) => GameImgConstants.hiddenCardPng);
    gameCard!.shuffle();
  }

  void generateDefaultLists() {
    setAngleGameCardList();
    setCardBorderColor();

    setCardBorderWidth = 0;
  }

  void arrayClears() {
    gameCard!.clear();
    gameBgImageList!.clear();
    _randomImgList!.clear();
    _matchCheck!.clear();
    _cardList!.clear();
  }

  void initGame(BuildContext context) {
    setFirstInit();
    if (Provider.of<TimerProvider>(
          context,
          listen: false,
        ).getIsPaused ==
        true) {
    } else {
      arrayClears();

      generateRandomImgList();

      loadBgList();

      loadGameCardList();

      generateDefaultLists();
    }
  }

  void generateRandomImgList() {
    loadImageList();
    gameCard!.clear();
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
  }

  void allCardIsFinish() {
    if ((_cardList!.length / 2) == _matchCount) {
      setIsFinishCard = true;
    } else {
      setIsFinishCard = false;
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

    allCardIsFinish();

    if (getFinishCard) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        nextStageAlert(context);
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
    if (count > 3) return;

    _cardBorderColors[i0] = color;
    _cardBorderColors[i1] = color;
    notifyListeners();
    _cardBorderWidth[i0] = 0.400;
    notifyListeners();
    _cardBorderWidth[i1] = _cardBorderWidth[i0];
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
      notifyListeners();
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

  void restartGame(BuildContext context) {
    setFirstInit();
    try {
      arrayClears();

      if (_bgCounter < 10) {
        setBgCounter();
      } else {
        clearBgCounter();
      }
      setScoreClear();
      setTriesClear();
      _peekCardsClickCountClear();
    } catch (e) {
      print({"res game error": e});
    }

    Provider.of<TimerProvider>(
      context,
      listen: false,
    ).stopTimer(context, reset: true);

    Provider.of<TimerProvider>(
      context,
      listen: false,
    ).setIsActiveTimer = true;
    navigateToPageClear(NavigationConstants.gameView);

    setOpacity = 0;
    notifyListeners();
  }

  void nextStage() {
    arrayClears();

    _matchCount = 0;

    _currentStage++;
    if (_bgCounter < 10) {
      setBgCounter();
    } else {
      clearBgCounter();
    }

    _peekCardsClickCountClear();
    notifyListeners();
  }

  Future<void> nextStageAlert(BuildContext context) async {
    NewGameAlertDialog alert = NewGameAlertDialog(
      score: 0,
      tries: 0,
      content: "WELL DONE",
      title: "STAGE 5",
      menuButtonFunction: () {
        print("MENU BUTTON PRESSED");
      },
      retryButtonFunction: () {
        print("RETRY BUTTON PRESSED");
        restartGame(context);
      },
      nextButtonFunction: () {
        print("NEXT BUTTON PRESSED");
        restartGame(context);
      },
    );
    showDialog<void>(
      barrierDismissible: false,
      barrierColor: Color(0xFF00FFFFFF),
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    notifyListeners();
  }

  Future<void> pauseGameAlert(BuildContext context) async {
    PauseButtonMenuDialog alert = PauseButtonMenuDialog(
      continueBtnFunction: () {
        _navigation
            .navigateToPageClear(path: NavigationConstants.gameView, data: []);

        Provider.of<TimerProvider>(
          context,
          listen: false,
        ).setIsPaused = true;

        Provider.of<TimerProvider>(
          context,
          listen: false,
        ).setIsActiveTimer = true;
      },
      soundBtnFunction: () {},
      newGameButtonFunction: () {
        navigateToPageClear(NavigationConstants.gameView);
      },
      menuButtonFunction: () {
        navigateToPageClear(NavigationConstants.homeView);
      },
    );
    showDialog(
        barrierDismissible: false,
        barrierColor: Color(0xFF0000ffff),
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
    notifyListeners();
  }

  void navigateToPageClear(String path) {
    _navigation.navigateToPageClear(path: path, data: []);
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

  set setIsFinishCard(bool finishCard) {
    _isFinishedCard = finishCard;
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

  set setHighScore(int newHighScore) {
    _highscore = newHighScore;
  }

  int get getHighScore {
    return _highscore;
  }

  set setTimeInfo(int newTime) {
    _timeInfo = newTime;
  }

  int get getTimeInfo {
    return _timeInfo;
  }

  void setFirstInit() {
    print(isFirstInit);
    isFirstInit = !isFirstInit;
  }

  String get getBgImages {
    //print(_bgList);
    return _bgList![getBgCount];
  }

  void setBgCounter() {
    _bgCounter += 1;
    notifyListeners();
  }

  void clearBgCounter() {
    _bgCounter = 0;
    notifyListeners();
  }

  int get getBgCount => _bgCounter;

  List<String> get _getBgList => _bgList!;
  GameState get state => _state!;
  bool get getFinishCard => _isFinishedCard;
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
