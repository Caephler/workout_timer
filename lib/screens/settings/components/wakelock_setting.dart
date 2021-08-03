import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/screens/settings/components/switch_setting.dart';

class WakelockSetting extends StatelessWidget {
  const WakelockSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchSetting(
      defaultValue: true,
      getter: SharedPreferencesService.instance.getWakelockSetting,
      setter: SharedPreferencesService.instance.setWakelockSetting,
      name: 'Screen On During Workout',
      description:
          'Whether the screen will remain turned on during the workout',
    );
  }
}
