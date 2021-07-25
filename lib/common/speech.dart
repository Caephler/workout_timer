import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService(_) {
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.5);
  }

  FlutterTts _tts = FlutterTts();
  static TtsService instance = TtsService(0);

  Future<dynamic> speak(String text) async {
    var result = await _tts.speak(text);
    return result;
  }
}
