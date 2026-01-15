// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/core/constants/app_constants.dart';
import 'package:flutter_memory_game/view/new_game_alert.dart';
import 'package:flutter_memory_game/core/constants/game_img_constants.dart';
import 'package:flutter_memory_game/core/constants/navigation_constants.dart';
import 'package:flutter_memory_game/core/local_storage/local_storage_manager.dart';
import 'package:flutter_memory_game/core/navigation/navigation_service.dart';
import 'package:flutter_memory_game/core/notifier/timeState_provider.dart';
import 'package:flutter_memory_game/view/pause_button_menu_dialog.dart';
import 'package:flutter_memory_game/view_model/sound_view_model.dart';
import 'package:provider/provider.dart';

//-- GameState Variables -- //
enum GameState { empty, loading, completed, error }

class GameViewModel extends ChangeNotifier {
  late NavigationService _navigation;
  late LocalStorageManager _storageManager;
  late GameState? _state;

  // -- Game Logic Variables - //
  bool isFirstInit = true;
  late bool _isFinishedCard;
  late bool _isMatchedCard;
  late bool _isAlertOpen;

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
    _isAlertOpen = false;

    _randomCardCount = 0;
    _matchCount = 0;
    _tries = 0;
    _score = 0;
    _highscore = 50;
    _timeInfo = 0;
    _peekCardsClickCount = 0;
    _currentStage = 0;

