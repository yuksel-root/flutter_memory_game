class Game {
  static const String hiddenCardPng = 'assets/images/hidden.png';
  static const String circlePng = "assets/images/circle.png";
  static const String trianglePng = "assets/images/triangle.png";
  static const String hearthPng = "assets/images/heart.png";
  static const String starPng = "assets/images/star.png";

  int tries = 0;
  int score = 0;
  int cardCount = 8;

  List<String>? gameImg;
  List<Map<int, String>> matchCheck = [];

  final List<String> cardList = [
    circlePng,
    trianglePng,
    hearthPng,
    starPng,
    circlePng,
    trianglePng,
    hearthPng,
    starPng,
    circlePng,
    trianglePng,
    hearthPng,
    starPng,
  ];

  void initGame() {
    tries = 0;
    score = 0;
    cardCount = cardList.length;
    cardList.shuffle();
    gameImg = List.generate(cardCount, (index) => hiddenCardPng);
  }
}
