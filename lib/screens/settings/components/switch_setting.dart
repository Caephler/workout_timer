import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/text.dart';

class SwitchSetting extends StatefulWidget {
  const SwitchSetting({
    Key? key,
    required this.defaultValue,
    required this.getter,
    required this.setter,
    required this.name,
    this.description,
  }) : super(key: key);

  final bool defaultValue;
  final Future<bool> Function() getter;
  final Future<void> Function(bool value) setter;
  final String name;
  final String? description;

  @override
  State<SwitchSetting> createState() =>
      _SwitchSettingState(value: defaultValue);
}

class _SwitchSettingState extends State<SwitchSetting> {
  _SwitchSettingState({required this.value});

  bool value = true;

  @override
  void initState() {
    super.initState();

    widget.getter().then((isSet) {
      setState(() {
        value = isSet;
      });
    });
  }

  Future<void> setValue(bool newValue) async {
    setState(() => {value = newValue});

    return widget.setter(newValue);
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
                widget.name,
                style:
                    AppTextStyles.display.getStyleFor(4, color: Colors.black87),
              ),
              Text(
                widget.description ?? '',
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
