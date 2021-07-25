import 'package:audioplayers/audioplayers.dart';

class AudioService {
  late final AudioCache _player;
  static AudioService instance = AudioService(0);

  AudioService(_) {
    _player = AudioCache();
    _player.loadAll([
      'blip_countdown.wav',
      'blip_finish.wav',
    ]);
  }

  void play(String path) {
    _player.play(path);
  }

  void playBlip() {
    _player.play('blip_countdown.wav');
  }

  void playFinishBlip() {
    _player.play('blip_finish.wav');
  }
}
