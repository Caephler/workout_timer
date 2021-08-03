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

  Future<bool> getTtsSetting() async {
    await ready;
    return _prefs.getBool('tts_setting') ?? true;
  }

  Future<void> setTtsSetting(bool value) async {
    await ready;
    _prefs.setBool('tts_setting', value);
  }

  Future<bool> getWakelockSetting() async {
    await ready;
    return _prefs.getBool('wakelock_setting') ?? true;
  }

  Future<void> setWakelockSetting(bool value) async {
    await ready;
    _prefs.setBool('wakelock_setting', value);
  }

  Future<bool> getHasBoughtAdRemoval() async {
    await ready;
    return _prefs.getBool('ads_removed') ?? false;
  }

  Future<void> setHasBoughtAdRemoval(bool value) async {
    await ready;
    _prefs.setBool('ads_removed', value);
  }

  Future<bool> getBeepSetting() async {
    await ready;
    return _prefs.getBool('beep_setting') ?? true;
  }

  Future<void> setBeepSetting(bool value) async {
    await ready;
    _prefs.setBool('beep_setting', value);
  }
}
