import 'package:flutter/material.dart';

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
                child: Text(action.text),
              ),
            )
            .toList(),
      );
    },
  );
}
