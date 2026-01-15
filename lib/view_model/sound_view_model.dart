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

  Future<void> eventMusic(String path) async {
    final eventPlayer = AudioPlayer();

    try {
      await eventPlayer.setAsset(path);

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
