import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/text.dart';

class TTSSetting extends StatefulWidget {
  const TTSSetting({Key? key}) : super(key: key);

  @override
  State<TTSSetting> createState() => _TTSSettingState();
}

class _TTSSettingState extends State<TTSSetting> {
  bool value = true;

  @override
  void initState() {
    super.initState();

    SharedPreferencesService.instance.ready.then((ready) {
      if (ready) {
        setState(() {
          value = SharedPreferencesService.instance.getTtsSetting();
        });
      }
    });
  }

  Future<void> setValue(bool newValue) async {
    setState(() => {value = newValue});

    SharedPreferencesService.instance.setTtsSetting(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workout Announcer',
                style:
                    AppTextStyles.display.getStyleFor(4, color: Colors.black87),
              ),
              Text(
                'Whether the announcer will announce your exercise',
                style: AppTextStyles.body.getStyleFor(5, color: Colors.black54),
              )
            ],
          ),
        ),
        SizedBox(width: 32.0),
        Switch(
          value: value,
          onChanged: setValue,
        ),
      ],
    );
  }
}
