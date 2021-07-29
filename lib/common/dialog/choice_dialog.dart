import 'package:flutter/material.dart';
import 'package:workout_timer/common/text.dart';

class ChoiceAction {
  final String text;
  final void Function() callback;

  ChoiceAction(this.text, this.callback);
}

Future<void> showChoiceDialog(
  BuildContext context, {
  String title = 'Actions',
  required Iterable<ChoiceAction> actions,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(title),
        children: actions
            .map(
              (action) => SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  action.callback();
                },
                child: Text(
                  action.text,
                  style: AppTextStyles.body.getStyleFor(5),
                ),
              ),
            )
            .toList(),
      );
    },
  );
}
