import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/screens/settings/components/switch_setting.dart';

class BeepSetting extends StatelessWidget {
  const BeepSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchSetting(
      defaultValue: true,
      getter: SharedPreferencesService.instance.getBeepSetting,
      setter: SharedPreferencesService.instance.setBeepSetting,
      name: 'Countdown Beeps',
      description:
          'Whether a series of beeps will play when an exercise is ending',
    );
  }
}
