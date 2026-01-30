import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  // Pre-load sounds if needed, but for small assets play is fine.
  
  static Future<void> playTick() async {
    // Note: For rapid ticking, you might need a pool of players or Soundpool package.
    // For simple 1-sec ticks, this is okay.
    await _player.stop();
    await _player.play(AssetSource('audio/tick.wav'), volume: 0.5);
  }

  static Future<void> playReveal() async {
    await _player.stop();
    await _player.play(AssetSource('audio/reveal.wav'));
  }

  static Future<void> playWin() async {
    await _player.stop();
    await _player.play(AssetSource('audio/win.wav'));
  }
}
