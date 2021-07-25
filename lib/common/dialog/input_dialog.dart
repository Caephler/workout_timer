import 'package:flutter/material.dart';
import 'package:workout_timer/common/validators.dart';

import 'dialog.dart';

Future<void> showInputDialog(
  BuildContext context, {
  String title = 'Input',
  String defaultValue = '',
  String? helpText,
  void Function(String value)? onOk,
  void Function()? onCancel,
  Iterable<Validator<String>>? validators,
}) async {
  showDialogOf<String>(context,
      defaultValue: defaultValue,
      title: title,
      helpText: helpText,
      onOk: onOk,
      onCancel: onCancel,
      validators: validators, buildContent: (state, commitChange) {
    return TextFormField(
      initialValue: state.value,
      validator: (value) {
        return state.errorText;
      },
      autofocus: true,
      decoration: const InputDecoration(
        errorMaxLines: 3,
      ),
      onChanged: (value) {
        state.didChange(value);
      },
      onEditingComplete: () {
        commitChange();
      },
    );
  });
}
