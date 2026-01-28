import 'package:flutter/foundation.dart';
import 'package:flutter_memory_game/core/constants/app_constants.dart';
import 'package:just_audio/just_audio.dart';

class SoundViewModel extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  SoundViewModel() {}

  final AudioPlayer _backgroundPlayer = AudioPlayer();

  void initBackgroundMusic() async {
    await _backgroundPlayer.setAsset('assets/sounds/backgrounds/d_gray.mp3');
    _backgroundPlayer.setLoopMode(LoopMode.one);
    await _backgroundPlayer.play();
  }

  Future<void> eventMusic(int cardIndex, List<String> cardList) async {
    final eventPlayer = AudioPlayer();

    try {
      String cardPath = cardList[cardIndex];

      final regex = RegExp(r'(\d+)\.png');
      final match = regex.firstMatch(cardPath);
      int cardId = 0;
      if (match != null) {
        cardId = int.parse(match.group(1)!);
      }

      String path = "sounds/events/${AppConstants.eventSoundList[cardId]}";
      final assetPath = path.startsWith('assets/') ? path : 'assets/$path';

      //print("Playing card event sound: $assetPath");

      await eventPlayer.setAsset(assetPath);

      eventPlayer.play();

      await Future.delayed(const Duration(milliseconds: 1500), () {
        eventPlayer.stop();
        eventPlayer.dispose();
      });
    } catch (e) {
      print('Event sound error: $e');
    }
  }

  Future<void> pathMusic(String path) async {
    final eventPlayer = AudioPlayer();

    try {
      final assetPath = 'assets/$path';
      await eventPlayer.setAsset(assetPath);
      // print(assetPath);

      eventPlayer.play();

      await Future.delayed(const Duration(seconds: 1));

      await eventPlayer.stop();
    } catch (e) {
      print('Event sound error: $e');
    } finally {
      await eventPlayer.dispose();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
