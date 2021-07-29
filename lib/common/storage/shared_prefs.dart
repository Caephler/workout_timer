import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._() {
    ready = Future<bool>(() async {
      await this._init();
      return true;
    });
  }

  static SharedPreferencesService instance = SharedPreferencesService._();

  _init() {
    return SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  late SharedPreferences _prefs;
  late Future<bool> ready;

  bool getTtsSetting() {
    return _prefs.getBool('tts_setting') ?? true;
  }

  setTtsSetting(bool value) {
    _prefs.setBool('tts_setting', value);
  }
}
