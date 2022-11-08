class Game {
  final String hiddenCardpath = 'assets/images/hidden.png';

  int tries = 0;
  int score = 0;
  int cardCount = 8;

  List<String>? gameImg;
  List<Map<int, String>> matchCheck = [];

  final List<String> cardList = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
  ];

  void initGame() {
    tries = 0;
    score = 0;
    cardCount = 8;
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
