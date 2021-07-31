import 'package:audioplayers/audioplayers.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';

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

  Future<void> playBlip() async {
    bool shouldPlay = await SharedPreferencesService.instance.getBeepSetting();
    if (shouldPlay) {
      _player.play('blip_countdown.wav');
    }
  }

  Future<void> playFinishBlip() async {
    bool shouldPlay = await SharedPreferencesService.instance.getBeepSetting();
    if (shouldPlay) {
      _player.play('blip_finish.wav');
    }
  }
}
