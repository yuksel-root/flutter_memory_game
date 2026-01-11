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

  Future<void> eventMusic(int imgIndex) async {
    final eventPlayer = AudioPlayer();
    try {
      await eventPlayer.setAsset(AppConstants.soundListPath[imgIndex]);
      await eventPlayer.play();

      await Future.delayed(const Duration(milliseconds: 5));
    } catch (e) {
      debugPrint('Event sound error: $e');
    } finally {
      await eventPlayer.dispose();
    }
  }

  Future<void> stopMusic() async {
    await _backgroundPlayer.stop();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
