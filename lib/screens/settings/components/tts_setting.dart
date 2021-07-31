import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/screens/settings/components/switch_setting.dart';

class TTSSetting extends StatelessWidget {
  const TTSSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchSetting(
      defaultValue: true,
      getter: SharedPreferencesService.instance.getTtsSetting,
      setter: SharedPreferencesService.instance.setTtsSetting,
      name: 'Workout Announcer',
      description: 'Whether the announcer will annouce your exercise',
    );
  }
}
