import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_timer/common/validators.dart';
import 'dialog.dart';

Future<void> showNumberDialog(
  BuildContext context, {
  int initialValue = 0,
  int min = 0,
  int max = 10,
  String title = 'Integer Input',
  String? helpText,
  void Function(int value)? onOk,
  void Function()? onCancel,
  Iterable<Validator<int>>? validators,
}) {
  return showDialogOf<int>(
    context,
    title: title,
    defaultValue: initialValue,
    validators: validators,
    onCancel: onCancel,
    onOk: onOk,
    helpText: helpText,
    buildContent: (state, commitChange) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberPicker(
            value: state.value ?? 0,
            minValue: min,
            maxValue: max,
            onChanged: (value) => state.didChange(value),
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
