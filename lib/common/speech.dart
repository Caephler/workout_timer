import 'package:flutter_tts/flutter_tts.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';

class TtsService {
  TtsService._() {
    _tts.setSpeechRate(0.5);
    _tts.setVolume(1.0);
  }

  FlutterTts _tts = FlutterTts();
  static TtsService instance = TtsService._();

  Future<dynamic> speak(String text) async {
    bool shouldSpeak = await SharedPreferencesService.instance.getTtsSetting();
    if (!shouldSpeak) {
      return null;
    }
    var result = await _tts.speak(text);
    return result;
  }
}
