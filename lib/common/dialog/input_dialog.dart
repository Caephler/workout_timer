import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/text.dart';
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
  TextEditingController controller = TextEditingController(text: defaultValue);
  showDialogOf<String>(
    context,
    defaultValue: defaultValue,
    title: title,
    helpText: helpText,
    onOk: onOk,
    onCancel: onCancel,
    validators: validators,
    buildContent: (state, commitChange) {
      return TextFormField(
        controller: controller,
        validator: (value) {
          return state.errorText;
        },
        autofocus: true,
        decoration: InputDecoration(
          errorMaxLines: 3,
          errorStyle: AppTextStyles.body.getStyleFor(5, color: Colors.red),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
              state.didChange('');
            },
            icon: Icon(
              LineIcons.times,
            ),
          ),
        ),
        onChanged: (value) {
          state.didChange(value);
        },
        onEditingComplete: () {
          commitChange();
        },
      );
    },
  );
}