    _totalImageCount = 133;
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
      _imageList = List.generate(
        _totalImageCount,
        (i) => "assets/game_card_png/$i.png",
      );
      _imageList!.shuffle();
    } catch (e) {
      print({"add card_images error": e});
    }
  }

  void loadBgImageList() {
    try {
      _bgImagesList!.clear();
      _bgImagesList = List.generate(
        _totalBgImageCount,
        (i) => "assets/game_bg_jpeg/bg$i.jpeg",
      );
    } catch (e) {
      print({"add _bgImages error": e});
    }
  }

  void loadBgList() {
    loadBgImageList();

    try {
      _bgList!.clear();
      _bgList = List.generate(
        _totalBgImageCount,
        (i) => "assets/game_bg_jpeg/bg$i.jpeg",
      );
    } catch (e) {
      print({"add _bgsImages error": e});
    }
  }

  void loadGameCardList() {
    gameCard!.clear();
    gameCard!.shuffle();
    gameCard = List.generate(
      _cardList!.length,
      (index) => GameImgConstants.hiddenCardPng,
    );
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
    if (!context.mounted) return;
    final timerProv = Provider.of<TimerProvider>(context, listen: false);
    setFirstInit();
    if (timerProv.getTimeState == TimeState.timerFinish ||
        timerProv.getTimeState == TimeState.timerReset ||
        timerProv.getTimeState == TimeState.timerEmpty) {
      arrayClears();

      generateRandomImgList();

      loadBgList();

      loadGameCardList();

      generateDefaultLists();
    } else {}
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
    setAngleArr(direction * pi, index);
    notifyListeners();
  }

  /*  print({
                "match": readGameViewCtx.isMatchedCard,
                "matchL": readGameViewCtx.matchCheck!.length,
                "gameC": readGameViewCtx.gameCard
              }); */

  void clickCard(
    int index,
    BuildContext context,
    SoundViewModel soundProv,
  ) async {
    if (gameCard![index] == GameImgConstants.hiddenCardPng &&
        _matchCheck!.length < 2) {
      openGameCard(index, soundProv);
      try {
        final int index0 = _matchCheck![0].keys.first;
        if (_matchCheck!.length == 1) {
          String path1 =
              "sounds/events/${AppConstants.eventSoundList[index0 > 89 ? index0 - 45 : index0]}";
          soundProv.eventMusic(path1);
        }
      } catch (e) {
        print('Event soundW0 error: $e');
      }

      setTries();
      notifyListeners();
      if (_matchCheck!.length == 2) {
        final int index1 = _matchCheck![1].keys.first;
        isMatchCard(soundProv);
        try {
          String path1 =
              "sounds/events/${AppConstants.eventSoundList[index1 > 89 ? index1 - 45 : index1]}";
          soundProv.eventMusic(path1);
        } catch (e) {
          print('Event soundXW1 error: $e');
        }
        if (isMatchedCard) {
          setScore = 100;
          setMatchCount = 1;

          _matchCheck!.clear();
          notifyListeners();
        } else {
          closeGameCard(soundProv);
          notifyListeners();
        }
      }
    } else {
      return;
    }

    allCardIsFinish();

    if (getFinishCard) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (!context.mounted) return;
        nextStageAlert(context);
      });
      notifyListeners();
    } else {
      return;
    }
    notifyListeners();
  }

  void openGameCard(int index, SoundViewModel soundProv) async {
    flipGameCard(1, index);
    gameCard![index] = _cardList![index];

    _matchCheck!.add({index: _cardList![index]});

    notifyListeners();
  }

  void borderAnimate(
    int i0,
    int i1,
    int count,
    Color color,
    double borderW,
    SoundViewModel soundProv,
  ) {
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
        borderAnimate(
          i0,
          i1,
          count + 1,
          color,
          Random().nextDouble() * 0.114,
          soundProv,
        );
      });
      notifyListeners();
    });
    notifyListeners();
  }

  void closeGameCard(SoundViewModel soundProv) {
    Color color = const Color.fromARGB(255, 255, 17, 0);
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;

    Future.delayed(const Duration(milliseconds: 500), () {
      borderAnimate(
        index0,
        index1,
        0,
        color,
        Random().nextDouble() * 0.234,
        soundProv,
      );

      soundProv.eventMusic("sounds/error.mp3");
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
      _cardList!.length,
      (index) => _cardList!.elementAt(index),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      closeAllGameCard();
      _matchCheck!.clear();
    });
    notifyListeners();
  }

  void closeAllGameCard() {
    gameCard!.clear;

    gameCard = List.generate(
      _cardList!.length,
      (index) => GameImgConstants.hiddenCardPng,
    );
    notifyListeners();
  }

  void isMatchCard(SoundViewModel soundProv) {
    final int index0 = _matchCheck![0].keys.first;
    final int index1 = _matchCheck![1].keys.first;
    Color color = const Color.fromARGB(255, 0, 255, 42);

    if (_matchCheck![0].values.first == _matchCheck![1].values.first) {
      isMatchedCard = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        borderAnimate(
          index0,
          index1,
          0,
          color,
          Random().nextDouble() * 0.222,
          soundProv,
        );
        soundProv.eventMusic("sounds/correctx3.mp3");
      });
    } else {
      isMatchedCard = false;
    }
    notifyListeners();
  }

  void restartGame(BuildContext context) {
    final timerProv = Provider.of<TimerProvider>(context, listen: false);

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

    // Timer reset
    timerProv.stopTimer(context, reset: true);
    timerProv.setIsActiveTimer = true;

    _animationAngleArr = [];
    _cardBorderColors = [];
    _cardBorderWidth = [];

    _pageOpacity = 0;

    notifyListeners();

    Future.microtask(() {
      if (!context.mounted) return;
      _navigation.navigateToPageClear(path: NavigationConstants.gameView);
    });
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
    if (!context.mounted) return;
    print("nextStage alert");
    NewGameAlertDialog alert = NewGameAlertDialog(
      score: getScore,
      tries: getTries,
      content: "WELL DONE",
      title: "STAGE $getStage",
      menuButtonFunction: () {
        print("MENU BUTTON PRESSED");
        _navigation.navigateToPageClear(
          path: NavigationConstants.homeView,
          data: [],
        );
        _isAlertOpen == false;
      },
      retryButtonFunction: () {
        print("RETRY BUTTON PRESSED");
        restartGame(context);
        _isAlertOpen == false;
      },
      nextButtonFunction: () {
        print("NEXT BUTTON PRESSED");
        restartGame(context);
        _isAlertOpen == false;
      },
    );
    if (_isAlertOpen == false) {
      _isAlertOpen = true;
      await showDialog(
        barrierDismissible: false,
        barrierColor: const Color(0x66000000),
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ).then((value) => _isAlertOpen = false);
    }

    notifyListeners();
  }

  Future<void> pauseGameAlert(BuildContext context) async {
    if (!context.mounted) return;
    final timerProv = Provider.of<TimerProvider>(context, listen: false);
    print("Pause alert");
    PauseButtonMenuDialog alert = PauseButtonMenuDialog(
      continueBtnFunction: () {
        _navigation.navigateToPageClear(
          path: NavigationConstants.gameView,
          data: [],
        );
        timerProv.setTimeState = TimeState.timerActive;
        _isAlertOpen = false;
      },
      soundBtnFunction: () {},
      newGameButtonFunction: () {
        if (!context.mounted) return;
        timerProv.stopTimer(context, reset: true);

        navigateToPageClear(NavigationConstants.homeView);
        restartGame(context);
        navigateToPageClear(NavigationConstants.gameView);
        _isAlertOpen = false;
      },
      menuButtonFunction: () {
        timerProv.stopTimer(context, reset: true);

        navigateToPageClear(NavigationConstants.homeView);
        _isAlertOpen = false;
      },
    );
    if (_isAlertOpen == false) {
      _isAlertOpen = true;
      await showDialog(
        barrierDismissible: false,
        barrierColor: const Color(0x66000000),
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ).then((value) => _isAlertOpen = false);
    }

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
    _animationAngleArr = List.generate(_cardList?.length ?? 0, (index) => 0.0);
  }

  void setCardBorderColor() {
    _cardBorderColors = List.generate(
      _cardList?.length ?? 0,
      (index) => const Color(0xFFB2FEFA),
    );
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
  double getAngleArr(int index) {
    if (_animationAngleArr == null || index >= _animationAngleArr!.length) {
      return 0.0;
    }
    return _animationAngleArr![index];
  }

  Color getCardBorderColors(int index) {
    if (_cardBorderColors.isEmpty || index >= _cardBorderColors.length) {
      return Colors.transparent;
    }
    return _cardBorderColors[index];
  }

  double getCardBorderWidth(int index) {
    if (_cardBorderWidth.isEmpty || index >= _cardBorderWidth.length) {
      return 0.0;
    }
    return _cardBorderWidth[index];
  }
}
