import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_timer/common/validators.dart';
import 'dialog.dart';

Future<void> showDurationDialog(
  BuildContext context, {
  Duration initialValue = const Duration(),
  String title = 'Duration Input',
  String? helpText,
  void Function(Duration value)? onOk,
  void Function()? onCancel,
  Iterable<Validator<Duration>>? validators,
}) {
  return showDialogOf<Duration>(
    context,
    title: title,
    defaultValue: initialValue,
    validators: validators,
    onCancel: onCancel,
    onOk: onOk,
    helpText: helpText,
    buildContent: (state, commitChange) {
      Duration duration = state.value ?? Duration();
      int mins = duration.inMinutes;
      int seconds = duration.inSeconds.remainder(60);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                value: mins,
                minValue: 0,
                maxValue: 180,
                textMapper: (value) => value + ' m',
                onChanged: (value) => state.didChange(
                  Duration(
                    minutes: value,
                    seconds: seconds,
                  ),
                ),
              ),
              NumberPicker(
                value: seconds,
                minValue: 0,
                maxValue: 59,
                textMapper: (value) => value + ' s',
                onChanged: (value) => state.didChange(
                  Duration(
                    minutes: mins,
                    seconds: value,
                  ),
                ),
              ),
            ],
          ),
          state.hasError
              ? Text(
                  state.errorText ?? 'Error',
                )
              : SizedBox.shrink(),
        ],
      );
    },
  );
}
